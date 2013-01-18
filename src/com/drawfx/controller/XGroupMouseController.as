/*
Copyright (c) 2013 Dave Jackson

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/		

package com.drawfx.controller
{
	import com.anywarefx.command.XUpdateCollectionCommand;
	import com.anywarefx.controller.XMouseController;
	import com.anywarefx.view.IView;
	import com.drawfx.model.IBoundedModel;
	import com.drawfx.model.XBoundsModel;
	import com.drawfx.model.XGroupModel;
	import com.drawfx.view.XComposite;
	import com.drawfx.view.XDrawing;
	import com.drawfx.view.XGroup;
	import com.drawfx.view.XRubberBand;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;
	import mx.core.DragSource;
	import mx.core.UIComponent;
	import mx.managers.DragManager;
	
	
	public class XGroupMouseController extends XMouseController
	{
		override public function addUserEventListeners(view:IView):void
		{
			if (view is XGroup)
			{
				super.addUserEventListeners(view);
			}
		}

		override public function removeUserEventListeners(view:IView):void
		{
			if (view is XGroup)
			{
				super.removeUserEventListeners(view);
			}
		}
		

		override protected function onMouseMove(event:MouseEvent):void
		{
			if (event.buttonDown)
			{
				var group:XGroup = XGroup.getGroup(event.currentTarget as UIComponent);
				if (group != null)
				{
					event.stopPropagation();
					if (isResizeTarget(group, event))
					{
						startResize(group, event);
					}
					else
					{
						startMove(group, event);
					}
				}
			}
		}
		
		
		override protected function onMouseClick(event:MouseEvent):void
		{
			var group:XGroup = XGroup.getGroup(event.target as UIComponent);
			if (group != null)
			{
				event.stopPropagation();
				if (group.currentState == "unselected")
				{
					if (!event.ctrlKey)
					{
						selectionManager.clearSelections();
					}
					selectionManager.addSelection(group);
				}
				else if (group.currentState == "selected")
				{
					if (event.ctrlKey)
					{
						selectionManager.removeSelection(group);
					}
				}
			}
		}
		
		
		private function isResizeTarget(group:XGroup, event:MouseEvent):Boolean
		{
			var target:UIComponent = event.target as UIComponent;
			while (target !== group.resizeHandle && target != null && target.parent != null)
			{
				target = target.parent as UIComponent;
			}
			return (target === group.resizeHandle);
		}
		
		
		private function startMove(group:XGroup, event:MouseEvent):void
		{
			var parent:XComposite = XDrawing.getParent(group.parent as UIComponent);
			if (parent != null)
			{
				var offset:Point = new Point();
				offset.x = group.contentMouseX;
				offset.y = group.contentMouseY;
				
				var model:XGroupModel = group.model as XGroupModel;
				
				var source:DragSource = new DragSource();
				source.addData(parent, "parent");
				source.addData(model, "model");
				source.addData(group, "view");
				source.addData(offset, "offset");
				
				DragManager.doDrag(group, source, event);
			}
		}
		
		
		private function startResize(group:XGroup, event:MouseEvent):void
		{
			var drawing:XDrawing = XDrawing.getDrawing(group);
			if (drawing != null)
			{
				var rubberBand:XRubberBand = drawing.rubberBand;
				if (rubberBand.startPoint.x == -1 && rubberBand.startPoint.y == -1)
				{
					var bounds:XBoundsModel = (group.model as XGroupModel).bounds;
					rubberBand.currentPoint = new Point(event.stageX, event.stageY);
					rubberBand.startPoint = new Point(event.stageX, event.stageY);
					
					rubberBand.x = bounds.x;
					rubberBand.y = bounds.y;
					rubberBand.width = bounds.width;
					rubberBand.height = bounds.height;
					rubberBand.visible = true;
					rubberBand.depth = drawing.numElements;
					
					drawing.systemManager.addEventListener(MouseEvent.MOUSE_MOVE, onResizeRubberBand, true);
					drawing.systemManager.addEventListener(MouseEvent.MOUSE_UP, onResizeComplete, true);
				}
			}
		}
		
		
		private function onResizeRubberBand(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			
			var drawing:XDrawing = XDrawing.getDrawing(event.target as UIComponent);
			if (drawing != null)
			{
				var rubberBand:XRubberBand = drawing.rubberBand;
				var current:Point = rubberBand.currentPoint = new Point(event.stageX, event.stageY);
				var start:Point = rubberBand.startPoint;
				
				rubberBand.width = rubberBand.width + current.x - start.x;
				rubberBand.height = rubberBand.height + current.y - start.y;  
				
				start.x = current.x;
				start.y = current.y;
			}
		}
		
		
		private function onResizeComplete(event:MouseEvent):void
		{
			event.stopImmediatePropagation();		
			
			var drawing:XDrawing = XDrawing.getDrawing(event.target as UIComponent);
			if (drawing != null)
			{
				var rubberBand:XRubberBand = drawing.rubberBand;
				var dimensions:Point = new Point(rubberBand.width, rubberBand.height);
				
				var items:ArrayCollection = new ArrayCollection();
				for each (var selection:IView in selectionManager.selections)
				{
					if (selection.model is IBoundedModel)
					{
						items.addItem((selection.model as IBoundedModel).bounds);
					}
				}
				var command:XUpdateCollectionCommand = new XUpdateCollectionCommand(drawing, items, "dimensions", dimensions);
				context.execute(command);
				
				rubberBand.x = 0;
				rubberBand.y = 0;
				rubberBand.width = 0;
				rubberBand.height = 0;
				rubberBand.visible = false;
				rubberBand.startPoint = new Point(-1, -1);
				
				drawing.systemManager.removeEventListener(MouseEvent.MOUSE_MOVE, onResizeRubberBand, true);
				drawing.systemManager.removeEventListener(MouseEvent.MOUSE_UP, onResizeComplete, true);
			}
		}
	}
}
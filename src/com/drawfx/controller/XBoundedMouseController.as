/*
Copyright (c) 2013 - 2015 Dave Jackson

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
	import com.anywarefx.view.XSelectableView;
	import com.anywarefx.view.XView;
	import com.drawfx.model.IBoundedModel;
	import com.drawfx.model.XBoundsModel;
	import com.drawfx.view.IBoundedView;
	import com.drawfx.view.XComposite;
	import com.drawfx.view.XDrawing;
	import com.drawfx.view.XRubberBand;
	import com.drawfx.view.XShape;
	import com.drawfx.view.XTextBox;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;
	import mx.core.DragSource;
	import mx.core.UIComponent;
	import mx.managers.DragManager;
	
	
	public class XBoundedMouseController extends XMouseController
	{
		override public function addUserEventListeners(view:IView):void
		{
			if (view is IBoundedView)
			{
				super.addUserEventListeners(view);
			}
		}
		
		override public function removeUserEventListeners(view:IView):void
		{
			if (view is IBoundedView)
			{
				super.removeUserEventListeners(view);
			}
		}
		
		
		override protected function onMouseMove(event:MouseEvent):void
		{
			if (event.buttonDown)
			{
				var view:XView = getView(event.currentTarget as UIComponent);
				if (view != null)
				{
					if (isResizeTarget(view as IBoundedView, event))
					{
						event.stopPropagation();
						startResize(view, event);
					}
					else
					{
						startMove(view, event);
					}
				}
			}
		}
		
		
		override protected function onMouseClick(event:MouseEvent):void
		{
			var view:XSelectableView = getView(event.currentTarget as UIComponent) as XSelectableView;
			if (view != null)
			{
				event.stopPropagation();
				if (view.currentState == "unselected")
				{
					if (!event.ctrlKey)
					{
						selectionManager.clearSelections();
					}
					selectionManager.addSelection(view);
				}
				else if (view.currentState == "selected")
				{
					if (event.ctrlKey)
					{
						selectionManager.removeSelection(view);
					}
					else if (view is XShape || view is XTextBox)
					{
						view.currentState = "input";
					}
				}
			}
		}
		
		
		private function isResizeTarget(view:IBoundedView, event:MouseEvent):Boolean
		{
			var target:UIComponent = event.target as UIComponent;
			while (target !== view.resizeHandle && target != null && target.parent != null)
			{
				target = target.parent as UIComponent;
			}
			return (target === view.resizeHandle);
		}
		
		
		private function startMove(view:XView, event:MouseEvent):void
		{
			var parent:XComposite = XDrawing.getParent(view.parent as UIComponent);
			if (parent != null)
			{
				var offset:Point = new Point();
				offset.x = view.contentMouseX;
				offset.y = view.contentMouseY;
				
				var model:IBoundedModel = view.model as IBoundedModel;
				
				var source:DragSource = new DragSource();
				source.addData(parent, "parent");
				source.addData(model, "model");
				source.addData(view, "view");
				source.addData(offset, "offset");
				
				DragManager.doDrag(view, source, event);
			}
		}
		
		
		private function startResize(view:XView, event:MouseEvent):void
		{
			var drawing:XDrawing = XDrawing.getDrawing(view as UIComponent);
			if (drawing != null)
			{
				var rubberBand:XRubberBand = drawing.rubberBand;
				if (rubberBand.startPoint.x == -1 && rubberBand.startPoint.y == -1)
				{
					var bounds:XBoundsModel = (view.model as IBoundedModel).bounds;
					rubberBand.currentPoint = new Point(event.stageX, event.stageY);
					rubberBand.startPoint = new Point(event.stageX, event.stageY);
					
					var position:Point = view.localToGlobal(new Point());
					position = drawing.globalToContent(position);
					rubberBand.x = position.x;
					rubberBand.y = position.y;
					rubberBand.width = bounds.width;
					rubberBand.height = bounds.height;
					rubberBand.rotationZ = bounds.rotationZ;
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
				
				// FIXME - Account for rotationZ
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
				rubberBand.rotationX = 0;
				rubberBand.rotationY = 0;
				rubberBand.rotationZ = 0;
				rubberBand.scaleX = 1;
				rubberBand.scaleY = 1;
				rubberBand.scaleZ = 1;
				rubberBand.visible = false;
				rubberBand.startPoint = new Point(-1, -1);
				
				drawing.systemManager.removeEventListener(MouseEvent.MOUSE_MOVE, onResizeRubberBand, true);
				drawing.systemManager.removeEventListener(MouseEvent.MOUSE_UP, onResizeComplete, true);
			}
		}
		
		
		private function getView(target:UIComponent):XView
		{
			while (target != null && target.parent != null)
			{
				if (target is IBoundedView && (target as IBoundedView).isEmbedded == false)
				{
					break;
				}
				target = target.parent as UIComponent;
			}
			return target as XView;
		}
	}
}
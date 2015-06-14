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
	import com.anywarefx.command.XSetPropertyCommand;
	import com.anywarefx.controller.XDropController;
	import com.anywarefx.view.IView;
	import com.anywarefx.view.XSelectableView;
	import com.anywarefx.view.XView;
	import com.drawfx.command.XDrawingCommand;
	import com.drawfx.command.XDrawingCommandFactory;
	import com.drawfx.model.IBoundedModel;
	import com.drawfx.model.XBoundsModel;
	import com.drawfx.model.XCompositeModel;
	import com.drawfx.view.XComposite;
	import com.drawfx.view.XDrawing;
	import com.drawfx.view.XStencil;
	
	import flash.geom.Point;
	
	import mx.core.DragSource;
	import mx.core.UIComponent;
	import mx.events.DragEvent;
	import mx.managers.DragManager;
	
	
	public class XCompositeDropController extends XDropController
	{
		override public function addUserEventListeners(view:IView):void
		{
			if (view is XComposite)
			{
				super.addUserEventListeners(view);
			}
		}
		
		override public function removeUserEventListeners(view:IView):void
		{
			if (view is XComposite)
			{
				super.removeUserEventListeners(view);
			}
		}
		
		
		override protected function onDragEnter(event:DragEvent):void
		{
			var source:DragSource = event.dragSource;
			if (event.currentTarget is XDrawing &&
				source.hasFormat("parent") && source.hasFormat("model") && source.hasFormat("offset"))
			{
				DragManager.acceptDragDrop(event.currentTarget as UIComponent);
			}
		}
		
		
		override protected function onDragOver(event:DragEvent):void
		{
			if (event.altKey)
			{
				DragManager.showFeedback(DragManager.COPY);
			}
			else
			{
				DragManager.showFeedback(DragManager.MOVE);
			}
		}
		
		
		override protected function onDragDrop(event:DragEvent):void
		{
			var source:DragSource = event.dragSource;
			var parent:XComposite = source.dataForFormat("parent") as XComposite;
			var model:IBoundedModel = source.dataForFormat("model") as IBoundedModel;
			var offset:Point = source.dataForFormat("offset") as Point;
			if (model != null && offset != null)
			{
				var view:XSelectableView = source.dataForFormat("view") as XSelectableView;
				var position:Point = new Point();
				if (parent is XStencil)
				{
					parent = getDropTarget(view, event.currentTarget as UIComponent);
					position.x = event.localX - offset.x;
					position.y = event.localY - offset.y;
					copyModel(parent.model as XCompositeModel, model, position);
				}
				else
				{
					var target:XComposite = getDropTarget(view, event.currentTarget as UIComponent);
					if (target === parent || target.model === model)
					{
						position.x = parent.mouseX - offset.x;
						position.y = parent.mouseY - offset.y;
						
						if (event.action == DragManager.COPY)
						{
							copyModel(parent.model as XCompositeModel, model, position);
						}
						else if (event.action == DragManager.MOVE)
						{
							moveModel(model, position);
							if (view != null && !view.selected)
							{
								selectionManager.clearSelections();
								selectionManager.addSelection(view);
							}
						}
					}
					else
					{
						position.x = event.localX - offset.x;
						position.y = event.localY - offset.y;
						
						if (event.action == DragManager.COPY)
						{
							copyModel(target.model as XCompositeModel, model, position);
						}
						else if (event.action == DragManager.MOVE)
						{
							model.bounds.position = position;
							
							var removeCommand:XDrawingCommand = XDrawingCommandFactory.createRemoveCommand(parent.model as XCompositeModel, model);
							context.execute(removeCommand);
							
							var addCommand:XDrawingCommand = XDrawingCommandFactory.createAddCommand(target.model as XCompositeModel, model);
							context.execute(addCommand);
						}
					}
				}
			}
		}
		
		
		protected function copyModel(parent:XCompositeModel, model:IBoundedModel, position:Point):void
		{
			var copy:IBoundedModel = model.copy() as IBoundedModel;
			if (copy != null)
			{
				copy.bounds.position = position;
				var command:XDrawingCommand = XDrawingCommandFactory.createAddCommand(parent, copy);
				context.execute(command);
			}
		}
		
		
		protected function moveModel(model:IBoundedModel, position:Point):void
		{
			var bounds:XBoundsModel = model.bounds;
			if (bounds.x != position.x || bounds.y != position.y)
			{
				var command:XSetPropertyCommand = new XSetPropertyCommand(bounds, "position", position);
				context.execute(command);
			}
		}
		
		
		private function getDropTarget(view:XView, target:UIComponent):XComposite
		{
			if (isAncestor(view, target))
			{
				target = view.parent as UIComponent;
			}
			return XDrawing.getParent(target);
		}
		
		
		private function isAncestor(view:XView, target:UIComponent):Boolean
		{
			while (target !== view && target != null && target.parent != null)
			{
				target = target.parent as UIComponent;
			}
			return (target == view);
		}
	}
}
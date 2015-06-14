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
	import com.anywarefx.controller.XDropController;
	import com.anywarefx.view.IView;
	import com.drawfx.command.XDrawingCommand;
	import com.drawfx.command.XDrawingCommandFactory;
	import com.drawfx.model.IBoundedModel;
	import com.drawfx.model.XStencilModel;
	import com.drawfx.view.XComposite;
	import com.drawfx.view.XStencil;
	
	import mx.core.DragSource;
	import mx.core.UIComponent;
	import mx.events.DragEvent;
	import mx.managers.DragManager;
	
	
	public class XStencilDropController extends XDropController
	{
		override public function addUserEventListeners(view:IView):void
		{
			if (view is XStencil)
			{
				super.addUserEventListeners(view);
			}
		}
		
		override public function removeUserEventListeners(view:IView):void
		{
			if (view is XStencil)
			{
				super.removeUserEventListeners(view);
			}
		}
		
		
		override protected function onDragEnter(event:DragEvent):void
		{
			var source:DragSource = event.dragSource;
			if (source.hasFormat("parent") && source.hasFormat("model"))
			{
				DragManager.acceptDragDrop(event.currentTarget as UIComponent);
			}
		}
		
		
		override protected function onDragDrop(event:DragEvent):void
		{
			var source:DragSource = event.dragSource;
			var parent:XComposite = source.dataForFormat("parent") as XComposite;
			var model:IBoundedModel = source.dataForFormat("model") as IBoundedModel;
			if (model != null)
			{
				if (!(parent is XStencil))
				{
					var stencil:XStencil = XStencil.getStencil(event.currentTarget as UIComponent);
					copyModel(stencil.model as XStencilModel, model);
				}
			}
		}
		
		
		protected function copyModel(stencil:XStencilModel, model:IBoundedModel):void
		{
			var copy:IBoundedModel = model.copy() as IBoundedModel;
			if (copy != null)
			{
				var command:XDrawingCommand = XDrawingCommandFactory.createAddCommand(stencil, model);
				context.execute(command);
			}
		}
	}
}
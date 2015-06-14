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

package com.drawfx
{
	import com.anywarefx.XFactory;
	import com.anywarefx.view.IView;
	import com.drawfx.controller.XStencilMouseController;
	import com.drawfx.view.XStencil;
	
	import flash.utils.flash_proxy;
	
	import mx.utils.object_proxy;
	
	use namespace flash_proxy;
	use namespace object_proxy;
	
	
	public class XStencilDocument extends XDrawingDocument
	{
		public function XStencilDocument()
		{
			super();
			var model:* = {
				mouseController: null
			}
			plugin(model);
		}
		
		
		public function get mouseController():XStencilMouseController
		{
			return getProperty("mouseController");
		}
		
		public function set mouseController(value:XStencilMouseController):void
		{
			setProperty("mouseController", value);
		}
		
		
		public function openStencil(name:String, preview:Boolean=false):XStencil
		{
			var view:IView = XFactory.instance.getComponent(name);
			if (view != null)
			{
				views[name] = view;
				view.model = model;
				
				//                addViewListeners(view);
				if (!preview)
				{
					mouseController.addUserEventListeners(view);
				}
			}
			return view as XStencil;
		}
		
		public virtual function closeStencil(name:String):XStencil
		{
			var view:IView = views[name];
			if (view != null)
			{
				delete views[name];
				view.model = null;
				
				//                removeViewListeners(view);
				mouseController.removeUserEventListeners(view);
			}
			return view as XStencil;
		}
		
		
		override protected function initControllers():void
		{
			super.initControllers();
			mouseController = XFactory.instance.getComponent("XStencilMouseController");
			initController(mouseController);
		}
		
		/*
		override protected function onViewAdded(event:XViewUpdateEvent):void
		{
		var view:IView = event.view;
		if (view != null)
		{
		addViewListeners(view);
		selectionManager.removeSelection(view as XView);
		(view as XView).currentState = "unselected";
		}
		}
		*/
	}
}
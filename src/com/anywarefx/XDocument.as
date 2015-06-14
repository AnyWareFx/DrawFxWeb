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

package com.anywarefx
{
	import com.anywarefx.command.XCommandContext;
	import com.anywarefx.controller.XUIController;
	import com.anywarefx.event.XViewUpdateEvent;
	import com.anywarefx.manager.XSelectionManager;
	import com.anywarefx.model.IModel;
	import com.anywarefx.view.IView;
	import com.anywarefx.view.XSelectableView;
	
	import flash.utils.flash_proxy;
	
	import mx.collections.ArrayCollection;
	import mx.utils.object_proxy;
	
	use namespace flash_proxy;
	use namespace object_proxy;
	
	
	[Bindable]
	public class XDocument extends XComponent implements IDocument
	{
		public function XDocument()
		{
			super();
			var model:* = {
				model: null,
				views: {},
				controllers: null,
				context: null,
				selectionManager: null
			};
			plugin(model);
		}
		
		
		public function get model():IModel
		{
			return getProperty("model");
		}
		
		public  function set model(value:IModel):void
		{
			if (model == null)
			{
				setProperty("model", value);
				addModelListeners(model);
			}
		}
		
		
		public function get views():*
		{
			return getProperty("views");
		}
		
		public  function set views(value:*):void
		{
			if (views == null)
			{
				setProperty("views", value);
			}
		}
		
		public function get defaultView():String
		{
			return getProperty("defaultView");
		}
		
		public function set defaultView(value:String):void
		{
			if (defaultView == null)
			{
				setProperty("defaultView", value);
			}
		}
		
		public function openView(name:String):IView
		{
			var view:IView = XFactory.instance.getComponent(name);
			if (view != null)
			{
				views[name] = view;
				view.model = model;
				
				addViewListeners(view);
				setupControllers(view);
			}
			return view;
		}
		
		public function closeView(name:String):IView
		{
			var view:IView = views[name];
			if (view != null)
			{
				delete views[name];
				view.model = null;
				
				removeViewListeners(view);
				tearDownControllers(view);
			}
			return view;
		}
		
		
		[ArrayElementType("com.anywarefx.controller.XUIController")]
		public function get controllers():ArrayCollection
		{
			return getProperty("controllers");
		}
		
		public function set controllers(value:ArrayCollection):void
		{
			if (controllers == null)
			{
				setProperty("controllers", value);
				initControllers();
			}
		}
		
		
		public function get context():XCommandContext
		{
			return getProperty("context");
		}
		
		public function set context(value:XCommandContext):void
		{
			if (context == null)
			{
				setProperty("context", value);
				initControllers();
			}
		}
		
		
		public function get selectionManager():XSelectionManager
		{
			return getProperty("selectionManager");
		}
		
		public function set selectionManager(value:XSelectionManager):void
		{
			if (selectionManager == null)
			{
				setProperty("selectionManager", value);
				initControllers();
			}
		}
		
		
		protected  function initControllers():void
		{
			for each (var controller:XUIController in controllers)
			{
				initController(controller);
			}
		}
		
		
		protected  function initController(controller:XUIController):void
		{
			if (context != null  && selectionManager != null && controller != null)
			{
				controller.context = context;
				controller.selectionManager = selectionManager;
			}
		}
		
		
		protected  function addModelListeners(model:IModel):void
		{
			// override
		}
		
		protected  function removeModelListeners(model:IModel):void
		{
			// override
		}
		
		
		protected  function addViewListeners(view:IView):void
		{
			view.addEventListener(XViewUpdateEvent.VIEW_ADDED, onViewAdded);
			view.addEventListener(XViewUpdateEvent.VIEW_REMOVED, onViewRemoved);
		}
		
		protected  function removeViewListeners(view:IView):void
		{
			view.removeEventListener(XViewUpdateEvent.VIEW_ADDED, onViewAdded);
			view.removeEventListener(XViewUpdateEvent.VIEW_REMOVED, onViewRemoved);
		}
		
		protected  function onViewAdded(event:XViewUpdateEvent):void
		{
			var view:IView = event.view;
			if (view != null)
			{
				setupControllers(view);
				selectionManager.clearSelections();
				selectionManager.addSelection(view as XSelectableView);
			}
		}
		
		protected  function onViewRemoved(event:XViewUpdateEvent):void
		{
			var view:IView = event.view;
			if (view != null)
			{
				tearDownControllers(view);
				selectionManager.removeSelection(view as XSelectableView);
			}
		}
		
		
		protected  function setupControllers(view:IView):void
		{
			for each (var controller:XUIController in controllers)
			{
				controller.addUserEventListeners(view);
			}
		}
		
		protected  function tearDownControllers(view:IView):void
		{
			for each (var controller:XUIController in controllers)
			{
				controller.removeUserEventListeners(view);
			}
		}
		
		// TODO Implement 'save()', 'load()', etc.
	}
}
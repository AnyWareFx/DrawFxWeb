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
	import com.anywarefx.controller.XUIController;
	import com.anywarefx.view.IView;
	import com.anywarefx.view.XView;
	import com.drawfx.model.XBoundsModel;
	import com.drawfx.model.XConstraintsModel;
	import com.drawfx.view.IBoundedView;
	import com.drawfx.view.IConstrainedView;
	import com.drawfx.view.XComposite;
	import com.drawfx.view.XDrawing;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Image;
	import mx.core.UIComponent;
	import mx.events.MoveEvent;
	import mx.events.ResizeEvent;
	
	import assets.Icons;
	
	
	public class XConstraintController extends XUIController
	{
		override public function addUserEventListeners(view:IView):void
		{
			if (view is IConstrainedView)
			{
				super.addUserEventListeners(view);
				view.addEventListener(ResizeEvent.RESIZE, onResize);
				view.addEventListener(MoveEvent.MOVE, onMove);
				
				var locks:ArrayCollection = (view as IConstrainedView).locks;
				for each (var lock:Image in locks)
				{
					lock.addEventListener(MouseEvent.CLICK, onToggleLock);
				}
			}
		}
		
		override public function removeUserEventListeners(view:IView):void
		{
			if (view is IConstrainedView)
			{
				super.removeUserEventListeners(view);
				view.removeEventListener(ResizeEvent.RESIZE, onResize);
				view.removeEventListener(MoveEvent.MOVE, onMove);
				
				var locks:ArrayCollection = (view as IConstrainedView).locks;
				for each (var lock:Image in locks)
				{
					lock.removeEventListener(MouseEvent.CLICK, onToggleLock);
				}
			}
		}
		
		protected virtual function onMove(event:MoveEvent):void
		{
			var view:XView = getView(event.target as UIComponent);
			if (view != null && view is IBoundedView)
			{
				var bounds:XBoundsModel = (view as IBoundedView).bounds;
				if (bounds.x != view.x || bounds.y != view.y)
				{
					var position:Point = new Point(view.x, view.y);
					var command:XSetPropertyCommand = new XSetPropertyCommand(bounds, "position", position);
					context.execute(command);
				}
			}
		}
		
		protected virtual function onResize(event:ResizeEvent):void
		{
			var view:XView = getView(event.target as UIComponent);
			if (view != null && view is IBoundedView)
			{
				var bounds:XBoundsModel = (view as IBoundedView).bounds;
				if (bounds.width != view.width || bounds.height != view.height)
				{
					var dimensions:Point = new Point(view.width, view.height);
					var command:XSetPropertyCommand = new XSetPropertyCommand(bounds, "dimensions", dimensions);
					context.execute(command);
				}
			}
		}
		
		
		private function onToggleLock(event:MouseEvent):void
		{
			var lock:Image = event.target as Image;
			if (lock != null)
			{
				event.stopPropagation();
				var view:XView = getView(lock);
				if (view != null && view is IConstrainedView && view is IBoundedView)
				{
					var command:XSetPropertyCommand;
					var constraints:XConstraintsModel = (view as IConstrainedView).constraints;
					var bounds:XBoundsModel = (view as IBoundedView).bounds;
					var parentBounds:XBoundsModel = getParentBounds(view.parent as UIComponent);
					var property:String = getPropertyName(lock.id);
					if (lock.source == Icons.Locked)
					{
						var bound:String;
						var value:Number = constraints[property];
						command = new XSetPropertyCommand(constraints, property, NaN);
						context.execute(command);
						if (property == "top")
						{
							command = new XSetPropertyCommand(bounds, "y", value);
						}
						else if (property == "left")
						{
							command = new XSetPropertyCommand(bounds, "x", value);
						}
					}
					else
					{
						if (property == "top")
						{
							command = new XSetPropertyCommand(constraints, "top", bounds.y);
						}
						else if (property == "left")
						{
							command = new XSetPropertyCommand(constraints, "left", bounds.x);
						}
						else if (property == "bottom")
						{
							value = parentBounds.height - (bounds.y + bounds.height);
							command = new XSetPropertyCommand(constraints, "bottom", value);
						}
						else if (property == "right")
						{
							value = parentBounds.width - (bounds.x + bounds.width);
							command = new XSetPropertyCommand(constraints, "right", value);
						}
					}
					if (command != null)
					{
						context.execute(command);
					}
				}
			}
		}
		
		
		protected function getPropertyName(identifier:String):String
		{
			return identifier.replace(/_/g, "");
		}
		
		
		private function getView(target:UIComponent):XView
		{
			while (!(target is IConstrainedView) && target != null && target.parent != null)
			{
				target = target.parent as UIComponent;
			}
			return target as XView;
		}
		
		
		private function getParentBounds(view:UIComponent):XBoundsModel
		{
			var parent:XComposite = XDrawing.getParent(view);
			var bounds:XBoundsModel = new XBoundsModel();
			if (parent is IBoundedView)
			{
				bounds.fromJSON(parent["bounds"].toJSON());
			}
			else if (parent is XDrawing)
			{
				bounds.width = parent.width;
				bounds.height = parent.height;
			}
			return bounds;
		}
	}
}
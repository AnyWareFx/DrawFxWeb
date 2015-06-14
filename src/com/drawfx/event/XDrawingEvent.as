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

package com.drawfx.event
{
	import com.anywarefx.event.XEvent;
	import com.anywarefx.model.IModel;
	import com.drawfx.model.XCompositeModel;
	
	
	public class XDrawingEvent extends XEvent
	{
		public static const LINE_ADDED:String = "lineAdded";
		public static const LINE_REMOVED:String = "lineRemoved";
		public static const GROUP_ADDED:String = "groupAdded";
		public static const GROUP_REMOVED:String = "groupRemoved";
		public static const IMAGE_ADDED:String = "imageAdded";
		public static const IMAGE_REMOVED:String = "imageRemoved";
		public static const SHAPE_ADDED:String = "shapeAdded";
		public static const SHAPE_REMOVED:String = "shapeRemoved";
		public static const TEXT_BOX_ADDED:String = "textBoxAdded";
		public static const TEXT_BOX_REMOVED:String = "textBoxRemoved";
		
		private var _parent:XCompositeModel;
		private var _model:IModel;
		
		
		public function XDrawingEvent(type:String, parent:XCompositeModel=null, message:String="", bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, message, bubbles, cancelable);
			_parent = parent;
		}
		
		
		public function get parent():XCompositeModel
		{
			return _parent;
		}
		
		
		public function get model():IModel
		{
			return _model;
		}
		
		public function set model(value:IModel):void
		{
			_model = value;
		}
	}
}
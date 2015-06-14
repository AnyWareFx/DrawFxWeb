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

package com.drawfx.model
{
	import com.anywarefx.model.XModel;
	
	import flash.utils.flash_proxy;
	
	import mx.utils.object_proxy;
	
	use namespace flash_proxy;
	use namespace object_proxy;
	
	
	[Bindable]
	public class XTextFormatModel extends XModel
	{
		public function XTextFormatModel()
		{
			super();
			var model:* = {
				color: 0x000000,
				fontFamily: "Arial",
				fontSize: 12,
				fontStyle: "normal",
				fontWeight: "normal",
				lineThrough: false,
				textAlign: "center",
				verticalAlign: "middle",
				textDecoration: "none"
			};
			plugin(model);
		}
		
		
		public function get color():uint
		{
			return getProperty("color");
		}
		
		public function set color(value:uint):void
		{
			setProperty("color", value);
		}
		
		
		public function get fontFamily():String
		{
			return getProperty("fontFamily");
		}
		
		public function set fontFamily(value:String):void
		{
			setProperty("fontFamily", value);
		}
		
		
		public function get fontSize():Number
		{
			return getProperty("fontSize");
		}
		
		public function set fontSize(value:Number):void
		{
			setProperty("fontSize", value);
		}
		
		
		public function get fontStyle():String
		{
			return getProperty("fontStyle");
		}
		
		public function set fontStyle(value:String):void
		{
			setProperty("fontStyle", value);
		}
		
		
		public function get fontWeight():String
		{
			return getProperty("fontWeight");
		}
		
		public function set fontWeight(value:String):void
		{
			setProperty("fontWeight", value);
		}
		
		
		public function get lineThrough():Boolean
		{
			return getProperty("lineThrough");
		}
		
		public function set lineThrough(value:Boolean):void
		{
			setProperty("lineThrough", value);
		}
		
		
		public function get textAlign():String
		{
			return getProperty("textAlign");
		}
		
		public function set textAlign(value:String):void
		{
			setProperty("textAlign", value);
		}
		
		
		public function get verticalAlign():String
		{
			return getProperty("verticalAlign");
		}
		
		public function set verticalAlign(value:String):void
		{
			setProperty("verticalAlign", value);
		}
		
		
		public function get textDecoration():String
		{
			return getProperty("textDecoration");
		}
		
		public function set textDecoration(value:String):void
		{
			setProperty("textDecoration", value);
		}
	}
}
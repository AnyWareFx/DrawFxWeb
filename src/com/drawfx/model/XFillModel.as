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
	public class XFillModel extends XModel
	{
		public function XFillModel()
		{
			var model:* = {
				color: 0xEFEFEF,
				alpha: 1.0,
				blendMode: "normal",
				backgroundImage: "",
				backgroundImageFillMode: "",
				contentBackgroundColor: 0xEFEFEF,
				contentBackgroundAlpha: 1.0
			};
			plugin(model);
		}
		
		
		public function get blendMode():String
		{
			return getProperty("blendMode");
		}
		
		public function set blendMode(value:String):void
		{
			setProperty("blendMode", value);
		}
		
		
		public function get color():uint
		{
			return getProperty("color");
		}
		
		public function set color(value:uint):void
		{
			setProperty("color", value);
		}
		
		
		public function get alpha():Number
		{
			return getProperty("alpha");
		}
		
		public function set alpha(value:Number):void
		{
			setProperty("alpha", value);
		}
		
		
		
		public function get contentBackgroundColor():uint
		{
			return getProperty("contentBackgroundColor");
		}
		
		public function set contentBackgroundColor(value:uint):void
		{
			setProperty("contentBackgroundColor", value);
		}
		
		
		public function get contentBackgroundAlpha():Number
		{
			return getProperty("contentBackgroundAlpha");
		}
		
		public function set contentBackgroundAlpha(value:Number):void
		{
			setProperty("contentBackgroundAlpha", value);
		}
	}
}
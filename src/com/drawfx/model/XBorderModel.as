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
	public class XBorderModel extends XModel
	{
		public function XBorderModel()
		{
			super();
			var model:* = {
				visible: true,
				dropShadowVisible: false,
				cornerRadius: 0
			};
			plugin(model);
		}
		
		
		public function get visible():Boolean
		{
			return getProperty("visible");
		}
		
		public function set visible(value:Boolean):void
		{
			setProperty("visible", value);
		}
		
		
		public function get dropShadowVisible():Boolean
		{
			return getProperty("dropShadowVisible");
		}
		
		public function set dropShadowVisible(value:Boolean):void
		{
			setProperty("dropShadowVisible", value);
		}
		
		
		public function get cornerRadius():Number
		{
			return getProperty("cornerRadius");
		}
		
		public function set cornerRadius(value:Number):void
		{
			setProperty("cornerRadius", value);
		}
	}
}
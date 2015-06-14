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

package com.drawfx.fx.model
{
	import com.anywarefx.model.XModel;
	
	import flash.utils.flash_proxy;
	
	import mx.utils.object_proxy;
	
	use namespace flash_proxy;
	use namespace object_proxy;
	
	
	[Bindable]
	public class XDropShadowModel extends XModel
	{
		public function XDropShadowModel()
		{
			super();
			var model:* = {
				active: false,
				color: 0x000000,
				alpha: 0.5,
				angle: 45,
				blurX: 0,
				blurY: 0,
				distance: 0,
				quality: 1,
				strength: 1,
				inner: false,
				knockout: false
			};
			plugin(model);
		}
		
		
		public function get active():Boolean
		{
			return getProperty("active");
		}
		
		public function set active(value:Boolean):void
		{
			setProperty("active", value);
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
		
		
		public function get angle():Number
		{
			return getProperty("angle");
		}
		
		public function set angle(value:Number):void
		{
			setProperty("angle", value);
		}
		
		
		public function get blurX():Number
		{
			return getProperty("blurX");
		}
		
		public function set blurX(value:Number):void
		{
			setProperty("blurX", value);
		}
		
		
		public function get blurY():Number
		{
			return getProperty("blurY");
		}
		
		public function set blurY(value:Number):void
		{
			setProperty("blurY", value);
		}
		
		
		public function get distance():Number
		{
			return getProperty("distance");
		}
		
		public function set distance(value:Number):void
		{
			setProperty("distance", value);
		}
		
		
		public function get quality():Number
		{
			return getProperty("quality");
		}
		
		public function set quality(value:Number):void
		{
			setProperty("quality", value);
		}
		
		
		public function get strength():Number
		{
			return getProperty("strength");
		}
		
		public function set strength(value:Number):void
		{
			setProperty("strength", value);
		}
		
		
		public function get inner():Boolean
		{
			return getProperty("inner");
		}
		
		public function set inner(value:Boolean):void
		{
			setProperty("inner", value);
		}
		
		
		public function get knockout():Boolean
		{
			return getProperty("knockout");
		}
		
		public function set knockout(value:Boolean):void
		{
			setProperty("knockout", value);
		}
	}
}
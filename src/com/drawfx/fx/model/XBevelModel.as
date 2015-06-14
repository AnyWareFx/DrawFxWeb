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
	public class XBevelModel extends XModel
	{
		public function XBevelModel()
		{
			super();
			var model:* = {
				active: false,
				highlightColor: 0xFDFDFD,
				highlightAlpha: 0.5,
				shadowColor: 0x333333,
				shadowAlpha: 0.5,
				angle: 45,
				blurX: 0,
				blurY: 0,
				distance: 0,
				quality: 1,
				strength: 1
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
		
		
		public function get highlightColor():uint
		{
			return getProperty("highlightColor");
		}
		
		public function set highlightColor(value:uint):void
		{
			setProperty("highlightColor", value);
		}
		
		
		public function get highlightAlpha():Number
		{
			return getProperty("highlightAlpha");
		}
		
		public function set highlightAlpha(value:Number):void
		{
			setProperty("highlightAlpha", value);
		}
		
		
		public function get shadowColor():uint
		{
			return getProperty("shadowColor");
		}
		
		public function set shadowColor(value:uint):void
		{
			setProperty("shadowColor", value);
		}
		
		
		public function get shadowAlpha():Number
		{
			return getProperty("shadowAlpha");
		}
		
		public function set shadowAlpha(value:Number):void
		{
			setProperty("shadowAlpha", value);
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
	}
}
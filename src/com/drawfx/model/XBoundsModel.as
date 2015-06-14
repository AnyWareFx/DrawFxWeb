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
	
	import flash.geom.Point;
	import flash.utils.flash_proxy;
	
	import mx.utils.object_proxy;
	
	use namespace flash_proxy;
	use namespace object_proxy;
	
	
	[Bindable]
	public class XBoundsModel extends XModel
	{
		public function XBoundsModel()
		{
			super();
			var model:* = {
				x: 0,
				y: 0,
				z: 0,
				depth: 0,
				width: 0,
				height: 0,
				scaleX: 1,
				scaleY: 1,
				scaleZ: 1,
				rotationX: 0,
				rotationY: 0,
				rotationZ: 0
			};
			plugin(model);
		}
		
		
		public function get x():Number
		{
			return getProperty("x");
		}
		
		public function set x(value:Number):void
		{
			setProperty("x", value);
		}
		
		
		public function get y():Number
		{
			return getProperty("y");
		}
		
		public function set y(value:Number):void
		{
			setProperty("y", value);
		}
		
		
		public function get z():Number
		{
			return getProperty("z");
		}
		
		public function set z(value:Number):void
		{
			setProperty("z", value);
		}
		
		
		public function get depth():Number
		{
			return getProperty("depth");
		}
		
		public function set depth(value:Number):void
		{
			setProperty("depth", value);
		}
		
		
		public function get width():Number
		{
			return getProperty("width");
		}
		
		public function set width(value:Number):void
		{
			setProperty("width", value);
		}
		
		
		public function get height():Number
		{
			return getProperty("height");
		}
		
		public function set height(value:Number):void
		{
			setProperty("height", value);
		}
		
		
		public function get scaleX():Number
		{
			return getProperty("scaleX");
		}
		
		public function set scaleX(value:Number):void
		{
			setProperty("scaleX", value);
		}
		
		
		public function get scaleY():Number
		{
			return getProperty("scaleY");
		}
		
		public function set scaleY(value:Number):void
		{
			setProperty("scaleY", value);
		}
		
		
		public function get scaleZ():Number
		{
			return getProperty("scaleZ");
		}
		
		public function set scaleZ(value:Number):void
		{
			setProperty("scaleZ", value);
		}
		
		
		public function get rotationX():Number
		{
			return getProperty("rotationX");
		}
		
		public function set rotationX(value:Number):void
		{
			setProperty("rotationX", value);
		}
		
		
		public function get rotationY():Number
		{
			return getProperty("rotationY");
		}
		
		public function set rotationY(value:Number):void
		{
			setProperty("rotationY", value);
		}
		
		
		public function get rotationZ():Number
		{
			return getProperty("rotationZ");
		}
		
		public function set rotationZ(value:Number):void
		{
			setProperty("rotationZ", value);
		}
		
		
		public function get position():Point
		{
			var x:Number = getProperty("x");
			var y:Number = getProperty("y");
			return new Point(x, y);
		}
		
		public function set position(value:Point):void
		{
			var oldPosition:Point = new Point(getProperty("x"), getProperty("y"));
			setProperty("x", value.x);
			setProperty("y", value.y);
			notifyPropertyChanged("position", oldPosition, value);
		}
		
		
		public function get dimensions():Point
		{
			var x:Number = getProperty("width");
			var y:Number = getProperty("height");
			return new Point(x, y);
		}
		
		public function set dimensions(value:Point):void
		{
			var oldDimensions:Point = new Point(getProperty("width"), getProperty("height"));
			setProperty("width", value.x);
			setProperty("height", value.y);
			notifyPropertyChanged("dimensions", oldDimensions, value);
		}
	}
}
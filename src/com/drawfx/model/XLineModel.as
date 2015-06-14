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
	import com.drawfx.fx.model.FxModel;
	import com.drawfx.fx.model.IFxEnabledModel;
	
	import flash.geom.Point;
	import flash.utils.flash_proxy;
	
	import mx.events.PropertyChangeEvent;
	import mx.utils.object_proxy;
	
	use namespace flash_proxy;
	use namespace object_proxy;
	
	
	[Bindable]
	public class XLineModel extends XModel implements IBoundedModel, IConstrainedModel, IFxEnabledModel, IStrokedModel
	{
		public function XLineModel()
		{
			super();
			var model:* = {
				bounds: null,
				constraints: null,
				fx: null,
				stroke: null,
				start: null,
				length: 0,
				rotation: 0,
				affordance: 5
			};
			plugin(model);
		}
		
		
		public function get bounds():XBoundsModel
		{
			return getProperty("bounds");
		}
		
		public function set bounds(value:XBoundsModel):void
		{
			setProperty("bounds", value);
			value.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, onBoundsChange);
		}
		
		private function onBoundsChange(event:PropertyChangeEvent):void
		{
			if (event.property == "height")
			{
				var bounds:XBoundsModel = event.source as XBoundsModel;
				if (bounds != null)
				{
					bounds.height = stroke.weight + affordance * 2;
				}
			}
		}
		
		
		public function get constraints():XConstraintsModel
		{
			return getProperty("constraints");
		}
		
		public function set constraints(value:XConstraintsModel):void
		{
			setProperty("constraints", value);
		}
		
		
		public function get fx():FxModel
		{
			return getProperty("fx");
		}
		
		public function set fx(value:FxModel):void
		{
			setProperty("fx", value);
		}
		
		
		public function get stroke():XStrokeModel
		{
			return getProperty("stroke");
		}
		
		public function set stroke(value:XStrokeModel):void
		{
			setProperty("stroke", value);
			value.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, onStrokeChange);
		}
		
		private function onStrokeChange(event:PropertyChangeEvent):void
		{
			if (event.property == "weight")
			{
				var stroke:XStrokeModel = event.source as XStrokeModel;
				if (stroke != null)
				{
					bounds.height = stroke.weight + affordance * 2;
				}
			}
		}
		
		
		public function get length():Number
		{
			return getProperty("length");
		}
		
		public function set length(value:Number):void
		{
			setProperty("length", value);
		}
		
		
		public function get rotation():Number
		{
			return getProperty("rotation");
		}
		
		public function set rotation(value:Number):void
		{
			setProperty("rotation", value);
		}
		
		
		public function get start():Point
		{
			return getProperty("start");
		}
		
		public function set start(value:Point):void
		{
			setProperty("start", value);
		}
		
		
		public function get affordance():Number
		{
			return getProperty("affordance");
		}
		
		public function set affordance(value:Number):void
		{
			setProperty("affordance", value);
		}
	}
}
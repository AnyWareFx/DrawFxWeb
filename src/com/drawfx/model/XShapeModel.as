/*
Copyright (c) 2013 Dave Jackson

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
	import com.drawfx.fx.model.FxModel;
	import com.drawfx.fx.model.IFxEnabledModel;
	
	import flash.utils.flash_proxy;
	
	import mx.events.PropertyChangeEvent;
	import mx.utils.object_proxy;
	
	use namespace flash_proxy;
	use namespace object_proxy;
	
	
	[Bindable]
	public class XShapeModel extends XCompositeModel 
        implements IBoundedModel, IConstrainedModel, IBorderedModel, IStrokedModel, IFilledModel, 
                   IFormattedModel, IFxEnabledModel
	{
		public function XShapeModel()
		{
			super();
			var model:* = {
				bounds: null,
                constraints: null,
				textBox: null,
				border: null,
                stroke: null,
				fill: null,
				fx: null			
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
			if (event.property == "width" || event.property == "height")
			{
				var bounds:XBoundsModel = event.source as XBoundsModel;
				if (bounds != null && textBox != null)
				{
					textBox.bounds.width = bounds.width;
					textBox.bounds.height = bounds.height;
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
		
		
		public function get textBox():XTextBoxModel
		{
			return getProperty("textBox");
		}
		
		public function set textBox(value:XTextBoxModel):void
		{
			setProperty("textBox", value);
		}
		
        
        public function get format():XTextFormatModel
        {
            return textBox.format;
        }
        
        public function set format(value:XTextFormatModel):void
        {
            textBox.format = value;
        }
        
		
		public function get border():XBorderModel
		{
			return getProperty("border");
		}
		
		public function set border(value:XBorderModel):void
		{
			setProperty("border", value);
		}
        
        
        public function get stroke():XStrokeModel
        {
            return getProperty("stroke");
        }
        
        public function set stroke(value:XStrokeModel):void
        {
            setProperty("stroke", value);
        }
		
		
		public function get fill():XFillModel
		{
			return getProperty("fill");
		}
		
		public function set fill(value:XFillModel):void
		{
			setProperty("fill", value);
		}
		
		
		public function get fx():FxModel
		{
			return getProperty("fx");
		}
		
		public function set fx(value:FxModel):void
		{
			setProperty("fx", value);
		}
	}
}
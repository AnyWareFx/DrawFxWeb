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
	import flash.utils.flash_proxy;
	
	import mx.utils.object_proxy;
	
	use namespace flash_proxy;
	use namespace object_proxy;
	
	
	public class XGroupModel extends XCompositeModel implements IBoundedModel
	{
		public function XGroupModel()
		{
			super();
			var model:* = {
				bounds: null,
				sizeToContent: false
			};
			plugin(model);
		}
		
		
		override public function addGroup(group:XGroupModel):void
		{
			super.addGroup(group);
			recalcBounds(group);
		}
		
		override public function removeGroup(group:XGroupModel):void
		{
			super.removeGroup(group);
			recalcBounds(group);
		}
		
		
		override public function addLine(line:XLineModel):void
		{
			super.addLine(line);
			recalcBounds(line);
		}
		
		override public function removeLine(line:XLineModel):void
		{
			super.removeLine(line);
			recalcBounds(line);
		}
		
		
		override public function addImage(image:XImageModel):void
		{
			super.addImage(image);
			recalcBounds(image);
		}
		
		override public function removeImage(image:XImageModel):void
		{
			super.removeImage(image);
			recalcBounds(image);
		}
		
		
		override public function addShape(shape:XShapeModel):void
		{
			super.addShape(shape);
			recalcBounds(shape);
		}
		
		override public function removeShape(shape:XShapeModel):void
		{
			super.removeShape(shape);
			recalcBounds(shape);
		}
		
		
		override public function addTextBox(textBox:XTextBoxModel):void
		{
			super.addTextBox(textBox);
			recalcBounds(textBox);
		}
		
		override public function removeTextBox(textBox:XTextBoxModel):void
		{
			super.removeTextBox(textBox);
			recalcBounds(textBox);
		}
		
		
		public function get bounds():XBoundsModel
		{
			return getProperty("bounds");
		}
		
		public function set bounds(value:XBoundsModel):void
		{
			setProperty("bounds", value);
		}
		
		
		public function get sizeToContent():Boolean
		{
			return getProperty("sizeToContent");
		}
		
		public function set sizeToContent(value:Boolean):void
		{
			setProperty("sizeToContent", value);
		}
		
		
		private function recalcBounds(model:IBoundedModel):void
		{
			if (model.bounds.y < bounds.y)
			{
				bounds.y = model.bounds.y;
			}
			if (model.bounds.x < bounds.x)
			{
				bounds.x = model.bounds.x;
			}
			var modelBottom:Number = model.bounds.y + model.bounds.height;
			if (modelBottom > bounds.y + bounds.height)
			{
				bounds.height = modelBottom - bounds.y;
			}
			var modelRight:Number = model.bounds.x + model.bounds.width;
			if (modelRight > bounds.x + bounds.width)
			{
				bounds.width = modelRight - bounds.x;
			}
		}
	}
}
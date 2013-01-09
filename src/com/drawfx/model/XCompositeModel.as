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
	import com.anywarefx.model.XModel;
	import com.drawfx.event.XDrawingEvent;
	
	import flash.utils.flash_proxy;
	
	import mx.collections.ArrayCollection;
	import mx.utils.object_proxy;
	
	use namespace flash_proxy;
	use namespace object_proxy;
	
	
	[Bindable]
	public class XCompositeModel extends XModel
	{
		public function XCompositeModel()
		{
			super();
			var model:* = {
				parent: null,
                lines: new ArrayCollection(),
				groups: new ArrayCollection(),
				shapes: new ArrayCollection(),
                images: new ArrayCollection(),
				textBoxes: new ArrayCollection()
			};
			plugin(model);
		}
		
        
        override public function fromJSON(json:*, clone:Boolean=false):void
        {
            lines.removeAll();
            groups.removeAll();
            shapes.removeAll();
            images.removeAll();
            textBoxes.removeAll();
            super.fromJSON(json, clone);
        }
        
		
		public function get parent():XCompositeModel
		{
			return getProperty("parent");
		}
		
		public function set parent(value:XCompositeModel):void
		{
			setProperty("parent", value);
		}
        
        
        [ArrayElementType("com.drawfx.model.XLineModel")]
        public function get lines():ArrayCollection
        {
            return getProperty("lines");
        }
        
        public virtual function set lines(value:ArrayCollection):void
        {
            setProperty("lines", value);
        }
        
        
        public virtual function addLine(line:XLineModel):void
        {
            lines.addItem(line);
            var event:XDrawingEvent = new XDrawingEvent(XDrawingEvent.LINE_ADDED, this);
            event.model = line;
            dispatchEvent(event);
        }
        
        public virtual function removeLine(line:XLineModel):void
        {
            var index:Number = lines.getItemIndex(line);
            if (index != -1)
            {
                lines.removeItemAt(index);
                var event:XDrawingEvent = new XDrawingEvent(XDrawingEvent.LINE_REMOVED);
                event.model = line;
                dispatchEvent(event);
            }
        }
        
        
        [ArrayElementType("com.drawfx.model.XGroupModel")]
        public function get groups():ArrayCollection
        {
            return getProperty("groups");
        }
        
        public virtual function set groups(value:ArrayCollection):void
        {
            setProperty("groups", value);
        }
        
        
        public virtual function addGroup(group:XGroupModel):void
        {
            groups.addItem(group);
            var event:XDrawingEvent = new XDrawingEvent(XDrawingEvent.GROUP_ADDED, this);
            event.model = group;
            dispatchEvent(event);
        }
        
        public virtual function removeGroup(group:XGroupModel):void
        {
            var index:Number = groups.getItemIndex(group);
            if (index != -1)
            {
                groups.removeItemAt(index);
                var event:XDrawingEvent = new XDrawingEvent(XDrawingEvent.GROUP_REMOVED);
                event.model = group;
                dispatchEvent(event);
            }
        }


		[ArrayElementType("com.drawfx.model.XImageModel")]
		public function get images():ArrayCollection
		{
			return getProperty("images");
		}
		
		public virtual function set images(value:ArrayCollection):void
		{
			setProperty("images", value);
		}


		public virtual function addImage(image:XImageModel):void
		{
			images.addItem(image);
			var event:XDrawingEvent = new XDrawingEvent(XDrawingEvent.IMAGE_ADDED, this);
			event.model = image;
			dispatchEvent(event);
		}

		public virtual function removeImage(image:XImageModel):void
		{
			var index:Number = images.getItemIndex(image);
			if (index != -1)
			{
				images.removeItemAt(index);
				var event:XDrawingEvent = new XDrawingEvent(XDrawingEvent.IMAGE_REMOVED);
				event.model = image;
				dispatchEvent(event);
			}
		}


		[ArrayElementType("com.drawfx.model.XShapeModel")]
		public function get shapes():ArrayCollection
		{
			return getProperty("shapes");
		}

		public virtual function set shapes(value:ArrayCollection):void
		{
			setProperty("shapes", value);
		}


		public virtual function addShape(shape:XShapeModel):void
		{
			shapes.addItem(shape);
			var event:XDrawingEvent = new XDrawingEvent(XDrawingEvent.SHAPE_ADDED, this);
			event.model = shape;
			dispatchEvent(event);
		}
		
		public virtual function removeShape(shape:XShapeModel):void
		{
			var index:Number = shapes.getItemIndex(shape);
			if (index != -1)
			{
				shapes.removeItemAt(index);
				var event:XDrawingEvent = new XDrawingEvent(XDrawingEvent.SHAPE_REMOVED);
				event.model = shape;
				dispatchEvent(event);
			}
		}
		
		
		[ArrayElementType("com.drawfx.model.XTextBoxModel")]
		public function get textBoxes():ArrayCollection
		{
			return getProperty("textBoxes");
		}
		
		public virtual function set textBoxes(value:ArrayCollection):void
		{
			setProperty("textBoxes", value);
		}
		
		
		public virtual function addTextBox(textBox:XTextBoxModel):void
		{
			textBoxes.addItem(textBox);
			var event:XDrawingEvent = new XDrawingEvent(XDrawingEvent.TEXT_BOX_ADDED, this);
			event.model = textBox;
			dispatchEvent(event);
		}
		
		public virtual function removeTextBox(textBox:XTextBoxModel):void
		{
			var index:Number = textBoxes.getItemIndex(textBox);
			if (index != -1)
			{
				textBoxes.removeItemAt(index);
				var event:XDrawingEvent = new XDrawingEvent(XDrawingEvent.TEXT_BOX_REMOVED);
				event.model = textBox;
				dispatchEvent(event);
			}
		}
	}
}
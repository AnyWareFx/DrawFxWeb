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

package com.drawfx.manager
{
	import com.anywarefx.XComponent;
	
	import flash.utils.flash_proxy;
	
	import mx.collections.ArrayCollection;
	import mx.utils.object_proxy;
	
	use namespace flash_proxy;
	use namespace object_proxy;
	
	
	[Bindable]
	public class XClipboardManager extends XComponent
	{
		public function XClipboardManager()
		{
			super();
			var model:* = {
				groups: new ArrayCollection(),
				lines: new ArrayCollection(),
				images: new ArrayCollection(),
				shapes: new ArrayCollection(),
				textBoxes: new ArrayCollection(),
				hasContent: false
			};
			plugin(model);
		}
		
		
		public function clear():void
		{
			groups.removeAll();
			lines.removeAll();
			images.removeAll();
			shapes.removeAll();
			textBoxes.removeAll();
			hasContent = false;
		}
		
		
		public function get hasContent():Boolean
		{
			return getProperty("hasContent");
		}
		
		private function set hasContent(value:Boolean):void
		{
			setProperty("hasContent", value);
		}
		
		
		public function get groups():ArrayCollection
		{
			return getProperty("groups");
		}
		
		public virtual function set groups(value:ArrayCollection):void
		{
			setProperty("groups", value);
		}
		
		public function addGroup(group:String):void
		{
			groups.addItem(group);
			hasContent = true;
		}
		
		
		public function get lines():ArrayCollection
		{
			return getProperty("lines");
		}
		
		public virtual function set lines(value:ArrayCollection):void
		{
			setProperty("lines", value);
		}
		
		public function addLine(line:String):void
		{
			lines.addItem(line);
			hasContent = true;
		}
		
		
		public function get images():ArrayCollection
		{
			return getProperty("images");
		}
		
		public virtual function set images(value:ArrayCollection):void
		{
			setProperty("images", value);
		}
		
		public function addImage(image:String):void
		{
			images.addItem(image);
			hasContent = true;
		}
		
		
		public function get shapes():ArrayCollection
		{
			return getProperty("shapes");
		}
		
		public virtual function set shapes(value:ArrayCollection):void
		{
			setProperty("shapes", value);
		}
		
		public function addShape(shape:String):void
		{
			shapes.addItem(shape);
			hasContent = true;
		}
		
		
		public function get textBoxes():ArrayCollection
		{
			return getProperty("textBoxes");
		}
		
		public virtual function set textBoxes(value:ArrayCollection):void
		{
			setProperty("textBoxes", value);
		}
		
		public function addTextBox(textBox:String):void
		{
			textBoxes.addItem(textBox);
			hasContent = true;
		}
	}
}
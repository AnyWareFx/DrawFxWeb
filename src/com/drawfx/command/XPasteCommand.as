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

package com.drawfx.command
{
	import com.anywarefx.XFactory;
	import com.drawfx.manager.XClipboardManager;
	import com.drawfx.model.XGroupModel;
	import com.drawfx.model.XImageModel;
	import com.drawfx.model.XLineModel;
	import com.drawfx.model.XShapeModel;
	import com.drawfx.model.XTextBoxModel;
	
	
	public class XPasteCommand extends XDrawingMacroCommand
	{
		private var _clipboard:XClipboardManager;
		
		
		public function XPasteCommand(target:*, clipboard:XClipboardManager)
		{
			super(target);
			_clipboard = clipboard;
		}
		
		
		override public function execute():void
		{
			var json:String;
			var command:XDrawingCommand;
			for each (json in _clipboard.groups)
			{
				var group:XGroupModel = XFactory.instance.getComponent("XGroupModel");
				group.fromJSON(json);
				command = new XAddGroupCommand(parent, group);
				context.execute(command);
			}
            for each (json in _clipboard.lines)
            {
                var line:XLineModel = XFactory.instance.getComponent("XLineModel");
                line.fromJSON(json);
                command = new XAddLineCommand(parent, line);
                context.execute(command);
            }
            for each (json in _clipboard.images)
            {
                var image:XImageModel = XFactory.instance.getComponent("XImageModel");
                image.fromJSON(json);
                command = new XAddImageCommand(parent, image);
                context.execute(command);
            }
			for each (json in _clipboard.shapes)
			{
				var shape:XShapeModel = XFactory.instance.getComponent("XShapeModel");
				shape.fromJSON(json);
				command = new XAddShapeCommand(parent, shape);
				context.execute(command);
			}
			for each (json in _clipboard.textBoxes)
			{
				var textBox:XTextBoxModel = XFactory.instance.getComponent("XTextBoxModel");
				textBox.fromJSON(json);
				command = new XAddTextBoxCommand(parent, textBox);
				context.execute(command);
			}
		}
	}
}
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

package com.drawfx.command
{
	import com.anywarefx.view.IView;
	import com.drawfx.manager.XClipboardManager;
	import com.drawfx.model.XGroupModel;
	import com.drawfx.model.XImageModel;
	import com.drawfx.model.XLineModel;
	import com.drawfx.model.XShapeModel;
	import com.drawfx.model.XTextBoxModel;
	import com.drawfx.view.XGroup;
	import com.drawfx.view.XImage;
	import com.drawfx.view.XLine;
	import com.drawfx.view.XShape;
	import com.drawfx.view.XTextBox;
	
	import mx.collections.ArrayCollection;
	
	
	public class XCopySelectionsCommand extends XDrawingMacroCommand
	{
		private var _clipboard:XClipboardManager;
		private var _selections:ArrayCollection;
		
		
		public function XCopySelectionsCommand(target:*, clipboard:XClipboardManager, selections:ArrayCollection)
		{
			super(target);
			_clipboard = clipboard;
			_selections = new ArrayCollection(selections.toArray());
		}
		
		
		override public function execute():void
		{
			_clipboard.clear();
			for each (var selection:IView in _selections)
			{
				if (selection is XGroup)
				{
					var group:XGroupModel = selection.model as XGroupModel;
					_clipboard.addGroup(group.toJSON());
				}
				else if (selection is XLine)
				{
					var line:XLineModel = selection.model as XLineModel;
					_clipboard.addLine(line.toJSON());
				}
				else if (selection is XImage)
				{
					var image:XImageModel = selection.model as XImageModel;
					_clipboard.addImage(image.toJSON());
				}
				else if (selection is XShape)
				{
					var shape:XShapeModel = selection.model as XShapeModel;
					_clipboard.addShape(shape.toJSON());
				}
				else if (selection is XTextBox)
				{
					var textBox:XTextBoxModel = selection.model as XTextBoxModel;
					_clipboard.addTextBox(textBox.toJSON());
				}
			}
		}
	}
}
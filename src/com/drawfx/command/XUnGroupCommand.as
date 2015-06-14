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
	import com.anywarefx.XFactory;
	import com.anywarefx.command.XSetPropertyCommand;
	import com.anywarefx.view.IView;
	import com.drawfx.manager.XClipboardManager;
	import com.drawfx.model.IBoundedModel;
	import com.drawfx.model.XBoundsModel;
	import com.drawfx.model.XGroupModel;
	import com.drawfx.view.XGroup;
	
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;
	
	
	public class XUnGroupCommand extends XDrawingMacroCommand
	{
		private var _clipboard:XClipboardManager;
		private var _selections:ArrayCollection;
		
		
		public function XUnGroupCommand(target:*, selections:ArrayCollection)
		{
			super(target);
			_clipboard = new XClipboardManager();
			_selections = new ArrayCollection(selections.toArray());
		}
		
		
		override public function execute():void
		{
			for each (var selection:IView in _selections)
			{
				if (selection.model is XGroupModel)
				{
					var group:XGroupModel = selection.model as XGroupModel;
					var parentOrigin:Point = new Point();
					if (parent is IBoundedModel)
					{
						parentOrigin.x = (parent as IBoundedModel).bounds.x;
						parentOrigin.y = (parent as IBoundedModel).bounds.y;
					}
					var delta:Point = new Point(parentOrigin.x + group.bounds.x, parentOrigin.y + group.bounds.y);
					
					var child:IBoundedModel;
					var position:Point;
					var translateCommand:XSetPropertyCommand;
					for each (child in group.groups)
					{
						position = new Point(child.bounds.x + delta.x, child.bounds.y + delta.y);
						translateCommand = new XSetPropertyCommand(child.bounds, "position", position);
						context.execute(translateCommand);
						_clipboard.addGroup(child.toJSON());
					}
					for each (child in group.lines)
					{
						position = new Point(child.bounds.x + delta.x, child.bounds.y + delta.y);
						translateCommand = new XSetPropertyCommand(child.bounds, "position", position);
						context.execute(translateCommand);
						_clipboard.addLine(child.toJSON());
					}
					for each (child in group.images)
					{
						position = new Point(child.bounds.x + delta.x, child.bounds.y + delta.y);
						translateCommand = new XSetPropertyCommand(child.bounds, "position", position);
						context.execute(translateCommand);
						_clipboard.addImage(child.toJSON());
					}
					for each (child in group.shapes)
					{
						position = new Point(child.bounds.x + delta.x, child.bounds.y + delta.y);
						translateCommand = new XSetPropertyCommand(child.bounds, "position", position);
						context.execute(translateCommand);
						_clipboard.addShape(child.toJSON());
					}
					for each (child in group.textBoxes)
					{
						position = new Point(child.bounds.x + delta.x, child.bounds.y + delta.y);
						translateCommand = new XSetPropertyCommand(child.bounds, "position", position);
						context.execute(translateCommand);
						_clipboard.addTextBox(child.toJSON());
					}
					
					var removeGroupCommand:XRemoveGroupCommand = new XRemoveGroupCommand(parent, group);
					context.execute(removeGroupCommand);
					
					var pasteCommand:XPasteCommand = new XPasteCommand(parent, _clipboard);
					context.execute(pasteCommand);
				}
			}
		}
	}
}
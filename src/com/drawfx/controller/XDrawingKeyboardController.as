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

package com.drawfx.controller
{
	import com.anywarefx.command.XCommand;
	import com.anywarefx.controller.XKeyboardController;
	import com.anywarefx.view.IView;
	import com.drawfx.command.XNudgeSelectionsCommand;
	import com.drawfx.command.XRemoveSelectionsCommand;
	import com.drawfx.view.XDrawing;
	
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	

	public class XDrawingKeyboardController extends XKeyboardController
	{
		override public function addUserEventListeners(view:IView):void
		{
			if (view is XDrawing)
			{
				super.addUserEventListeners(view);
			}
		}

		override public function removeUserEventListeners(view:IView):void
		{
			if (view is XDrawing)
			{
				super.removeUserEventListeners(view);
			}
		}
		
		
		override protected function onKeyDown(event:KeyboardEvent):void
		{
			var target:XDrawing = event.currentTarget as XDrawing;
			var command:XCommand;
			switch (event.keyCode)
			{
				case Keyboard.DELETE:
				case Keyboard.BACKSPACE:
					command = new XRemoveSelectionsCommand(target.model, selectionManager.selections);
					break;
				
				case Keyboard.UP:
				case Keyboard.DOWN:
				case Keyboard.LEFT:
				case Keyboard.RIGHT:
					var increment:Number = XNudgeSelectionsCommand.MOVE_INCREMENT_SMALL;
					if (event.shiftKey)
					{
						increment = XNudgeSelectionsCommand.MOVE_INCREMENT_MEDIUM;
					}
					else if (event.ctrlKey)
					{
						increment = XNudgeSelectionsCommand.MOVE_INCREMENT_LARGE;
					}
					command = new XNudgeSelectionsCommand(target.model, selectionManager.selections, event.keyCode, increment);
					break;
			}
			if (command)
			{
				context.execute(command);
			}
		}
	}
}
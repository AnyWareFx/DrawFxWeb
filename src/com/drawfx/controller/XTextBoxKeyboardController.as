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

package com.drawfx.controller
{
	import com.anywarefx.controller.XKeyboardController;
	import com.anywarefx.view.IView;
	import com.drawfx.view.XTextBox;
	
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.text.TextLineMetrics;
	import flash.ui.Keyboard;
	
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	import spark.events.TextOperationEvent;
	
	
	public class XTextBoxKeyboardController extends XKeyboardController
	{
		override public function addUserEventListeners(view:IView):void
		{
			var textBox:XTextBox = view as XTextBox;
			if (textBox != null)
			{
				super.addUserEventListeners(view);
				textBox._input.addEventListener(FlexEvent.ENTER, onEnter);
				textBox._input.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
				textBox._input.addEventListener(TextOperationEvent.CHANGE, onChange);
			}
		}
		
		override public function removeUserEventListeners(view:IView):void
		{
			super.removeUserEventListeners(view);
			var textBox:XTextBox = view as XTextBox;
			if (textBox != null)
			{
				textBox._input.removeEventListener(FlexEvent.ENTER, onEnter);
				textBox._input.removeEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
				textBox._input.removeEventListener(TextOperationEvent.CHANGE, onChange);
			}
		}
		
		
		override protected function onKeyDown(event:KeyboardEvent):void
		{
			var textBox:XTextBox = XTextBox.getTextBox(event.target as UIComponent);
			if (textBox.currentState == "input")
			{
				event.stopPropagation();
				if (event.keyCode == Keyboard.ESCAPE)
				{
					textBox._input.text = textBox.model["text"];
					textBox.selected = true;
					// selectionManager.addSelection(textBox);
				}
			}
			else if (event.charCode != 0 &&
				event.keyCode != Keyboard.ENTER && 
				event.keyCode != Keyboard.BACKSPACE && 
				event.keyCode != Keyboard.DELETE)
			{
				textBox.currentState = "input";
				textBox._input.text = String.fromCharCode(event.charCode);
				textBox._input.selectRange(0, 1);
			}
		}
		
		
		protected virtual function onEnter(event:FlexEvent):void
		{
			var textBox:XTextBox = XTextBox.getTextBox(event.target as UIComponent);
			setProperty(textBox.model, "text", textBox._input.text);
			textBox.selected = true;
			//			selectionManager.addSelection(textBox);
		}
		
		
		protected virtual function onFocusOut(event:FocusEvent):void
		{
			var textBox:XTextBox = XTextBox.getTextBox(event.target as UIComponent);
			setProperty(textBox.model, "text", textBox._input.text);
			textBox.selected = false;
			//			selectionManager.removeSelection(textBox);
		}
		
		
		protected virtual function onChange(event:TextOperationEvent):void
		{
			var textBox:XTextBox = XTextBox.getTextBox(event.target as UIComponent);
			var text:String = textBox._input.text;
			var metrics:TextLineMetrics = textBox._input.measureText(text);
			setProperty(textBox.model["bounds"], "width", metrics.width);
		}
	}
}
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
	import com.drawfx.view.XShape;
	import com.drawfx.view.XTextBox;
	
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.text.TextLineMetrics;
	import flash.ui.Keyboard;
	
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	import spark.components.TextInput;
	import spark.events.TextOperationEvent;
	
	
	public class XShapeKeyboardController extends XKeyboardController
	{
		override public function addUserEventListeners(view:IView):void
		{
			var shape:XShape = view as XShape;
			if (shape != null)
			{
				super.addUserEventListeners(view);
				var input:TextInput = shape._textBox._input;
				input.addEventListener(FlexEvent.ENTER, onEnter);
				input.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
				//                input.addEventListener(TextOperationEvent.CHANGE, onChange);
			}
		}
		
		override public function removeUserEventListeners(view:IView):void
		{
			super.removeUserEventListeners(view);
			var shape:XShape = view as XShape;
			if (shape != null)
			{
				var input:TextInput = shape._textBox._input;
				input.removeEventListener(FlexEvent.ENTER, onEnter);
				input.removeEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
				//                input.removeEventListener(TextOperationEvent.CHANGE, onChange);
			}
		}
		
		
		override protected function onKeyDown(event:KeyboardEvent):void
		{
			var textBox:XTextBox = XTextBox.getTextBox(event.target as UIComponent);
			if (textBox != null)
			{
				if (textBox.currentState == "input")
				{
					event.stopPropagation();
					if (event.keyCode == Keyboard.ESCAPE)
					{
						textBox._input.text = textBox.model["text"];
						textBox.selected = false;
						selectionManager.addSelection(XShape.getShape(textBox.parent as UIComponent));
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
		}
		
		
		protected virtual function onEnter(event:FlexEvent):void
		{
			var textBox:XTextBox = XTextBox.getTextBox(event.target as UIComponent);
			if (textBox != null)
			{
				setProperty(textBox.model, "text", textBox._input.text);
				textBox.selected = false;
				selectionManager.addSelection(XShape.getShape(textBox.parent as UIComponent));
			}
		}
		
		
		protected virtual function onFocusOut(event:FocusEvent):void
		{
			var textBox:XTextBox = XTextBox.getTextBox(event.target as UIComponent);
			if (textBox != null)
			{
				setProperty(textBox.model, "text", textBox._input.text);
				textBox.selected = false;
				selectionManager.removeSelection(XShape.getShape(textBox.parent as UIComponent));
			}
		}
		
		
		protected virtual function onChange(event:TextOperationEvent):void
		{
			var shape:XShape = XShape.getShape(event.target as UIComponent);
			var textBox:XTextBox = XTextBox.getTextBox(event.target as UIComponent);
			var text:String = textBox._input.text;
			var metrics:TextLineMetrics = textBox._input.measureText(text);
			setProperty(shape.model["bounds"], "width", metrics.width);
			setProperty(textBox.model["bounds"], "width", metrics.width);
		}
	}
}
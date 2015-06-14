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

package com.anywarefx.controller
{
	import com.anywarefx.view.IView;
	
	import flash.events.MouseEvent;
	
	
	public class XMouseController extends XUIController
	{
		override public function addUserEventListeners(view:IView):void
		{
			if (view != null)
			{
				view.addEventListener(MouseEvent.CLICK, onMouseClick);
				view.addEventListener(MouseEvent.DOUBLE_CLICK, onDoubleClick);
				view.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				view.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
				view.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
				view.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				view.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				view.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
				view.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
				view.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			}
		}
		
		override public function removeUserEventListeners(view:IView):void
		{
			if (view != null)
			{
				view.removeEventListener(MouseEvent.CLICK, onMouseClick);
				view.removeEventListener(MouseEvent.DOUBLE_CLICK, onDoubleClick);
				view.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				view.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
				view.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
				view.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				view.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				view.removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
				view.removeEventListener(MouseEvent.ROLL_OUT, onRollOut);
				view.removeEventListener(MouseEvent.ROLL_OVER, onRollOver);
			}
		}
		
		
		protected  function onMouseClick(event:MouseEvent):void {}
		
		protected  function onDoubleClick(event:MouseEvent):void {}
		
		protected  function onMouseDown(event:MouseEvent):void {}
		
		protected  function onMouseMove(event:MouseEvent):void {}
		
		protected  function onMouseOut(event:MouseEvent):void {}
		
		protected  function onMouseOver(event:MouseEvent):void {}
		
		protected  function onMouseUp(event:MouseEvent):void {}
		
		protected  function onMouseWheel(event:MouseEvent):void {}
		
		protected  function onRollOut(event:MouseEvent):void {}
		
		protected  function onRollOver(event:MouseEvent):void {}
	}
}
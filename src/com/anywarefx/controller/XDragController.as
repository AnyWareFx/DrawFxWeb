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

package com.anywarefx.controller
{
    import com.anywarefx.view.IView;
    
    import mx.events.DragEvent;


    public class XDragController extends XUIController
    {
        override public function addUserEventListeners(view:IView):void
        {
            if (view != null)
            {
                view.addEventListener(DragEvent.DRAG_COMPLETE, onDragComplete);
                view.addEventListener(DragEvent.DRAG_START, onDragStart);
            }
        }

        override public function removeUserEventListeners(view:IView):void
        {
            if (view != null)
            {
                view.removeEventListener(DragEvent.DRAG_COMPLETE, onDragComplete);
                view.removeEventListener(DragEvent.DRAG_START, onDragStart);
            }
        }


        protected function onDragComplete(event:DragEvent):void {}

        protected function onDragStart(event:DragEvent):void {}
    }
}
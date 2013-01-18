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
	import com.anywarefx.controller.XMouseController;
	import com.anywarefx.view.IView;
	import com.anywarefx.view.XSelectableView;
	import com.drawfx.view.XDrawing;
	import com.drawfx.view.XRubberBand;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	

	public class XDrawingMouseController extends XMouseController
	{
		private var _targeted:Boolean = false;
		private var _selecting:Boolean = false;


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


		override protected function onMouseDown(event:MouseEvent):void
		{
			if (event.target is XDrawing)
			{
				_targeted = true;
			}
		}

		override protected function onMouseClick(event:MouseEvent):void
		{
			if (!_selecting)
			{
				selectionManager.clearSelections();
			}
			_targeted = false;
			_selecting = false;
		}


		override protected function onMouseMove(event:MouseEvent):void
		{
			if (_targeted && event.buttonDown)
			{
				var drawing:XDrawing = event.target as XDrawing;
				if (drawing != null)
				{
					var rubberBand:XRubberBand = drawing.rubberBand;
					if (rubberBand.startPoint.x == -1 && rubberBand.startPoint.y == -1)
					{
						_selecting = true;
						selectionManager.clearSelections();
						
						rubberBand.currentPoint = new Point(event.localX, event.localY);
						rubberBand.startPoint = new Point(event.localX, event.localY);
						
						rubberBand.x = rubberBand.startPoint.x;
						rubberBand.y = rubberBand.startPoint.y;
						rubberBand.visible = true;
						rubberBand.depth = drawing.numElements;
						
						drawing.systemManager.addEventListener(MouseEvent.MOUSE_MOVE, onResizeRubberBand, true);
						drawing.systemManager.addEventListener(MouseEvent.MOUSE_UP, onSelectionComplete, true);
					}
				}
			}
		}


		private function onResizeRubberBand(event:MouseEvent):void
		{
			event.stopImmediatePropagation();		
			
			var drawing:XDrawing = event.target as XDrawing;
			if (drawing != null)
			{
				var rubberBand:XRubberBand = drawing.rubberBand;
				rubberBand.currentPoint = new Point(event.localX, event.localY);

				rubberBand.width = rubberBand.width + rubberBand.currentPoint.x - rubberBand.startPoint.x;
				rubberBand.height = rubberBand.height + rubberBand.currentPoint.y - rubberBand.startPoint.y;  

				rubberBand.startPoint.x = rubberBand.currentPoint.x;
				rubberBand.startPoint.y = rubberBand.currentPoint.y;
			}
		}

		private function onSelectionComplete(event:MouseEvent):void
		{
			event.stopImmediatePropagation();		

			var drawing:XDrawing = event.target as XDrawing;
			if (drawing != null)
			{
				var rubberBand:XRubberBand = drawing.rubberBand;
				var area:Rectangle = new Rectangle(rubberBand.x, rubberBand.y, rubberBand.width, rubberBand.height);
				for (var index:int = 0; index < drawing.numElements; index++)
				{
					var child:DisplayObject =  drawing.getChildAt(index);
					if (child !== drawing.rubberBand && child !== drawing.snapshot)
					{
						var bounds:Rectangle = new Rectangle(child.x, child.y, child.width, child.height);
						if (area.intersects(bounds))
						{
							selectionManager.addSelection(child as XSelectableView);
						}
					}
				}
				rubberBand.x = 0;
				rubberBand.y = 0;
				rubberBand.width = 0;
				rubberBand.height = 0;
				rubberBand.visible = false;
				rubberBand.startPoint = new Point(-1, -1);

				drawing.systemManager.removeEventListener(MouseEvent.MOUSE_MOVE, onResizeRubberBand, true);
				drawing.systemManager.removeEventListener(MouseEvent.MOUSE_UP, onSelectionComplete, true);
			}
		}
	}
}
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
	import com.drawfx.view.XImage;
	import com.drawfx.view.XLine;
	import com.drawfx.view.XShape;
	import com.drawfx.view.XStencil;
	import com.drawfx.view.XTextBox;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.core.DragSource;
	import mx.core.UIComponent;
	import mx.managers.DragManager;
	

	public class XStencilMouseController extends XMouseController
	{
		override protected function onMouseMove(event:MouseEvent):void
		{
			if (event.buttonDown)
			{
				var stencil:XStencil = XStencil.getStencil(event.target as UIComponent);
				if (stencil != null)
				{
                    var offset:Point = new Point();
                    var source:DragSource = new DragSource();
					var shape:XShape = XShape.getShape(event.target as UIComponent);
                    var line:XLine = XLine.getLine(event.target as UIComponent);
                    var image:XImage = XImage.getImage(event.target as UIComponent);
                    var textBox:XTextBox = XTextBox.getTextBox(event.target as UIComponent);
					if (shape != null)
					{
						offset.x = shape.contentMouseX;
						offset.y = shape.contentMouseY;
						
						source.addData(stencil, "parent");
						source.addData(shape.model, "model");
                        source.addData(shape, "view");
						source.addData(offset, "offset");
						
						DragManager.doDrag(shape, source, event);
					}
                    else if (line != null)
                    {
                        offset.x = line.contentMouseX;
                        offset.y = line.contentMouseY;
                        
                        source.addData(stencil, "parent");
                        source.addData(line.model, "model");
                        source.addData(line, "view");
                        source.addData(offset, "offset");
                        
                        DragManager.doDrag(line, source, event);
                    }
                    else if (image != null)
                    {
                        offset.x = image.contentMouseX;
                        offset.y = image.contentMouseY;
                        
                        source.addData(stencil, "parent");
                        source.addData(image.model, "model");
                        source.addData(image, "view");
                        source.addData(offset, "offset");
                        
                        DragManager.doDrag(image, source, event);
                    }
					else if (textBox != null)
					{
						offset.x = textBox.contentMouseX;
						offset.y = textBox.contentMouseY;
						
						source.addData(stencil, "parent");
						source.addData(textBox.model, "model");
                        source.addData(textBox, "view");
						source.addData(offset, "offset");
						
						DragManager.doDrag(textBox, source, event);
					}
				}
			}
		}
	}
}
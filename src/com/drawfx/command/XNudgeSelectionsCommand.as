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
	import com.anywarefx.command.XSetPropertyCommand;
	import com.anywarefx.model.IModel;
	import com.anywarefx.view.IView;
	import com.drawfx.model.IBoundedModel;
	import com.drawfx.model.XBoundsModel;
	
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	import mx.collections.ArrayCollection;


	public class XNudgeSelectionsCommand extends XDrawingMacroCommand
	{
		public static const MOVE_INCREMENT_SMALL:Number  =  1;
		public static const MOVE_INCREMENT_MEDIUM:Number = 10;
		public static const MOVE_INCREMENT_LARGE:Number  = 20;
		
		private var _selections:ArrayCollection;
		private var _direction:uint;
		private var _increment:Number;
		
		
		public function XNudgeSelectionsCommand(target:*, selections:ArrayCollection, direction:uint, increment:Number)
		{
			super(target);
			_selections = new ArrayCollection(selections.toArray());
			_direction = direction;
			_increment = increment;
		}
		
		
		override public function execute():void
		{
			for each (var selection:IView in _selections)
			{
				var model:IModel = selection.model;
				if (model is IBoundedModel)
				{
					var bounds:XBoundsModel = (model as IBoundedModel).bounds;
					var position:Point = new Point(bounds.x, bounds.y);
					switch (_direction)
					{
						case Keyboard.UP:
							position.y -= _increment;
							break;
						
						case Keyboard.DOWN:
							position.y += _increment;
							break;
						
						case Keyboard.LEFT:
							position.x -= _increment;
							break;
						
						case Keyboard.RIGHT:
							position.x += _increment;
							break;
					}
					var command:XSetPropertyCommand = new XSetPropertyCommand(bounds, "position", position);
					context.execute(command);
				}
			}
		}
	}
}
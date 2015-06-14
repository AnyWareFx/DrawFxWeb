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
	import com.anywarefx.command.XSetPropertyCommand;
	import com.anywarefx.model.IModel;
	import com.anywarefx.view.IView;
	import com.drawfx.model.IBoundedModel;
	import com.drawfx.model.XBoundsModel;
	import com.drawfx.view.XShape;
	
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;
	
	
	public class XResizeSelectionsCommand extends XDrawingMacroCommand
	{
		public static var MATCH_SIZE:String = "matchSize";
		public static var MATCH_WIDTH:String = "matchWidth";
		public static var MATCH_HEIGHT:String = "matchHeight";
		
		private var _selections:ArrayCollection;
		private var _lastSelection:IView;
		private var _match:String;
		
		
		public function XResizeSelectionsCommand(target:*, selections:ArrayCollection, lastSelection:IView, match:String)
		{
			super(target);
			_selections = new ArrayCollection(selections.toArray());
			_lastSelection = lastSelection;
			_match = match;
		}
		
		
		override public function execute():void
		{
			var referenceModel:IModel = _lastSelection.model;
			if (referenceModel is IBoundedModel)
			{
				var referenceBounds:XBoundsModel = (referenceModel as IBoundedModel).bounds;
				for each (var selection:IView in _selections)
				{
					var model:IModel = selection.model;
					if (model is IBoundedModel)
					{
						var bounds:XBoundsModel = (model as IBoundedModel).bounds;
						var dimensions:Point = new Point(bounds.width, bounds.height);
						switch (_match)
						{
							case MATCH_WIDTH:
								dimensions.x = referenceBounds.width;
								break;
							
							case MATCH_HEIGHT:
								dimensions.y = referenceBounds.height;
								break;
							
							case MATCH_SIZE:
								dimensions.x = referenceBounds.width;
								dimensions.y = referenceBounds.height;
								break;
						}
						var command:XSetPropertyCommand = new XSetPropertyCommand(bounds, "dimensions", dimensions);
						context.execute(command);
					}
				}
			}
		}
	}
}
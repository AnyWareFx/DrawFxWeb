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
	
	import mx.collections.ArrayCollection;
	
	
	public class XDistributeSelectionsCommand extends XDrawingMacroCommand
	{
		public static var DISTRIBUTE_TOP:String = "alignTop";
		public static var DISTRIBUTE_LEFT:String = "alignLeft";
		public static var DISTRIBUTE_BOTTOM:String = "alignBottom";
		public static var DISTRIBUTE_RIGHT:String = "alignRight";
		public static var DISTRIBUTE_HORIZONTAL_CENTER:String = "alignHorizontalCenter";
		public static var DISTRIBUTE_VERTICAL_CENTER:String = "alignVerticalCenter";
		
		private var _selections:ArrayCollection;
		private var _lastSelection:IView;
		private var _distribution:String;
		
		
		public function XDistributeSelectionsCommand(target:*, selections:ArrayCollection, lastSelection:IView, distribution:String)
		{
			super(target);
			_selections = new ArrayCollection(selections.toArray());
			_lastSelection = lastSelection;
			_distribution = distribution;
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
						var position:Point = new Point(bounds.x, bounds.y);
						switch (_distribution)
						{
							case DISTRIBUTE_TOP:
								position.y = referenceBounds.y;
								break;
							
							case DISTRIBUTE_LEFT:
								position.x = referenceBounds.x;
								break;
							
							case DISTRIBUTE_BOTTOM:
								position.y = referenceBounds.y + referenceBounds.height - bounds.height;
								break;
							
							case DISTRIBUTE_RIGHT:
								position.x = referenceBounds.x + referenceBounds.width - bounds.width;
								break;
							
							case DISTRIBUTE_HORIZONTAL_CENTER:
								position.x = referenceBounds.x + referenceBounds.width / 2 - bounds.width / 2;
								break;
							
							case DISTRIBUTE_VERTICAL_CENTER:
								position.y = referenceBounds.y + referenceBounds.height / 2 - bounds.height / 2;
								break;
						}
						var command:XSetPropertyCommand = new XSetPropertyCommand(bounds, "position", position);
						context.execute(command);
					}
				}
			}
		}
	}
}



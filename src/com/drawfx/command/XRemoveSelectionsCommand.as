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
	import com.anywarefx.view.IView;
	import com.drawfx.model.IBoundedModel;
	import com.drawfx.model.XCompositeModel;
	import com.drawfx.view.XComposite;
	
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;


	public class XRemoveSelectionsCommand extends XDrawingMacroCommand
	{
		private var _selections:ArrayCollection;


		public function XRemoveSelectionsCommand(target:*, selections:ArrayCollection)
		{
			super(target);
			_selections = new ArrayCollection(selections.toArray());
		}
		
		
		override public function execute():void
		{
			var command:XDrawingCommand;
			for each (var selection:IView in _selections)
			{
				var container:XComposite = getContainer((selection as UIComponent).parent as UIComponent);
                command = XDrawingCommandFactory.createRemoveCommand(container.model as XCompositeModel, selection.model as IBoundedModel);
				context.execute(command);
			}
		}


		protected function getContainer(view:UIComponent):XComposite
		{
			while (!(view is XComposite) && view != null && view.parent != null)
			{
				view = view.parent as UIComponent;
			}
			return view as XComposite;
		}
	}
}
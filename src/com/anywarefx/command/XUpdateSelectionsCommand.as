/*
Copyright (c) 2013 2015 Dave Jackson

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

package com.anywarefx.command
{
	import com.anywarefx.model.IModel;
	import com.anywarefx.view.ISelectableView;
	
	import mx.collections.ArrayCollection;
	
	
	public class XUpdateSelectionsCommand extends XMacroCommand
	{
		private var _selections:ArrayCollection;
		private var _property:String;
		private var _value:*;
		
		
		public function XUpdateSelectionsCommand(target:*, selections:ArrayCollection, property:String, value:*)
		{
			super(target);
			_selections = new ArrayCollection(selections.toArray());
			_property = property;
			_value = value;
		}
		
		
		override public function execute():void
		{
			for each (var selection:ISelectableView in _selections)
			{
				var model:IModel = selection.model;
				if (model && model[_property] != _value)
				{
					var command:XSetPropertyCommand = new XSetPropertyCommand(model, _property, _value);
					context.execute(command);
				}
			}
		}
	}
}
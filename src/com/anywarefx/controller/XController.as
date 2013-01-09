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
    import com.anywarefx.command.XCommandContext;
    import com.anywarefx.command.XSetPropertiesCommand;
    import com.anywarefx.command.XSetPropertyCommand;
    import com.anywarefx.model.IModel;
    import com.anywarefx.view.IView;


    public class XController implements IController
    {
        private var _context:XCommandContext;
        
        
        public function get context():XCommandContext
        {
            return _context;
        }
        
        public function set context(value:XCommandContext):void
        {
            _context = value;
        }
        
        
        public function addSystemEventListeners(view:IView):void
        {
            // override
        }

        public function removeSystemEventListeners(view:IView):void
        {
            // override
        }
		
		
		public function addUserEventListeners(view:IView):void
		{
			// override
		}
		
		public function removeUserEventListeners(view:IView):void
		{
			// override
		}
        

        protected function setProperty(model:IModel, property:String, value:*):void
        {
            if (model != null && model[property] != value)
            {
                var command:XSetPropertyCommand = new XSetPropertyCommand(model, property, value);
                context.execute(command);
            }
        }
		
		
		protected function setProperties(model:IModel, properties:Array):void
		{
			var command:XSetPropertiesCommand = new XSetPropertiesCommand(model, properties);
			context.execute(command);
		}
    }
}
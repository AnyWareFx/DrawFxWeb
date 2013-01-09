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

package com.anywarefx.command
{
    import com.anywarefx.XLogger;
    
    
    public class XCommand
    {
        protected var _target:*;
        protected var _canUndo:Boolean = true;
        protected var _commandName:String = "";


        public function XCommand(target:*)
        {
            _target = target;
            XLogger.debug(this, "target: " + XLogger.getSourceName(target));
        }


        public function get target():*
        {
            return _target;
        }


        public function execute():void
        {
            // Override
        }

        public function undo():void
        {
            // Override
        }

        public function redo():void
        {
            execute();
        }


        public function get canUndo():Boolean
        {
            return _canUndo;
        }


        public function toString():String
        {
            if (_commandName.length == 0)
            {
                var className:String = XLogger.getSourceName(this);
                var index:int = className.indexOf("Command");
                if (index > 0)
                {
                    className = className.substr(1, index - 1);
                    _commandName = className.charAt(0);
                    for (index = 1; index < className.length; index++)
                    {
                        if (className.charAt(index) == className.charAt(index).toUpperCase())
                        {
                            _commandName = _commandName + " " + className.charAt(index);
                        }
                        else
                        {
                            _commandName = _commandName + className.charAt(index);
                        }
                    }
                }
            }
            return _commandName;
        }
    }
}
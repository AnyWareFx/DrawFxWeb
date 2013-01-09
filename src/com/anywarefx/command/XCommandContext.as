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
    import com.anywarefx.collection.XStack;
    
    import flash.events.TimerEvent;
    import flash.utils.Timer;


    [Bindable]
    public class XCommandContext
    {
        private var _timer:Timer;
        private var _canUndo:Boolean;
        private var _canRedo:Boolean;

        [ArrayElementType("com.anywarefx.command.XCommand")]
        private var _undoStack:XStack = new XStack();

        [ArrayElementType("com.anywarefx.command.XCommand")]
        private var _redoStack:XStack = new XStack();


        public function get canUndo():Boolean
        {
            return _canUndo;
        }

        private function set canUndo(value:Boolean):void
        {
            _canUndo = value;
        }


        public function get canRedo():Boolean
        {
            return _canRedo;
        }
        
        private function set canRedo(value:Boolean):void
        {
            _canRedo = value;
        }


        public function execute(command:XCommand):void
        {
            try
            {
                command.execute();
                if (command.canUndo)
                {
                    _undoStack.push(command);
                    _redoStack.removeAll();
                    
                    canUndo = true;
                    canRedo = false;
                }
            }
            catch (error:Error)
            {
                XLogger.error(this, "Unable to execute command: " + error.message);
            }
        }


        public function undo():void
        {
            try
            {
                if (canUndo)
                {
                    var command:XCommand = _undoStack.pop() as XCommand;
                    command.undo();
                    _redoStack.push(command);

                    canRedo = true;
                    canUndo = (_undoStack.length > 0);
                }
                else
                {
                    XLogger.warn(this, "Invalid attempt to undo last command.");
                }
            }
            catch (error:Error)
            {
                XLogger.error(this, "Unable to undo last command: " +  error.message);
            }
        }


        public function redo():void
        {
            try
            {
                if (canRedo)
                {
                    var command:XCommand = _redoStack.pop() as XCommand;
                    command.redo();
                    _undoStack.push(command);

                    canUndo = true;
                    canRedo = (_redoStack.length > 0);
                }
                else
                {
                    XLogger.warn(this, "Invalid attempt to redo last command.");
                }
            }
            catch (error:Error)
            {
                XLogger.error(this, "Unable to redo last command: " +  error.message);
            }
        }


        public function replay(interval:Number=0):void
        {
            if (canRedo)
            {
                if (interval > 0)
                {
                    if (_timer == null)
                    {
                        _timer = new Timer(interval);
                        _timer.addEventListener(TimerEvent.TIMER, onReplay);
                        _timer.start();
                    }
                    // FIXME else ???
                }
                else
                {
                    while (canRedo)
                    {
                        redo();
                    }
                }
            }
        }

        private function onReplay(event:TimerEvent):void
        {
            if (canRedo)
            {
                redo();
            }
            else if (_timer != null)
            {
                _timer.stop();
                _timer.removeEventListener(TimerEvent.TIMER, onReplay);
                _timer = null;
            }
        }


        public function rewind(interval:Number=0):void
        {
            if (canUndo)
            {
                if (interval > 0)
                {
                    if (_timer == null)
                    {
                        _timer = new Timer(interval);
                        _timer.addEventListener(TimerEvent.TIMER, onRewind);
                        _timer.start();
                    }
                    // FIXME else ???
                }
                else
                {
                    while (canUndo)
                    {
                        undo();
                    }
                }
            }
        }

        private function onRewind(event:TimerEvent):void
        {
            if (canUndo)
            {
                undo();
            }
            else if (_timer != null)
            {
                _timer.stop();
                _timer.removeEventListener(TimerEvent.TIMER, onRewind);
                _timer = null;
            }
        }

        
        public function reset():void
        {
            _undoStack.removeAll();
            _redoStack.removeAll();
            
            canUndo = false;
            canRedo = false;
        }
    } 
}
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

package com.anywarefx.rest
{
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.HTTPStatusEvent;
    import flash.events.IEventDispatcher;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLLoader;
    import flash.net.URLRequestHeader;
    
    import com.anywarefx.event.RESTEvent;


    [Event(name="complete", type="com.anywarefx.event.RESTEvent")]
    [Event(name="error",    type="com.anywarefx.event.RESTEvent")]
    [Event(name="progress", type="flash.events.ProgressEvent")]


    public class RESTResponse implements IEventDispatcher
    {
        [ArrayElementType("com.anywarefx.rest.HTTPHeader")]
        private var _headers:Array = [];
        private var _status:int;
        private var _data:*;
        private var _urlLoader:URLLoader;
        private var _dispatcher:EventDispatcher;


        public function RESTResponse(urlLoader:URLLoader)
        {
            _dispatcher = new EventDispatcher(this);
            _urlLoader = urlLoader;
            _urlLoader.addEventListener(ProgressEvent.PROGRESS, onProgress);
            _urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHTTPStatus);
            _urlLoader.addEventListener(Event.COMPLETE, onComplete);
            _urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
            _urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
        }


        public function get status():int
        {
            return _status;
        }

        [ArrayElementType("com.anywarefx.rest.HTTPHeader")]
        public function get headers():Array
        {
            return _headers;
        }

        public function get data():*
        {
            return _data;
        }


        ///////////////////////////////////////////////////////////////////////
        // IEventDispatcher Implementation
        
        public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
        {
            _dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
        }
        
        public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
        {
            _dispatcher.removeEventListener(type, listener, useCapture);
        }
        
        public function dispatchEvent(event:Event):Boolean
        {
            return _dispatcher.dispatchEvent(event);
        }
        
        public function hasEventListener(type:String):Boolean
        {
            return _dispatcher.hasEventListener(type);
        }
        
        public function willTrigger(type:String):Boolean
        {
            return _dispatcher.willTrigger(type);
        }


        ///////////////////////////////////////////////////////////////////////
        // URLLoader Event Handlers
        
        private function onProgress(event:ProgressEvent):void
        {
            dispatchEvent(event);
        }

        private function onIOError(event:IOErrorEvent):void
        {
            var errorEvent:RESTEvent = new RESTEvent(
                RESTEvent.ERROR, 
                event.text, 
                event.bubbles, 
                event.cancelable
            );
            cleanup();
            dispatchEvent(errorEvent);
        }

        private function onSecurityError(event:SecurityErrorEvent):void
        {
            var errorEvent:RESTEvent = new RESTEvent(
                RESTEvent.ERROR, 
                event.text, 
                event.bubbles, 
                event.cancelable
            );
            cleanup();
            dispatchEvent(errorEvent);
        }

        private function onHTTPStatus(event:HTTPStatusEvent):void
        {
            _status = event.status;
            for each (var header:URLRequestHeader in event.responseHeaders)
            {
                _headers.addItem(new HTTPHeader(header.name, header.value));
            }
        }

        private function onComplete(event:Event):void
        {
            _data = _urlLoader.data;
            cleanup();
            _dispatcher.dispatchEvent(new RESTEvent(RESTEvent.COMPLETE));
        }


        private function cleanup():void
        {
            _urlLoader.removeEventListener(ProgressEvent.PROGRESS, onProgress);
            _urlLoader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, onHTTPStatus);
            _urlLoader.removeEventListener(Event.COMPLETE, onComplete);
            _urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
            _urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
            _urlLoader = null;
        }
    }
}
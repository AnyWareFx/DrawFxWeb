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

package com.anywarefx.rest
{
	import com.anywarefx.data.XCodecFactory;
	import com.anywarefx.data.ICodec;
	
	
	[Event(name="complete", type="com.anywarefx.event.RESTEvent")]
	[Event(name="error",    type="com.anywarefx.event.RESTEvent")]
	[Event(name="progress", type="flash.events.ProgressEvent")]
	
	
	public class RESTResource
	{
		private var _restService:RESTService;
		private var _restResponse:RESTResponse;
		private var _service:String;
		private var _resource:String;
		private var _lastResponse:*;
		private var _contentType:String = "application/json";
		private var _codec:*;
		
		
		public function get service():String
		{
			return _service;
		}
		
		public function set service(value:String):void
		{
			_service = value;
		}
		
		
		public function get resource():String
		{
			return _resource;
		}
		
		public function set resource(value:String):void
		{
			_resource = value;
		}
		
		
		public function get contentType():String
		{
			return _contentType;
		}
		
		public function set contentType(value:String):void
		{
			_contentType = value;
		}
		
		
		public function get lastResponse():*
		{
			return _lastResponse;
		}
		
		
		public function isBusy():Boolean
		{
			return (_restResponse != null);
		}
		
		
		public function POST(data:*):void
		{
			
		}
		
		public function GET(criteria:String):void
		{
			
		}
		
		public function PUT(identifier:String, data:*):void
		{
			
		}
		
		public function DELETE(identifier:String):void
		{
			
		}
		
		
		protected function send(request:RESTRequest):void
		{
			if (!isBusy())
			{
				
			}
		}
		
		
		protected function get restService():RESTService
		{
			if (_restService == null)
			{
				_restService = new RESTService();
				_restService.address = service;
				_restService.resource = resource;
				_restService.contentType = contentType;
			}
			return _restService;
		}
		
		protected function get codec():ICodec
		{
			if (_codec == null)
			{
				_codec = XCodecFactory.createCodec(contentType);
			}
			return _codec;
		}
		
		protected function createRequest(method:String):RESTRequest
		{
			var request:RESTRequest = new RESTRequest();
			request.method = method;
			return request;
		}
	}
}
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
	import com.anywarefx.XError;
	
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	
	
	public class RESTService
	{
		private var _address:String = "http://localhost/";
		private var _contentType:String = "application/json";
		private var _resource:String;
		
		
		public function get address():String
		{
			return _address;
		}
		
		public function set address(value:String):void
		{
			_address = value;
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
		
		
		public function send(request:RESTRequest):RESTResponse
		{
			var response:RESTResponse = null;
			try
			{
				var loader:URLLoader = new URLLoader();
				response = new RESTResponse(loader);
				loader.load(createURLRequest(request));
			}
			catch(error:Error)
			{
				throw new XError("Unable to send REST request", error);
			}
			return response;
		}
		
		
		private function createURLRequest(restRequest:RESTRequest):URLRequest
		{
			// FIXME Make sure there's a "/" between the address and resource
			var resource:String = restRequest.resource || _resource;
			var urlRequest:URLRequest = new URLRequest(_address + resource);
			urlRequest.method = restRequest.method;
			var headers:Array = [];
			for each (var header:HTTPHeader in restRequest.headers)
			{
				headers.push(new URLRequestHeader(header.name, header.value));
			}
			urlRequest.requestHeaders = headers;
			if (restRequest.method == RESTRequest.POST || restRequest.method == RESTRequest.PUT)
			{
				urlRequest.data = restRequest.data;
				urlRequest.contentType = restRequest.contentType || _contentType;
			}
			return urlRequest;
		}
	}
}
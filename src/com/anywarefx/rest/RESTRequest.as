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
	public class RESTRequest
	{
		public static const GET:String = "GET";
		public static const PUT:String = "PUT";
		public static const POST:String = "POST";
		public static const DELETE:String = "DELETE";
		public static const HEAD:String = "HEAD";
		public static const OPTIONS:String = "OPTIONS";
		
		
		[ArrayElementType("com.webtopwidgets.rest.HTTPHeader")]
		private var _headers:Array = [];
		private var _method:String = GET;
		private var _resource:String;
		private var _data:*;
		private var _contentType:String;
		
		
		[ArrayElementType("com.webtopwidgets.rest.HTTPHeader")]
		public function get headers():Array
		{
			return _headers;
		}
		
		public function set headers(value:Array):void
		{
			_headers = value;
		}
		
		
		public function get method():String
		{
			return _method;
		}
		
		public function set method(value:String):void
		{
			_method = value;
		}
		
		
		public function get resource():String
		{
			return _resource;
		}
		
		public function set resource(value:String):void
		{
			_resource = value;
		}
		
		
		public function get data():*
		{
			return _data;
		}
		
		public function set data(value:*):void
		{
			_data = value;
		}
		
		
		public function get contentType():String
		{
			return _contentType;
		}
		
		public function set contentType(value:String):void
		{
			_contentType = value;
		}
	}
}
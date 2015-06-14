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

package com.anywarefx.data
{
	import flash.net.SharedObject;
	
	import mx.collections.ArrayCollection;
	
	
	public class XSharedObjectDataSource implements IDataSource
	{
		private var _storage:SharedObject;
		private var _appName:String;
		private var _type:String;
		
		
		public function get appName():String
		{
			return _appName;
		}
		
		public function set appName(value:String):void
		{
			if (_appName == null)
			{
				_appName = value;
				_storage = SharedObject.getLocal(_appName);
			}
		}
		
		
		protected function get storage():SharedObject
		{
			return _storage;
		}
		
		
		public function get type():String
		{
			return _type;
		}
		
		public function set type(value:String):void
		{
			if (_type == null)
			{
				_type = value;
			}
		}
		
		
		public function list(query:String):ArrayCollection
		{
			var records:ArrayCollection = new ArrayCollection();
			// TODO
			return records;
		}
		
		public function lookup(uid:String):*
		{
			return storage.data[type][uid];
		}
		
		
		public function insert(uid:String, json:*):void
		{
			storage.data[type] = storage.data[type] || {};
			storage.data[type][uid] = json;
			storage.flush();
		}
		
		
		public function update(uid:String, json:*):void
		{
			insert(uid, json);
		}
		
		
		public function remove(uid:String):void
		{
			delete storage.data[type][uid];
			storage.flush();
		}
	}
}
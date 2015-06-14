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
	import com.anywarefx.XFactory;
	import com.anywarefx.model.IModel;
	
	import mx.collections.ArrayCollection;
	
	
	public class XDataAccessObject implements IDataAccessObject
	{
		private var _dataSource:IDataSource;
		private var _modelType:String;
		
		
		public function get dataSource():IDataSource
		{
			return _dataSource;
		}
		
		public function set dataSource(value:IDataSource):void
		{
			if (_dataSource == null)
			{
				_dataSource = value;
			}
		}
		
		
		public function get modelType():String
		{
			return _modelType;
		}
		
		public function set modelType(value:String):void
		{
			if (_modelType == null)
			{
				_modelType = value;
			}
		}
		
		
		[ArrayElementType("com.anywarefx.model.IModel")]
		public function list(query:String):ArrayCollection
		{
			var models:ArrayCollection = new ArrayCollection();
			var data:ArrayCollection = dataSource.list(query);
			for each (var json:String in data)
			{
				var model:IModel = XFactory.instance.getComponent(modelType);
				model.fromJSON(json, true);
				models.addItem(model);
			}
			return models;
		}
		
		public function lookup(uid:String):IModel
		{
			var model:IModel = XFactory.instance.getComponent(modelType);
			model.fromJSON(dataSource.lookup(uid), true);
			return model;
		}
		
		
		public function add():IModel
		{
			return XFactory.instance.getComponent(modelType);
		}
		
		public function insert(model:IModel):void
		{
			dataSource.insert(model.uid, model.toJSON());
		}
		
		
		public function edit(uid:String):IModel
		{
			return lookup(uid);
		}
		
		public function update(model:IModel):void
		{
			dataSource.update(model.uid, model.toJSON());
		}
		
		
		public function remove(uid:String):IModel
		{
			return lookup(uid);
		}
		
		public function purge(model:IModel):void
		{
			dataSource.remove(model.uid);
		}
	}
}
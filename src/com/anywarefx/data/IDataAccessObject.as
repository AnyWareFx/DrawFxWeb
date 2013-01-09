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

package com.anywarefx.data
{
    import com.anywarefx.model.IModel;
    
    import mx.collections.ArrayCollection;


    public interface IDataAccessObject
    {
        function get dataSource():IDataSource;
        function set dataSource(value:IDataSource):void;

		function get modelType():String;
		function set modelType(value:String):void;

        [ArrayElementType("com.anywarefx.model.IModel")]
        function list(query:String):ArrayCollection;
        function lookup(uid:String):IModel;
        
        function add():IModel;
        function insert(model:IModel):void;
        
        function edit(uid:String):IModel;
        function update(model:IModel):void;
        
        function remove(uid:String):IModel;
        function purge(model:IModel):void;
    }
}
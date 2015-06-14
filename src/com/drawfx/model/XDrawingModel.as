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

package com.drawfx.model
{
	import flash.utils.flash_proxy;
	
	import mx.utils.object_proxy;
	
	use namespace flash_proxy;
	use namespace object_proxy;
	
	
	[Bindable]
	public class XDrawingModel extends XCompositeModel
	{
		public function XDrawingModel()
		{
			super();
			var model:* = {
				dateCreated: new Date(),
				createdBy: "",
				dateModified: null,
				modifiedBy: "",
				version: 1.0
			};
			plugin(model);
		}
		
		
		public function get dateCreated():Date
		{
			return getProperty("dateCreated");
		}
		
		public function set dateCreated(value:Date):void
		{
			setProperty("dateCreated", value);
		}
		
		
		public function get createdBy():String
		{
			return getProperty("createdBy");
		}
		
		public function set createdBy(value:String):void
		{
			setProperty("createdBy", value);
		}
		
		
		public function get dateModified():Date
		{
			return getProperty("dateModified");
		}
		
		public function set dateModified(value:Date):void
		{
			setProperty("dateModified", value);
		}
		
		
		public function get modifiedBy():String
		{
			return getProperty("modifiedBy");
		}
		
		public function set modifiedBy(value:String):void
		{
			setProperty("modifiedBy", value);
		}
		
		
		public function get version():Number
		{
			return getProperty("version");
		}
		
		public function set version(value:Number):void
		{
			setProperty("version", value);
		}
	}
}
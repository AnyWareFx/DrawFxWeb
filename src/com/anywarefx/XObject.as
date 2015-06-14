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

package com.anywarefx
{
	import flash.utils.getQualifiedClassName;
	
	import mx.utils.ObjectUtil;
	
	
	public class XObject
	{
		public static function extend(destination:*, source:*):*
		{
			var properties:Array = getPropertyNames(source);
			properties.forEach(function(property:*, index:int, arr:Array):void
			{
				destination[property] = source[property];
			});
			return destination;
		}
		
		
		public static function getPropertyNames(object:*):Array
		{
			var names:Array = [];
			if (getQualifiedClassName(object) == "Object")
			{
				for (var property:String in object)
				{
					names.push(property);
				}
			}
			else
			{
				names = ObjectUtil.getClassInfo(object, null, {
					includeReadOnly: true, 
					uris: ["*"]
				}).properties;
			}
			return names;
		}
	}
}
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
	import com.anywarefx.event.XFactoryEvent;
	
	import flash.events.EventDispatcher;
	import flash.system.ApplicationDomain;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	
	[Event(name="load",  type="com.anywarefx.event.XFactoryEvent")]
	[Event(name="fault", type="com.anywarefx.event.XFactoryEvent")]
	
	
	public class XFactory extends EventDispatcher
	{
		private static var _instance:XFactory = new XFactory();
		
		private var _service:HTTPService;
		private var _specs:ArrayCollection;
		private var _templates:Object = {};
		private var _singletons:Object = {};
		
		
		public static function get instance():XFactory
		{
			return _instance;
		}
		
		
		public function getComponent(name:String):*
		{
			var component:* = _singletons[name];
			try
			{
				if (!component)
				{
					var template:* = getTemplate(name);
					if (template && template.className)
					{
						var ComponentClass:Class = getClass(template.className);
						component = new ComponentClass();
						
						setExtendedProperties(component, template);
						injectDependencies(component, template);
						setProperties(component, template);
						
						if (template.singleton)
						{
							_singletons[name] = component;
						}
					}
				}
			}
			catch (error:Error)
			{
				XLogger.error(this, "Unable to get component: " + error.message);
			}
			return component;
		}
		
		
		private function getClass(className:String):Class
		{
			var ComponentClass:Class;
			try
			{
				ComponentClass = ApplicationDomain.currentDomain.getDefinition(className) as Class;
			}
			catch (error:Error)
			{
				XLogger.error(this, "Unable to get class: " + error.message);
			}
			return ComponentClass;
		}
		
		
		private function setExtendedProperties(component:*, template:*):void
		{
			try
			{
				var extensions:Array = [];
				var extension:* = template;
				while (extension.extend)
				{
					extension = getTemplate(extension.extend);
					extensions.push(extension);
				}
				while (extensions.length)
				{
					extension = extensions.pop();
					injectDependencies(component, extension);
					setProperties(component, extension);
				}
			}
			catch (error:Error)
			{
				XLogger.error(this, "Unable to set extended properties: " + error.message);
			}
		}
		
		
		private function injectDependencies(component:*, template:*):void
		{
			try
			{
				if (template.dependencies)
				{
					var dependencies:Array = getCollection(template.dependencies);
					for each (var dependency:* in dependencies)
					{
						var reference:* = getComponent(dependency.reference);
						component[dependency.name] = reference;
					}
				}
			}
			catch (error:Error)
			{
				XLogger.error(this, "Unable to inject dependencies: " + error.message);
			}
		}
		
		
		private function setProperties(component:*, template:*):void
		{
			try
			{
				if (template.properties)
				{
					var properties:Array = getCollection(template.properties);
					for each (var property:* in properties)
					{
						if (property.value != undefined)
						{
							component[property.name] = property.value;
						}
						else if (property.type == "Array")
						{
							setArrayProperty(component, property);
						}
					}
				}
			}
			catch (error:Error)
			{
				XLogger.error(this, "Unable to set properties: " + error.message);
			}
		}
		
		
		private function setArrayProperty(component:*, property:*):void
		{
			try
			{
				if (property.className)
				{
					var elements:Array = [];
					var ElementClass:Class = getClass(property.className);
					var templates:Array = getCollection(property.element);
					for each (var template:* in templates)
					{
						var element:* = new ElementClass();
						injectDependencies(element, template);
						setProperties(element, template);
						elements.push(element);
					}
					component[property.name] = elements;
				}
			}
			catch (error:Error)
			{
				XLogger.error(this, "Unable to set array property: " + error.message);
			}
		}
		
		
		private function getCollection(source:*):Array
		{
			var collection:Array;
			if (source is ArrayCollection)
			{
				collection = source.toArray();
			}
			else if (source is Array)
			{
				collection = source;
			}
			else
			{
				collection = [];
				collection.push(source);
			}
			return collection;
		}
		
		
		private function getTemplate(name:String):*
		{
			var template:* = _templates[name];
			try
			{
				if (!template)
				{
					for each (var candidate:* in _specs)
					{
						if (candidate.name == name)
						{
							_templates[name] = candidate;
							template = candidate;
							break;
						}
					}
				}
			}
			catch (error:Error)
			{
				XLogger.error(this, "Unable to get template: " + error.message);
			}
			return template;
		}
		
		
		public function initialize(specs:ArrayCollection):void
		{
			if (_specs == null)
			{
				_specs = specs;
			}
		}
		
		
		public function load(url:String=null):void
		{
			try
			{
				url = url || "config/components.xml";
				_service = new HTTPService();
				_service.addEventListener(ResultEvent.RESULT, onResult);
				_service.addEventListener(FaultEvent.FAULT, onFault);
				_service.url = url;
				_service.send();
			}
			catch (error:Error)
			{
				dispatchEvent(new XFactoryEvent(XFactoryEvent.FAULT, "Unable to load configuration: " + error.message));
			}
		}
		
		private function onLoadComplete():void
		{
			try
			{
				_service.removeEventListener(ResultEvent.RESULT, onResult);
				_service.removeEventListener(FaultEvent.FAULT, onFault);
				_service = null;
			}
			catch (error:Error)
			{
				XLogger.error(this, "Unable to release service: " + error.message);
			}
		}
		
		private function onResult(event:ResultEvent):void
		{
			try
			{
				initialize(event.result.components.component as ArrayCollection);
				dispatchEvent(new XFactoryEvent(XFactoryEvent.LOAD));
				onLoadComplete();
			}
			catch (error:Error)
			{
				dispatchEvent(new XFactoryEvent(XFactoryEvent.FAULT, "Unable to load configuration"));
			}
		}
		
		private function onFault(event:FaultEvent):void
		{
			try
			{
				onLoadComplete();
			}
			finally
			{
				dispatchEvent(new XFactoryEvent(XFactoryEvent.FAULT, "Unable to load configuration: " + event.fault.message));
			}
		}
	}
}
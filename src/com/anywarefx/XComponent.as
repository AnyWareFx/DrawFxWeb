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

package com.anywarefx
{
    import com.anywarefx.event.XPropertyChangeEvent;
    
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.utils.Proxy;
    import flash.utils.flash_proxy;
    import flash.utils.getQualifiedClassName;
    
    import mx.collections.ArrayList;
    import mx.core.IPropertyChangeNotifier;
    import mx.events.PropertyChangeEvent;
    import mx.events.PropertyChangeEventKind;
    import mx.utils.ObjectUtil;
    import mx.utils.UIDUtil;
    import mx.utils.object_proxy;
    
    use namespace flash_proxy;
    use namespace object_proxy;
    
    
    [Bindable("propertyChange")]
    public dynamic class XComponent extends Proxy implements IComponent
    {
        private   var _id:String;
        private   var _name:String;
        private   var _type:QName;
        private   var _item:Object;
        private   var _proxyLevel:int;
        private   var _plugins:ArrayList = new ArrayList();
        
        protected var _dispatcher:EventDispatcher;
        protected var _notifiers:Object;
        protected var _propertyList:ArrayList = new ArrayList();

        protected var ProxyClass:Class = XComponent;

        
        public function XComponent(item:Object = null, uid:String = null, proxyDepth:int = -1)
        {
            super();
            _item = item || {};
            _proxyLevel = proxyDepth;
            _notifiers = {};
            _dispatcher = new EventDispatcher(this);
            
            // If we got an id, use it.  Otherwise the UID is lazily
            // created in the getter for UID.
            if (uid)
            {
                _id = uid;
            }
        }

        
        // XFactory <component name="..."
        [Bindable]
        public function get name():String
        {
            return _name;
        }
        
        public function set name(value:String):void
        {
            _name = value;
        }


        // XFactory injection
        [Transient]
        public function get plugins():Array
        {
            return _plugins.toArray();
        }
        
        public function set plugins(values:Array):void
        {
            var that:XComponent = this;
            unplugAll();
            values.forEach(function(plugin:*, index:int, arr:Array):void
            {
                that.plugin(plugin, true);
            });
            syncPropertyList();
        }

        
        // Run-time management
        public function plugin(plugin:*, batch:Boolean=false):void
        {
            _plugins.addItem(plugin);
            XObject.extend(this._item, plugin);
            if (!batch)
            {
                syncPropertyList();
            }
        }
        
        public function unplug(plugin:*, batch:Boolean=false):void
        {
            if (_plugins.removeItem(plugin))
            {
                for (var property:String in plugin)
                {
                    delete _item[property];
                }
                if (!batch)
                {
                    syncPropertyList();
                }
            }
        }
        
        public function unplugAll():void
        {
            var that:XComponent = this;
            var list:Array = _plugins.toArray();
            list.forEach(function(plugin:*, index:int, arr:Array):void
            {
                that.unplug(plugin, true);
            });
            _plugins = new ArrayList();
            syncPropertyList();
        }
        
        
        protected function get object():Object
        {
            return _item;
        }

        protected function set object(value:Object):void
        {
            _item = value;
        }

        object_proxy function get type():QName
        {
            return _type;
        }
        
        object_proxy function set type(value:QName):void
        {
            _type = value;
        }
        

        public function get uid():String
        {
            if (_id === null)
                _id = UIDUtil.createUID();
            
            return _id;
        }
        
        public function set uid(value:String):void
        {
            if (UIDUtil.isUID(value))
            {
                _id = value;
            }
        }

        
        //--------------------------------------------------------------------------
        //
        //  Overridden methods
        //
        //--------------------------------------------------------------------------

        override flash_proxy function getProperty(name:*):*
        {
            // if we have a data proxy for this then
            var result:*;
            
            if (_notifiers[name.toString()])
            {
                return _notifiers[name];
            }

            result = _item[name];
            if (result)
            {
                if (_proxyLevel == 0 || ObjectUtil.isSimple(result))
                {
                    return result;
                }
                else
                {
                    result = object_proxy::getComplexProperty(name, result);
                } // if we are proxying
            }
            return result;
        }
        
        
        override flash_proxy function setProperty(name:*, value:*):void
        {
            var oldVal:* = _item[name];
            if (oldVal !== value)
            {
                // Update item.
                _item[name] = value;
                
                // Stop listening for events on old item if we currently are.
                var notifier:IPropertyChangeNotifier = _notifiers[name] as IPropertyChangeNotifier;
                if (notifier)
                {
                    notifier.removeEventListener(
                        PropertyChangeEvent.PROPERTY_CHANGE,
                        propertyChangeHandler);
                    delete _notifiers[name];
                }
                
                // Notify anyone interested.
                notifyPropertyChanged(name, oldVal, value);
            }
        }
        

        override flash_proxy function callProperty(name:*, ... rest):*
        {
            return _item[name].apply(_item, rest)
        }
        

        override flash_proxy function deleteProperty(name:*):Boolean
        {
            var notifier:IPropertyChangeNotifier = IPropertyChangeNotifier(_notifiers[name]);
            if (notifier)
            {
                notifier.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, propertyChangeHandler);
                delete _notifiers[name];
            }
            
            var oldVal:* = _item[name];
            var deleted:Boolean = delete _item[name]; 
            
            notifyPropertyChanged(name, oldVal, null, PropertyChangeEventKind.DELETE);
            return deleted;
        }
        

        override flash_proxy function hasProperty(name:*):Boolean
        {
            return (name in _item);
        }
        

        override flash_proxy function nextName(index:int):String
        {
            return _propertyList[index -1];
        }
        

        override flash_proxy function nextNameIndex(index:int):int
        {
            if (index == 0)
            {
                syncPropertyList();
            }
            
            if (index < _propertyList.length)
            {
                return index + 1;
            }
            else
            {
                return 0;
            }
        }
        

        override flash_proxy function nextValue(index:int):*
        {
            return _item[_propertyList[index - 1]];
        }

        
        //--------------------------------------------------------------------------
        //
        //  object_proxy methods
        //
        //--------------------------------------------------------------------------
        
        object_proxy function getComplexProperty(name:*, value:*):*
        {
            if (value is IPropertyChangeNotifier)
            {
                value.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,
                    propertyChangeHandler);
                _notifiers[name] = value;
                return value;
            }
            
            if (getQualifiedClassName(value) == "Object")
            {
                value = new ProxyClass(_item[name], null, _proxyLevel > 0 ? _proxyLevel - 1 : _proxyLevel);
                value.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, propertyChangeHandler);
                _notifiers[name] = value;
                return value;
            }
            return value;
        }

        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------

        public function addEventListener(type:String, listener:Function,
                                         useCapture:Boolean = false,
                                         priority:int = 0,
                                         useWeakReference:Boolean = false):void
        {
            _dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
        }
        

        public function removeEventListener(type:String, listener:Function,
                                            useCapture:Boolean = false):void
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
        

        public function propertyChangeHandler(event:PropertyChangeEvent):void
        {
            _dispatcher.dispatchEvent(event);
        }

        
        //--------------------------------------------------------------------------
        //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        protected function notifyPropertyChanged(name:*, oldValue:*, newValue:*, kind:String=null):void
        {
            if (_dispatcher.hasEventListener(PropertyChangeEvent.PROPERTY_CHANGE))
            {
                if (name is QName)
                {
                    name = QName(name).localName;
                }
                var event:PropertyChangeEvent =  XPropertyChangeEvent.createUpdateEvent(
                    this, name.toString(), oldValue, newValue);

                if (kind != null)
                {
                    event.kind = kind;
                }
                _dispatcher.dispatchEvent(event);
            } 
        }
        

        protected function syncPropertyList():void
        {
            if (_propertyList != null)
            {
                _propertyList.removeAll();
            }
            _propertyList = new ArrayList(XObject.getPropertyNames(_item));
        }
    }
}

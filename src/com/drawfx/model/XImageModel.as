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

package com.drawfx.model
{
    import com.drawfx.fx.model.FxModel;
    import com.drawfx.fx.model.IFxEnabledModel;
    
    import flash.utils.ByteArray;
    import flash.utils.flash_proxy;
    
    import mx.utils.object_proxy;
    
    use namespace flash_proxy;
    use namespace object_proxy;
    
    
    [Bindable]
    public class XImageModel extends XCompositeModel implements IBoundedModel, IConstrainedModel, IFxEnabledModel
    {
        public function XImageModel()
        {
            super();
            var model:* = {
                bounds: null,
                constraints: null,
                alpha: 1.0, 
                scaleContent: true, 
                autoLoad: true, 
                maintainAspectRatio: true, 
                smoothBitmapContent: true, 
                sourceClass: null,
                sourcePath: null,
                sourceData: null,
                fx: null
            };
            plugin(model);
        }
        
        
        public function get bounds():XBoundsModel
        {
            return getProperty("bounds");
        }
        
        public function set bounds(value:XBoundsModel):void
        {
            setProperty("bounds", value);
        }
        
        
        public function get constraints():XConstraintsModel
        {
            return getProperty("constraints");
        }
        
        public function set constraints(value:XConstraintsModel):void
        {
            setProperty("constraints", value);
        }
        
        
        public function get alpha():Number
        {
            return getProperty("alpha");
        }
        
        public function set alpha(value:Number):void
        {
            setProperty("alpha", value);
        }
        
        
        public function get scaleContent():Boolean
        {
            return getProperty("scaleContent");
        }
        
        public function set scaleContent(value:Boolean):void
        {
            setProperty("scaleContent", value);
        }
        
        
        public function get autoLoad():Boolean
        {
            return getProperty("autoLoad");
        }
        
        public function set autoLoad(value:Boolean):void
        {
            setProperty("autoLoad", value);
        }
        
        
        public function get maintainAspectRatio():Boolean
        {
            return getProperty("maintainAspectRatio");
        }
        
        public function set maintainAspectRatio(value:Boolean):void
        {
            setProperty("maintainAspectRatio", value);
        }
        
        
        public function get smoothBitmapContent():Boolean
        {
            return getProperty("smoothBitmapContent");
        }
        
        public function set smoothBitmapContent(value:Boolean):void
        {
            setProperty("smoothBitmapContent", value);
        }
        
        
        public function get sourcePath():String
        {
            return getProperty("sourcePath");
        }
        
        public function set sourcePath(value:String):void
        {
            if (value != null)
            {
                sourceClass = null;
                sourceData = null;
            }
            setProperty("sourcePath", value);
        }
        
        
        public function get sourceClass():Class
        {
            return getProperty("sourceClass");
        }
        
        public function set sourceClass(value:Class):void
        {
            if (value != null)
            {
                sourcePath = null;
                sourceData = null;
            }
            setProperty("sourceClass", value);
        }
        
        
        public function get sourceData():ByteArray
        {
            return getProperty("sourceData");
        }
        
        public function set sourceData(value:ByteArray):void
        {
            if (value != null)
            {
                sourcePath = null;
                sourceClass = null;
            }
            setProperty("sourceData", value);
        }
        
        
        public function get fx():FxModel
        {
            return getProperty("fx");
        }
        
        public function set fx(value:FxModel):void
        {
            setProperty("fx", value);
        }
    }
}
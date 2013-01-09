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
    import com.anywarefx.model.XModel;
    
    import flash.utils.flash_proxy;
    
    import mx.utils.object_proxy;
    
    use namespace flash_proxy;
    use namespace object_proxy;
    
    
    [Bindable]
    public class XConstraintsModel extends XModel
    {
        public function XConstraintsModel()
        {
            super();
            var model:* = {
                top: 0,
                left: 0,
                bottom: 0,
                right: 0,
                horizontalCenter: 0,
                verticalCenter: 0
            };
            plugin(model);
        }
        
        
        public function get top():Number
        {
            return getProperty("top");
        }
        
        public function set top(value:Number):void
        {
            setProperty("top", value);
        }
        
        
        public function get left():Number
        {
            return getProperty("left");
        }
        
        public function set left(value:Number):void
        {
            setProperty("left", value);
        }
        
        
        public function get bottom():Number
        {
            return getProperty("bottom");
        }
        
        public function set bottom(value:Number):void
        {
            setProperty("bottom", value);
        }
        
        
        public function get right():Number
        {
            return getProperty("right");
        }
        
        public function set right(value:Number):void
        {
            setProperty("right", value);
        }
        
        
        public function get horizontalCenter():Number
        {
            return getProperty("horizontalCenter");
        }
        
        public function set horizontalCenter(value:Number):void
        {
            setProperty("horizontalCenter", value);
        }
        
        
        public function get verticalCenter():Number
        {
            return getProperty("verticalCenter");
        }
        
        public function set verticalCenter(value:Number):void
        {
            setProperty("verticalCenter", value);
        }
    }
}
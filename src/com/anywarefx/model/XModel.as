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

package com.anywarefx.model
{
    import com.anywarefx.XComponent;
    import com.anywarefx.XFactory;
    import com.anywarefx.data.JSONCodec;
    
    import flash.utils.IDataInput;
    import flash.utils.IDataOutput;
    import flash.utils.describeType;
    import flash.utils.getQualifiedClassName;
    
    import mx.collections.ArrayCollection;
    import mx.utils.Base64Decoder;
    import mx.utils.ObjectUtil;
    

    public class XModel extends XComponent implements IModel
    {
		private var _rev:String = ''; // FIXME Implement revisions


		public function XModel(item:Object=null, uid:String=null, proxyDepth:int=-1)
        {
            super(item, uid, proxyDepth);
        }

        
		public function get rev():String
		{
			return _rev;
		}


        public function copy():IModel
        {
            var className:String = getQualifiedClassName(this);
            var start:Number = className.indexOf("::") + 2;
            var end:Number = className.length;
            var newModel:XModel = XFactory.instance.getComponent(className.substring(start, end));
            newModel.fromJSON(this.toJSON());
            return newModel;
        }

        public function copyFrom(other:IModel):void
        {
            fromJSON(other.toJSON());
        }
        
        
        public function clone():IModel
        {
            var className:String = getQualifiedClassName(this);
            var start:Number = className.indexOf("::") + 2;
            var end:Number = className.length;
            var newModel:XModel = XFactory.instance.getComponent(className.substring(start, end));
            newModel.fromJSON(this.toJSON(), true);
            return newModel;
        }


        public function toJSON():String
        {
			return new JSONCodec().encode(this)
        }
        
        public function fromJSON(json:*, clone:Boolean=false):void
        {
            var state:* = (json is String) ? new JSONCodec().decode(json) : json;
            var classInfo:XML = describeType(this);

            for each (var member:XML in classInfo..*.(
                (name() == "variable") || 
                (name() == "accessor" && attribute("access") == "readwrite")
            ))
            {
                var propertyName:String = member.@name.toString();
                var propertyType:String = member.@type.toString();
                var property:* = this[propertyName];
                if (state[propertyName] != undefined)
                {
                    if (property is Date)
                    {
                        var date:Date = new Date();
                        date.setTime(state[propertyName].time)
                        this[propertyName] = date;
                    }
                    else if (propertyType == "flash.utils::ByteArray")
                    {
                        var decoder:Base64Decoder = new Base64Decoder();
                        decoder.decode(unescape(state[propertyName]));
                        this[propertyName] = decoder.toByteArray();
                    }
                    else if (ObjectUtil.isSimple(property) && (propertyName != "uid" || clone))
                    {
                        this[propertyName] = state[propertyName];
                    }
                    else if (property is IModel)
                    {
                        (property as IModel).fromJSON(state[propertyName], clone);
                    }
                    else if (property is ArrayCollection)
                    {
                        var collection:* = state[propertyName];
                        if (collection.length > 0 && member.metadata && member.metadata.(@name == "ArrayElementType").length() == 1)
                        {
                            var type:String = new String(member.metadata.(@name == "ArrayElementType").arg.@value);
                            type = type.substr(type.lastIndexOf('.') + 1);
                            for each (var item:* in collection)
                            {
                                var model:IModel = XFactory.instance.getComponent(type);
                                model.fromJSON(item, clone);
                                (property as ArrayCollection).addItem(model);

                                // Added back-pointer support
                                if ((model as Object).hasOwnProperty("parent"))
                                {
                                    model["parent"] = this;
                                }
                            }
                        }
                    }
                }
            }
        }
        
        
        //--------------------------------------------------------------------------
        //
        //  IExternalizable Methods
        //
        //--------------------------------------------------------------------------
        
        public function readExternal(input:IDataInput):void
        {
            var value:Object = input.readObject();
            this.object = value;
        }
        
        public function writeExternal(output:IDataOutput):void
        {
            output.writeObject(this.object);
        }
    }
}
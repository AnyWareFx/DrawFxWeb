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
    import flash.utils.describeType;
    import flash.xml.XMLDocument;
    
    import mx.rpc.xml.SimpleXMLDecoder;
    import mx.rpc.xml.SimpleXMLEncoder;
    
    import com.anywarefx.XError;

    public class XMLCodec implements ICodec
    {
        public function encode(data:*):*
        {
            var xml:XML;
            try
            {
                var classInfo:XML = describeType(this);
                var className:String = classInfo.@name.toString();
                var start:Number = className.indexOf("::") + 2;
                var end:Number = className.length;
                var root:String = className.substring(start, end).toLowerCase(); // TODO XxxYyy => xxx-yyy??
                var qName:QName = new QName(root);
                var xmlDocument:XMLDocument = new XMLDocument();
                var encoder:SimpleXMLEncoder = new SimpleXMLEncoder(xmlDocument);
                encoder.encodeValue(this, qName, xmlDocument);
                xml = new XML(xmlDocument.toString());
            }
            catch (error:Error)
            {
                throw new XError("XMLCodec - Unable to encode to XML", error);
            }
            return xml;
        }
        
        public function decode(data:*):*
        {
            var decoded:*;
            try
            {
                var decoder:SimpleXMLDecoder = new SimpleXMLDecoder();
                var xmlDocument:XMLDocument = new XMLDocument(data.toXMLString());
                decoded = decoder.decodeXML(xmlDocument);
            }
            catch (error:Error)
            {
                throw new XError("XMLCodec - Unable to decode from XML", error);
            }
            return decoded;
        }
    }
}
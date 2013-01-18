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
    import com.anywarefx.command.XCommandContext;
    import com.anywarefx.manager.XSelectionManager;
    import com.anywarefx.model.IModel;
    import com.anywarefx.view.IView;
    
    import mx.collections.ArrayCollection;


    public interface IDocument extends IComponent
    {
        function get model():IModel;
        function set model(value:IModel):void;
        
        function get views():*;
        function set views(value:*):void;
        
        function get defaultView():String;
        function set defaultView(value:String):void;

        function openView(name:String):IView;
        function closeView(name:String):IView;
        
        [ArrayElementType("com.anywarefx.controller.XUIController")]
        function get controllers():ArrayCollection;
        function set controllers(value:ArrayCollection):void;
        
        function get context():XCommandContext;
        function set context(value:XCommandContext):void;
        
        function get selectionManager():XSelectionManager;
        function set selectionManager(value:XSelectionManager):void;
    }
}
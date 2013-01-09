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

package com.drawfx.command
{
    import com.drawfx.model.IBoundedModel;
    import com.drawfx.model.XCompositeModel;
    import com.drawfx.model.XGroupModel;
    import com.drawfx.model.XImageModel;
    import com.drawfx.model.XLineModel;
    import com.drawfx.model.XShapeModel;
    import com.drawfx.model.XTextBoxModel;


    public class XDrawingCommandFactory
    {
        public static function createAddCommand(parent:XCompositeModel, model:IBoundedModel):XDrawingCommand
        {
            var command:XDrawingCommand;
            if (model is XLineModel)
            {
                command = new XAddLineCommand(parent, model as XLineModel);
            }
            else if (model is XGroupModel)
            {
                command = new XAddGroupCommand(parent, model as XGroupModel);
            }
            else if (model is XImageModel)
            {
                command = new XAddImageCommand(parent, model as XImageModel);
            }
            else if (model is XShapeModel)
            {
                command = new XAddShapeCommand(parent, model as XShapeModel);
            }
            else if (model is XTextBoxModel)
            {
                command = new XAddTextBoxCommand(parent, model as XTextBoxModel);
            }
            return command;
        }


        public static function createRemoveCommand(parent:XCompositeModel, model:IBoundedModel):XDrawingCommand
        {
            var command:XDrawingCommand;
            if (model is XLineModel)
            {
                command = new XRemoveLineCommand(parent, model as XLineModel);
            }
            else if (model is XGroupModel)
            {
                command = new XRemoveGroupCommand(parent, model as XGroupModel);
            }
            else if (model is XImageModel)
            {
                command = new XRemoveImageCommand(parent, model as XImageModel);
            }
            else if (model is XShapeModel)
            {
                command = new XRemoveShapeCommand(parent, model as XShapeModel);
            }
            else if (model is XTextBoxModel)
            {
                command = new XRemoveTextBoxCommand(parent, model as XTextBoxModel);
            }
            return command;
        }
    }
}
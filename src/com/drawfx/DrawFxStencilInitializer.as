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

package com.drawfx
{
	import com.anywarefx.XFactory;
	import com.drawfx.model.XImageModel;
	import com.drawfx.model.XLineModel;
	import com.drawfx.model.XShapeModel;
	import com.drawfx.model.XStencilModel;
	import com.drawfx.model.XTextBoxModel;
	
	import flash.net.SharedObject;
	
	import mx.collections.ArrayCollection;
	
	import assets.Images;
	
	
	public class DrawFxStencilInitializer
	{
		public static function initialize(name:String):XStencilModel
		{
			var model:XStencilModel = XFactory.instance.getComponent("XStencilModel");
			if (model != null)
			{
				var storage:SharedObject = SharedObject.getLocal("drawfx");
				storage.data.stencils = storage.data.stencils || {};
				// if (storage.data.stencils[name] != null)
				if (name != "Basic" && storage.data.stencils[name] != null)
				{
					model.fromJSON(storage.data.stencils[name]);
				}
				else if (name == "Basic")
				{
					var lines:ArrayCollection = new ArrayCollection();
					var images:ArrayCollection = new ArrayCollection();
					var shapes:ArrayCollection = new ArrayCollection();
					var textBoxes:ArrayCollection = new ArrayCollection();
					
					var rectangleModel:XShapeModel = XFactory.instance.getComponent("XShapeModel");
					shapes.addItem(rectangleModel);
					
					var roundedRectModel:XShapeModel = XFactory.instance.getComponent("XShapeModel");
					roundedRectModel.border.cornerRadius = 20;
					shapes.addItem(roundedRectModel);
					
					var squareModel:XShapeModel = XFactory.instance.getComponent("XShapeModel");
					squareModel.bounds.width = 75;
					squareModel.textBox.bounds.width = 75;
					shapes.addItem(squareModel);
					
					var diamondModel:XShapeModel = XFactory.instance.getComponent("XShapeModel");
					diamondModel.bounds.width = 75;
					diamondModel.bounds.rotationZ = 45;
					diamondModel.textBox.bounds.width = 75;
					diamondModel.textBox.bounds.rotationZ = -45;
					shapes.addItem(diamondModel);
					
					var circleModel:XShapeModel = XFactory.instance.getComponent("XShapeModel");
					circleModel.bounds.width = 75;
					circleModel.border.cornerRadius = 38;
					circleModel.textBox.bounds.width = 75;
					shapes.addItem(circleModel);
					
					var textBoxModel:XTextBoxModel = XFactory.instance.getComponent("XTextBoxModel");
					textBoxModel.text = "Text Box";
					textBoxModel.bounds.width = 100;
					textBoxModel.bounds.height = 50;
					textBoxes.addItem(textBoxModel);
					
					var imageModel:XImageModel = XFactory.instance.getComponent("XImageModel");
					imageModel.bounds.width = 64;
					imageModel.bounds.height = 64;
					imageModel.sourceClass = Images.ImageThumbnail;
					images.addItem(imageModel);
					
					var lineModel:XLineModel = XFactory.instance.getComponent("XLineModel");
					lines.addItem(lineModel);
					
					model.lines = lines;
					model.images = images;
					model.shapes = shapes;
					model.textBoxes = textBoxes;
					
					storage.data.stencils.Basic = model.toJSON();
					storage.flush();
				}
			}
			return model;
		}
	}
}
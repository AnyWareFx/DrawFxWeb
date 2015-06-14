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
	import com.anywarefx.command.XCommandContext; XCommandContext;
	import com.anywarefx.manager.XSelectionManager; XSelectionManager;
	import com.drawfx.controller.XBoundedMouseController; XBoundedMouseController;
	import com.drawfx.controller.XConstraintController; XConstraintController;
	import com.drawfx.controller.XCompositeDropController; XCompositeDropController;
	import com.drawfx.controller.XDrawingKeyboardController; XDrawingKeyboardController;
	import com.drawfx.controller.XDrawingMouseController; XDrawingMouseController;
	import com.drawfx.controller.XGroupMouseController; XGroupMouseController;
	import com.drawfx.controller.XShapeKeyboardController; XShapeKeyboardController;
	import com.drawfx.controller.XStencilDropController; XStencilDropController;
	import com.drawfx.controller.XStencilMouseController; XStencilMouseController;
	import com.drawfx.controller.XTextBoxKeyboardController; XTextBoxKeyboardController;
	import com.drawfx.fx.model.FxModel; FxModel;
	import com.drawfx.fx.model.XBevelModel; XBevelModel;
	import com.drawfx.fx.model.XBlurModel; XBlurModel;
	import com.drawfx.fx.model.XDropShadowModel; XDropShadowModel;
	import com.drawfx.fx.model.XGlowModel; XGlowModel;
	import com.drawfx.model.XConstraintsModel; XConstraintsModel;
	import com.drawfx.model.XBorderModel; XBorderModel;
	import com.drawfx.model.XBoundsModel; XBoundsModel;
	import com.drawfx.model.XDrawingModel; XDrawingModel;
	import com.drawfx.model.XGroupModel; XGroupModel;
	import com.drawfx.model.XImageModel; XImageModel;
	import com.drawfx.model.XLineModel; XLineModel;
	import com.drawfx.model.XShapeModel; XShapeModel;
	import com.drawfx.model.XStencilModel; XStencilModel;
	import com.drawfx.model.XTextBoxModel; XTextBoxModel;
	import com.drawfx.model.XTextFormatModel; XTextFormatModel;
	import com.drawfx.view.XDrawing; XDrawing;
	import com.drawfx.view.XGroup; XGroup;
	import com.drawfx.view.XImage; XImage;
	import com.drawfx.view.XLine; XLine;
	import com.drawfx.view.XShape; XShape;
	import com.drawfx.view.XStencil; XStencil;
	import com.drawfx.view.XStencilDesigner; XStencilDesigner;
	import com.drawfx.view.XTextBox; XTextBox;
	
	import mx.collections.ArrayCollection;
	import mx.logging.LogEventLevel;
	import mx.logging.targets.TraceTarget; TraceTarget;
	
	import spark.components.NavigatorContent; NavigatorContent;
	import spark.components.Scroller; Scroller;
	import spark.layouts.TileLayout; TileLayout;
	
	
	public class DrawFxFactoryInitializer
	{
		public static function initialize():void
		{
			var specs:ArrayCollection = new ArrayCollection([{
				name: "TraceTarget",
				className: "mx.logging.targets.TraceTarget",
				properties: [{
					name: "level",
					value: LogEventLevel.ERROR
				}, {
					name: "includeDate",
					value: true
				}, {
					name: "includeTime",
					value: true
				}, {
					name: "includeCategory",
					value: true
				}, {
					name: "includeLevel",
					value: true
				}
				]
			}, {
				name: "NavigatorContent",
				className: "spark.components.NavigatorContent",
				properties: [{
					name: "percentWidth",
					value: 100
				}, {
					name: "percentHeight",
					value: 100
				}
				]
			}, {
				name: "Scroller",
				className: "spark.components.Scroller",
				properties: [{
					name: "percentWidth",
					value: 100
				}, {
					name: "percentHeight",
					value: 100
				}
				]
			}, {
				name: "TileLayout",
				className: "spark.layouts.TileLayout",
				properties: [{
					name: "horizontalAlign",
					value: "center"
				}, {
					name: "verticalAlign",
					value: "middle"
				}, {
					name: "columnAlign",
					value: "justifyUsingWidth"
				}, {
					name: "verticalGap",
					value: 30
				}, {
					name: "requestedColumnCount",
					value: 1
				}
				]
			}, {
				name: "XStencilDocument",
				className: "com.drawfx.XStencilDocument",
				dependencies: [{
					name: "model",
					reference: "XStencilModel"
				}, {
					name: "context",
					reference: "XCommandContext"
				}, {
					name: "selectionManager",
					reference: "XSelectionManager"
				}
				]
			}, {
				name: "XStencil",
				className: "com.drawfx.view.XStencil",
				dependencies: [{
					name: "layout",
					reference: "TileLayout"
				}
				],
				properties: [{
					name: "top",
					value: 5
				}, {
					name: "bottom",
					value: 5
				}, {
					name: "left",
					value: 5
				}, {
					name: "right",
					value: 5
				}, {
					name: "scaleX",
					value: 0.67
				}, { 
					name: "scaleY",
					value: 0.67
				}, { 
					name: "clipAndEnableScrolling",
					value: true
				}
				]
			}, {
				name: "XStencilDesigner",
				className: "com.drawfx.view.XStencilDesigner"
			}, {
				name: "XStencilModel",
				className: "com.drawfx.model.XStencilModel",
				properties: [{
					name: "name",
					value: "New Stencil"
				}
				]
			}, {
				name: "XDrawingDocument",
				className: "com.drawfx.XDrawingDocument",
				properties: [{
					name: "defaultView",
					value: "XDrawing"
				}
				],
				dependencies: [{
					name: "model",
					reference: "XDrawingModel"
				}, {
					name: "context",
					reference: "XCommandContext"
				}, {
					name: "selectionManager",
					reference: "XSelectionManager"
				}
				]
			}, {
				name: "XDrawing",
				className: "com.drawfx.view.XDrawing"
			}, {
				name: "XDrawingModel",
				className: "com.drawfx.model.XDrawingModel",
				properties: [{
					name: "name",
					value: "New Drawing"
				}
				]
			}, {
				name: "XGroup",
				className: "com.drawfx.view.XGroup",
				properties: [{
					name: "selectable",
					value: true
				}
				]
			}, {
				name: "XGroupModel",
				className: "com.drawfx.model.XGroupModel",
				dependencies: [{
					name: "bounds",
					reference: "XGroupBoundsModel"
				}
				]
			}, {
				name: "XGroupBoundsModel",
				className: "com.drawfx.model.XBoundsModel",
				properties: [{
					name: "x",
					value: Number.MAX_VALUE
				}, {
					name: "y",
					value: Number.MAX_VALUE
				}, {
					name: "width",
					value: 0
				}, {
					name: "height",
					value: 0
				}
				]
			}, {
				name: "XImage",
				className: "com.drawfx.view.XImage",
				properties: [{
					name: "selectable",
					value: true
				}
				]
			}, {
				name: "XImageModel",
				className: "com.drawfx.model.XImageModel",
				dependencies: [{
					name: "bounds",
					reference: "XBoundsModel"
				}, {
					name: "constraints",
					reference: "XConstraintsModel"
				}, {
					name: "fx",
					reference: "FxModel"
				}
				]
			}, {
				name: "XLine",
				className: "com.drawfx.view.XLine",
				properties: [{
					name: "selectable",
					value: true
				}
				]
			}, {
				name: "XLineModel",
				className: "com.drawfx.model.XLineModel",
				dependencies: [{
					name: "bounds",
					reference: "XLineBoundsModel"
				}, {
					name: "constraints",
					reference: "XConstraintsModel"
				}, {
					name: "stroke",
					reference: "XLineStrokeModel"
				}, {
					name: "fx",
					reference: "FxModel"
				}
				],
				properties: [{
					name: "affordance",
					value: 7
				}
				]
			}, {
				name: "XShape",
				className: "com.drawfx.view.XShape",
				properties: [{
					name: "selectable",
					value: true
				}
				]
			}, {
				name: "XShapeModel",
				className: "com.drawfx.model.XShapeModel",
				dependencies: [{
					name: "bounds",
					reference: "XBoundsModel"
				}, {
					name: "constraints",
					reference: "XConstraintsModel"
				}, {
					name: "textBox",
					reference: "XTextBoxModel"
				}, {
					name: "fill",
					reference: "XFillModel"
				}, {
					name: "border",
					reference: "XBorderModel"
				}, {
					name: "stroke",
					reference: "XStrokeModel"
				}, {
					name: "fx",
					reference: "FxModel"
				}
				]
			}, {
				name: "XTextBox",
				className: "com.drawfx.view.XTextBox",
				properties: [{
					name: "selectable",
					value: true
				}
				]
			}, {
				name: "XTextBoxModel",
				className: "com.drawfx.model.XTextBoxModel",
				dependencies: [{
					name: "bounds",
					reference: "XBoundsModel"
				}, {
					name: "constraints",
					reference: "XConstraintsModel"
				}, {
					name: "format",
					reference: "XTextFormatModel"
				}, {
					name: "fx",
					reference: "FxModel"
				}
				]
			}, {
				name: "XTextFormatModel",
				className: "com.drawfx.model.XTextFormatModel",
				properties: [{
					name: "fontSize",
					value: 22
				}
				]
			}, {
				name: "XBoundsModel",
				className: "com.drawfx.model.XBoundsModel",
				properties: [{
					name: "width",
					value: 150
				}, {
					name: "height",
					value: 75
				}
				]
			}, {
				name: "XLineBoundsModel",
				className: "com.drawfx.model.XBoundsModel",
				properties: [{
					name: "width",
					value: 100
				}, {
					name: "height",
					value: 17
				}
				]
			}, {
				name: "XConstraintsModel",
				className: "com.drawfx.model.XConstraintsModel",
				properties: [{
					name: "top",
					value: NaN
				}, {
					name: "left",
					value: NaN
				}, {
					name: "bottom",
					value: NaN
				}, {
					name: "right",
					value: NaN
				}, {
					name: "horizontalCenter",
					value: NaN
				}, {
					name: "verticalCenter",
					value: NaN
				}
				]
			}, {
				name: "XBorderModel",
				className: "com.drawfx.model.XBorderModel"
			}, {
				name: "XStrokeModel",
				className: "com.drawfx.model.XStrokeModel"
			}, {
				name: "XLineStrokeModel",
				className: "com.drawfx.model.XStrokeModel",
				properties: [{
					name: "weight",
					value: 3
				}
				]
			}, {
				name: "XFillModel",
				className: "com.drawfx.model.XFillModel",
				properties: [{
					name: "color",
					value: 0xCDCDCD
				}
				]
			}, {
				name: "FxModel",
				className: "com.drawfx.fx.model.FxModel",
				dependencies: [{
					name: "bevel",
					reference: "XBevelModel"
				}, {
					name: "blur",
					reference: "XBlurModel"
				}, {
					name: "dropShadow",
					reference: "XDropShadowModel"
				}, {
					name: "glow",
					reference: "XGlowModel"
				}
				]
			}, {
				name: "XBevelModel",
				className: "com.drawfx.fx.model.XBevelModel"
			}, {
				name: "XBlurModel",
				className: "com.drawfx.fx.model.XBlurModel"
			}, {
				name: "XDropShadowModel",
				className: "com.drawfx.fx.model.XDropShadowModel"
			}, {
				name: "XGlowModel",
				className: "com.drawfx.fx.model.XGlowModel"
			}, {
				name: "XBoundedMouseController",
				className: "com.drawfx.controller.XBoundedMouseController"
			}, {
				name: "XConstraintController",
				className: "com.drawfx.controller.XConstraintController"
			}, {
				name: "XCompositeDropController",
				className: "com.drawfx.controller.XCompositeDropController"
			}, {
				name: "XStencilDropController",
				className: "com.drawfx.controller.XStencilDropController"
			}, {
				name: "XStencilMouseController",
				className: "com.drawfx.controller.XStencilMouseController"
			}, {
				name: "XDrawingKeyboardController",
				className: "com.drawfx.controller.XDrawingKeyboardController"
			}, {
				name: "XDrawingMouseController",
				className: "com.drawfx.controller.XDrawingMouseController"
			}, {
				name: "XGroupMouseController",
				className: "com.drawfx.controller.XGroupMouseController"
			}, {
				name: "XShapeKeyboardController",
				className: "com.drawfx.controller.XShapeKeyboardController"
			}, {
				name: "XTextBoxKeyboardController",
				className: "com.drawfx.controller.XTextBoxKeyboardController"
			}, {
				name: "XSelectionManager",
				className: "com.anywarefx.manager.XSelectionManager",
				properties: [{
					name: "policy",
					value: "multiSelect"
				}
				]
			}, {
				name: "XCommandContext",
				className: "com.anywarefx.command.XCommandContext"
			}]);
			XFactory.instance.initialize(specs);
		}
	}
}
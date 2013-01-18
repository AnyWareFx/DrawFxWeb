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

package com.anywarefx.manager
{
    import com.anywarefx.XComponent;
    import com.anywarefx.view.XSelectableView;
    
    import mx.collections.ArrayCollection;
    import mx.core.UIComponent;
    
    import flash.utils.flash_proxy;
    
    import mx.utils.object_proxy;

    use namespace flash_proxy;
    use namespace object_proxy;


    [Bindable]
    public class XSelectionManager extends XComponent
    {
        public static const DISABLED:String      = "disabled";
        public static const SINGLE_SELECT:String = "singleSelect";
        public static const MULTI_SELECT:String  = "multiSelect";


        public function XSelectionManager()
        {
            super();
            var model:* = {
                policy: SINGLE_SELECT,
                selections: new ArrayCollection(),
                lastSelection: null,
                count: 0
            };
            plugin(model);
        }

        [ArrayElementType("com.anywarefx.view.XSelectableView")]
        public function get selections():ArrayCollection
        {
            return getProperty("selections");;
        }

        private function set selections(value:ArrayCollection):void
        {
            setProperty("selections", value);
        }


        public function get lastSelection():XSelectableView
        {
            return getProperty("lastSelection");
        }
        
        private function set lastSelection(value:XSelectableView):void
        {
            setProperty("lastSelection", value);
        }


        public function get policy():String
        {
            return getProperty("policy");
        }

        public function set policy(value:String):void
        {
            setProperty("policy", value);
        }


        public function get count():Number
        {
            return getProperty("count");
        }
        
        public function set count(value:Number):void
        {
            setProperty("count", value);
        }


        public function addSelection(selection:XSelectableView):void
        {
            if (policy != DISABLED && !selections.contains(selection))
            {
                if (selection.selectable)
                {
                    if (policy == SINGLE_SELECT)
                    {
                        clearSelections();
                        lastSelection = null;
                    }
                    selection.selected = true;
                    selections.addItem(selection);
                    lastSelection = selection;
                    count = selections.length;
                    (selection as UIComponent).setFocus();
                }
            }
        }

        public function removeSelection(selection:XSelectableView):void
        {
            if (policy != DISABLED && selections.length > 0)
            {
                var index:Number = selections.getItemIndex(selection);
                if (index != -1)
                {
                    if (selection.selectable)
                    {
                        selection.selected = false;
                        selections.removeItemAt(index);
                        lastSelection = (selections.length > 0) ? selections[selections.length - 1] : null;
                        count = selections.length;
                    }
                }
            }
        }

        public function clearSelections():void
        {
            if (policy != DISABLED && selections.length > 0)
            {
                var collection:Array = selections.toArray();
                for each (var selection:XSelectableView in collection)
                {
                    removeSelection(selection);
                }
                lastSelection = null;
                count = 0;
            }
        }
    }
}
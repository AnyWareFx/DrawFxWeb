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

package com.anywarefx
{
	public dynamic class XStateMachine extends XComponent
	{
		private var _states:*;
		private var _initialState:String;
		private var _currentState:String;
		private var _previousState:String;
		
		
		public function XStateMachine()
		{
			super();
			
			// Provide states the ability to transition to the next state
			var that:XStateMachine = this;
			var machine:* = {
				transitionTo: function(state:String):void {
					that.currentState = state;
				}
			};
			plugin(machine);
		}
		
		
		public function get states():*
		{
			return _states;
		}
		
		public function set states(value:*):void
		{
			if (_states == null)
			{
				_states = value;
				pluginInitialState();
			}
		}
		
		
		public function get initialState():String
		{
			return _initialState;
		}
		
		public function set initialState(value:String):void
		{
			if (_initialState == null)
			{
				_initialState = value;
				pluginInitialState();
			}
		}
		
		
		public function get previousState():String
		{
			return _previousState;
		}
		
		
		public function get currentState():String
		{
			return _currentState;
		}
		
		public function set currentState(value:String):void
		{
			if (states)
			{
				var nextState:* = states[value];
				if (nextState)
				{
					unplug(states[_currentState]);
					
					_previousState = _currentState;
					_currentState = value;
					
					plugin(nextState);
					
					notifyPropertyChanged("currentState", _previousState, _currentState);
				}
			}
		}
		
		
		protected function pluginInitialState():void
		{
			if (states)
			{
				var state:* = states[_initialState];
				if (state)
				{
					plugin(state);
					_currentState = _initialState;
				}
			}
		}
	}
}
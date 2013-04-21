package com.poem.models 
{
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class PluggableDevice 
	{
		private var _name:String;
		private var _average:Number;
		private var _snapshot:Number;
		private var _target:Number;
		private var _unit:String;
		private var _state:String;
		private var _switchable:Boolean;
		
		public function get switchable() : Boolean
		{
			return _switchable;
		}
		
		public function set switchable(v:Boolean) : void
		{
			_switchable = v;
		}
		
		public function get state() : String
		{
			return _state;
		}
		
		public function set state(v:String) : void
		{
			_state = v;
		}
		
		public function get unit() : String
		{
			return _unit;
		}
		
		public function set unit(v:String) : void
		{
			_unit = v;
		}
		
		public function get snapshot() : Number
		{
			return _snapshot;
		}
		
		public function set snapshot(v:Number) : void
		{
			_snapshot = v;
		}
		
		public function get average() : Number
		{
			return _average;
		}
		
		public function set average(v:Number) : void
		{
			_average = v;
		}
		
		public function get name() : String
		{
			return _name;
		}
		
		public function set name(v:String) : void
		{
			_name = v;
		}
		
		public function get target():Number 
		{
			return _target;
		}
		
		public function set target(value:Number):void 
		{
			_target = value;
		}
	}

}
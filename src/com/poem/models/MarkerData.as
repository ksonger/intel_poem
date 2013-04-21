package com.poem.models 
{
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class MarkerData 
	{
		private var _energyValue:Number;
		private var _dateValue:Date;
		private var _scaledValue:Number;
		private var _tooltip:String;
		
		public function set scaledValue(v:Number) : void
		{
			_scaledValue = v;
		}
		
		public function get scaledValue() : Number
		{
			return _scaledValue;
		}
		
		public function set energyValue(v:Number) : void
		{
			_energyValue = v;
		}
		
		public function get energyValue() : Number
		{
			return _energyValue;
		}		
		
		public function set tooltip(v:String) : void
		{
			_tooltip = v;
		}
		
		public function get tooltip() : String
		{
			return _tooltip;
		}
		
		public function get dateValue():Date 
		{
			return _dateValue;
		}
		
		public function set dateValue(value:Date):void 
		{
			_dateValue = value;
		}
	}
}
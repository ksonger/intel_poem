package com.poem.models 
{
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class EnergyComparison 
	{
		private var _level:String;
		private var _name:String;
		private var _units:String;
		private var _weeklyEnergyConsumption:Array;
		
		public function get level() : String
		{
			return _level;
		}
		
		public function set level(v:String) : void
		{
			_level = v;
		}
		
		public function get name() : String
		{
			return _name;
		}
		
		public function set name(v:String) : void
		{
			_name = v;
		}
		
		public function get units() : String
		{
			return _units;
		}
		
		public function set units(v:String) : void
		{
			_units = v;
		}
		
		public function get weeklyEnergyConsumption() : Array
		{
			return _weeklyEnergyConsumption;
		}
		
		public function set weeklyEnergyConsumption(v:Array) : void
		{
			_weeklyEnergyConsumption = v;
		}
	}
}
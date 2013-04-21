package com.poem.models 
{
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class DailyEnergyConsumption 
	{
		private var _date:Date;
		private var _energy:Number;
		
		public function DailyEnergyConsumption():void{
			
		}
		
		public function get date() : Date
		{
			return _date;
		}
		
		public function set date(v:Date) : void
		{
			_date = v;
		}
		
		public function get energy() : Number
		{
			return _energy;
		}
		
		public function set energy(v:Number) : void
		{
			_energy = v;
		}
	}

}
package com.poem.models 
{
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class InstantaneousEnergyConsumption 
	{
		private var _snapshot:Number;
		private var _average:Number;
		private var _targetValue:Number;
		private var _targetValueEnabled:Number;
		private var _unit:String;
		private var _status:String;
		private var _snapshotTarget:String;
		private var _snapshotTrend:String;
		
		public function get targetValue() : Number
		{
			return _targetValue;
		}
		
		public function set targetValue(v:Number) : void
		{
			_targetValue = v;
		}

		public function get average() : Number
		{
			return _average;
		}
		
		public function set average(v:Number) : void
		{
			_average = v;
		}		
		
		public function get status() : String
		{
			return _status;
		}
		
		public function set status(v:String) : void
		{
			_status = v;
		}
		
		public function set snapshotTrend(v:String) : void
		{
			_snapshotTrend = v;
		}
		
		public function get snapshotTrend() : String
		{
			return _snapshotTrend;
		}
		
		public function set snapshotTarget(v:String) : void
		{
			_snapshotTarget = v;
		}
		
		public function get snapshotTarget() : String
		{
			return _snapshotTarget;
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
		
		public function get targetValueEnabled():Number 
		{
			return _targetValueEnabled;
		}
		
		public function set targetValueEnabled(value:Number):void 
		{
			_targetValueEnabled = value;
		}
	}
}
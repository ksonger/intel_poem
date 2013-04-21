package com.poem.models 
{
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class Alert 
	{
		private var _type:String;
		private var _msg:String;
		
		public function get type() : String
		{
			return _type;
		}
		
		public function set type(v:String) : void
		{
			_type = v;
		}
		
		public function get msg() : String
		{
			return _msg;
		}
		
		public function set msg(v:String) : void
		{
			_msg = v;
		}
	}

}
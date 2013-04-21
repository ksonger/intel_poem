package com.poem.models 
{
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class ApplicationState 
	{
		private var _currentScreen:String;
		private var _usageLoaded:Boolean;
		
		public function get currentScreen() : String
		{
			return _currentScreen;
		}
		
		public function set currentScreen(v:String) : void
		{
			_currentScreen = v;
		}
		
		public function get usageLoaded() : Boolean
		{
			return _usageLoaded;
		}
		
		public function set usageLoaded(v:Boolean) : void
		{
			_usageLoaded = v;
		}		
	}

}
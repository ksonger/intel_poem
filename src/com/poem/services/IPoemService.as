package com.poem.services 
{
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public interface IPoemService 
	{
		function loadData() : void;
		function sendComfortData(n:Number) : void;
		function sendTargetData() : void;
		function sendTargetAlertData() : void;
	}
	
}
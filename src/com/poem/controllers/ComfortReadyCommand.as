package com.poem.controllers 
{
	import com.poem.mediators.comfort.ComfortMediator;
	import org.robotlegs.mvcs.SignalCommand;
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class ComfortReadyCommand extends SignalCommand
	{	
		[Inject]
		public var med:ComfortMediator;	
		
		override public function execute():void 
		{
			med.init();
		}		
	}
}
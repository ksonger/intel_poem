package com.poem.controllers 
{
	import com.poem.mediators.comfort.ComfortMediator;
	import com.poem.models.ConfigurationData;
	import com.poem.models.PoemModel;
	import com.poem.services.PoemImageService;
	import com.poem.signals.ConfigurationDataLoadedSignal;
	import org.robotlegs.mvcs.SignalCommand;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class InitComfortIconsCommand extends SignalCommand
	{
		[Inject]
		public var med:ComfortMediator;
		
		
		override public function execute() : void
		{
		}
	}
}
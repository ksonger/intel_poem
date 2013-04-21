package com.poem.controllers 
{
	import com.poem.services.IConfigurationService;
	import org.robotlegs.mvcs.SignalCommand;
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class LoadConfigurationDataCommand extends SignalCommand
	{
		[Inject]
		public var service:IConfigurationService;
		
		override public function execute() : void
		{
			service.loadConfigurationData();
		}
	}

}
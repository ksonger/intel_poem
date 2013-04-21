package com.poem.controllers 
{
	import com.poem.models.ConfigurationData;
	import com.poem.models.PoemModel;
	import com.poem.services.IPoemService;
	import com.poem.services.RemoteService;
	import com.poem.signals.ConfigurationDataLoadedSignal;
	import org.robotlegs.mvcs.SignalCommand;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class PoemTargetUpdatedCommand extends SignalCommand
	{	
		
		[Inject]
		public var service:IPoemService;
		
		[Inject]
		public var model:PoemModel;
		
		override public function execute() : void
		{

			service.sendTargetData();
			model.targetUpdateSend = false;
		}
	}
}
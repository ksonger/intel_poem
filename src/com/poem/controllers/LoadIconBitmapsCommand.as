package com.poem.controllers 
{
	import com.poem.models.ConfigurationData;
	import com.poem.models.PoemModel;
	import com.poem.services.PoemImageService;
	import com.poem.signals.ConfigurationDataLoadedSignal;
	import org.robotlegs.mvcs.SignalCommand;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class LoadIconBitmapsCommand extends SignalCommand
	{
		[Inject]
		public var service:PoemImageService;
		
		override public function execute() : void
		{
			service.loadIconBitmaps();
		}
	}
}
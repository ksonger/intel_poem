package com.poem.controllers 
{
	import com.poem.models.PoemModel;
	import com.poem.signals.PoemTargetUpdatedSignal;
	import org.robotlegs.mvcs.SignalCommand;
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class ChangeScreenCommand extends SignalCommand
	{	
		[Inject]
		public var model:PoemModel;
		
		[Inject]
		public var targetUpdated:PoemTargetUpdatedSignal;
		
		override public function execute():void 
		{
			if (model.targetUpdateSend)	{
				targetUpdated.dispatch();
			}
		}		
	}
}
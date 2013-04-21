package com.poem.mediators.ambient 
{
	import com.poem.signals.SensorDataUpdatedSignal;	
	import com.poem.views.ambient.AmbientOutdoor;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class AmbientOutdoorMediator extends Mediator
	{
		[Inject]
		public var view:AmbientOutdoor;
		
		[Inject]
		public var dataUpdated:SensorDataUpdatedSignal;				
		
		override public function onRegister():void 
		{
			view.initialize();
			dataUpdated.add(dataUpdatedHandler);
		}
		
		override public function onRemove():void 
		{
			dataUpdated.remove(dataUpdatedHandler);
			view.dispose();
			view = null;
		}

		private function dataUpdatedHandler() : void
		{
			view.update();
		}			
		
	}
}
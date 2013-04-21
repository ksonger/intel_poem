package com.poem.mediators.alert 
{
	import com.poem.signals.SensorDataUpdatedSignal;
	import com.poem.views.alert.AlertView;
	import org.robotlegs.mvcs.Mediator;
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class AlertMediator extends Mediator
	{
		[Inject]
		public var view:AlertView;
		
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
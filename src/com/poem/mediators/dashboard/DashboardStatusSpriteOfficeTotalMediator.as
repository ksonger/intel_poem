package com.poem.mediators.dashboard 
{
	import com.poem.views.dashboard.DashboardStatusSpriteOfficeTotal;
	import com.poem.signals.SensorDataUpdatedSignal;
	import org.robotlegs.mvcs.Mediator;	
	
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class DashboardStatusSpriteOfficeTotalMediator extends Mediator
	{
		[Inject]
		public var view:DashboardStatusSpriteOfficeTotal;
		
		[Inject]
		public var dataUpdated:SensorDataUpdatedSignal;			
		
		override public function onRegister() : void 
		{		
			view.targetValue = view.model.sensorData.officeIntantaneousPowerValue.targetValue;
			dataUpdated.add(dataUpdatedHandler);
			view.initialize();
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
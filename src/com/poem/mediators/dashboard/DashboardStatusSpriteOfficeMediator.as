package com.poem.mediators.dashboard 
{
	import com.poem.signals.SensorDataUpdatedSignal;
	import com.poem.signals.ChangeScreenSignal;
	import com.poem.views.dashboard.DashboardStatusSpriteOffice;
	import com.poem.constants.Screens;
	import org.robotlegs.mvcs.Mediator;	
	
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class DashboardStatusSpriteOfficeMediator extends Mediator
	{
		[Inject]
		public var view:DashboardStatusSpriteOffice;

		[Inject]
		public var dataUpdated:SensorDataUpdatedSignal;	
		
		[Inject]
		public var changeScreen:ChangeScreenSignal;			
		
		override public function onRegister() : void 
		{		
			view.targetValue = view.model.sensorData.officeIntantaneousPowerValue.targetValue;
			dataUpdated.add(dataUpdatedHandler);	
			view.addEventListener(MouseEvent.CLICK, onClick);
			view.useHandCursor = true;
			view.buttonMode = true;
			view.mouseChildren = false;	
			view.initialize();
		}
		
		override public function onRemove():void 
		{
			dataUpdated.remove(dataUpdatedHandler);
			view.removeEventListener(MouseEvent.CLICK, onClick);
			view.dispose();
			view = null;
		}
		
		private function dataUpdatedHandler() : void
		{
			
			view.update();
		}	
		
		private function onClick(event:MouseEvent) : void
		{
			changeScreen.dispatch(Screens.OFFICE);
		}		

	}
}
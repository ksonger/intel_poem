package com.poem.mediators 
{
	import com.poem.helpers.notifications.PopupAlertManager;
	import com.poem.models.PoemModel;
	import com.poem.signals.LoadDataSignal;
	import com.poem.signals.ShowDashboardSignal;
	import com.poem.views.PoemApplicationView;
	
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class PoemApplicationMediator extends Mediator
	{
		[Inject]
		public var view:PoemApplicationView;
		
		[Inject]
		public var model:PoemModel;
		
		[Inject]
		public var showDashboard:ShowDashboardSignal;
		
		// This member will be used to dispatch a signal that will invoke the "LoadSensorDataCommand".
		[Inject]
		public var loadData:LoadDataSignal;		
		
		private var EnterDelayTimer:Timer;
		private var stage:Stage;
		
		override public function onRegister():void 
		{	
			view.initialize();
			loadData.add(loadDataComplete);	
		}

		override public function onRemove():void 
		{
			view.dispose();
			loadData.remove(loadDataComplete);
			view = null;
			model = null;
		}		
		
		private function loadDataComplete() : void
		{
			
			var status:String = model.sensorData.officeIntantaneousPowerValue.status;
			
			var path:String;
			switch (status){
				case "good":
					path = model.config.aboveTarget32;				
					break;
				case "bad":
					path = model.config.belowTarget32;					
					break;
				case "neutral":
					path = model.config.onTarget32;						
					break;
			}			
			
		}		
	}
}
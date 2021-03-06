package com.poem.mediators.dashboard 
{
	import com.poem.signals.SensorDataUpdatedSignal;
	import com.poem.signals.ChangeScreenSignal;
	import com.poem.views.dashboard.DashboardStatusSpritePC;
	import com.poem.constants.Screens;
	import org.robotlegs.mvcs.Mediator;	
	
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	 public class DashboardStatusSpritePCMediator extends Mediator
	 {
	 	[Inject]
	 	public var view:DashboardStatusSpritePC;
	 	
	 	[Inject]
	 	public var dataUpdated:SensorDataUpdatedSignal;	
	 	
	 	[Inject]
	 	public var changeScreen:ChangeScreenSignal;			
	 	
	 	override public function onRegister() : void 
	 	{		
	 		dataUpdated.add(dataUpdatedHandler);
	 		with(view)	{
	 			targetValue = view.model.sensorData.pcInstantaneousPowerValue.targetValue;				
	 			addEventListener(MouseEvent.CLICK, onClick,false,0,true);
	 			useHandCursor = true;
	 			buttonMode = true;
	 			mouseChildren = false;				
	 			initialize();
	 		}
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
	 		changeScreen.dispatch(Screens.PCUSAGE);
	 	}		

	 }
	}
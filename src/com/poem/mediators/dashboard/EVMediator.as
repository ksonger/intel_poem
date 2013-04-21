package com.poem.mediators.dashboard 
{
	import com.poem.constants.Screens;
	import com.poem.models.PoemModel;
	import com.poem.views.dashboard.EVView;
	import flash.events.Event;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class EVMediator extends Mediator
	{
		[Inject]
		public var view:EVView;
		
		[Inject]
		public var model:PoemModel;
		
		override public function onRegister():void 
		{
			view.initialize();
			view.addEventListener(Event.ENTER_FRAME, enterHandler,false,0,true);
		}	
		
		private function enterHandler(e:Event):void 
		{
			try 
			{
				view.visible = (model.appState.currentScreen == Screens.EVUSAGE);
			} 
			catch (err:Error) 
			{
				
			}
		}
		
		override public function onRemove():void 
		{
			view.dispose();
			view = null;
		}
	}
}
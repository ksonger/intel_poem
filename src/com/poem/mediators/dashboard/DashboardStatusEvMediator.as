package com.poem.mediators.dashboard 
{
	import com.poem.models.PoemModel;
	import com.poem.views.dashboard.DashboardStatusEv;
	import org.robotlegs.mvcs.Mediator;	
	
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class DashboardStatusEvMediator extends Mediator
	{
		[Inject]
		public var view:DashboardStatusEv;
		
		override public function onRegister() : void 
		{	
			view.initialize();
		}
		
		override public function onRemove():void 
		{
			view.dispose();
			view = null;
		}
	}
}
package com.poem.mediators.dashboard 
{
	import com.poem.views.dashboard.DashboardStatusOffice;
	import org.robotlegs.mvcs.Mediator;	
	
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class DashboardStatusOfficeMediator extends Mediator
	{
		[Inject]
		public var view:DashboardStatusOffice;

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
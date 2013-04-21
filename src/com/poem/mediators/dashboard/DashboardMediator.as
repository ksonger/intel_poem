package com.poem.mediators.dashboard 
{
	import com.poem.views.dashboard.DashboardView;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class DashboardMediator extends Mediator
	{
		[Inject]
		public var view:DashboardView;
		
		override public function onRegister():void 
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
package com.poem.mediators.usage 
{
	import com.poem.views.usage.UsageDetailsView;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class UsageDetailsMediator extends Mediator
	{
		[Inject]
		public var view:UsageDetailsView;
		
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
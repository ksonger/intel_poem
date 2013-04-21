package com.poem.mediators.usage 
{
	import com.poem.views.usage.HeaderView;
	import org.robotlegs.mvcs.Mediator;
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class HeaderViewMediator extends Mediator
	{
		[Inject]
		public var view:HeaderView;
		
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
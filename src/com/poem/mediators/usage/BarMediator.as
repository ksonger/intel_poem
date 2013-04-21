package com.poem.mediators.usage 
{
	import com.poem.views.usage.Bar;
	import org.robotlegs.mvcs.Mediator;
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class BarMediator extends Mediator
	{
		[Inject]
		public var view:Bar;	
		
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
package com.poem.mediators.usage 
{
	import com.poem.helpers.MarkerToolTipHelper;
	import org.robotlegs.mvcs.Mediator;
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class MarkerToolTipHelperMediator extends Mediator
	{
		[Inject]
		public var view:MarkerToolTipHelper;	
		
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
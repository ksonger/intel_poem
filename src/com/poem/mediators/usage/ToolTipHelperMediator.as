package com.poem.mediators.usage 
{
	import com.poem.helpers.ToolTipHelper;
	import org.robotlegs.mvcs.Mediator;
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class ToolTipHelperMediator extends Mediator
	{
		[Inject]
		public var view:ToolTipHelper;	
		
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
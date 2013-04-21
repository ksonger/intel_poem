package com.poem.mediators.usage 
{
	import com.poem.views.usage.Pluggables;
	import org.robotlegs.mvcs.Mediator;
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class PluggablesMediator extends Mediator
	{
		[Inject]
		public var view:Pluggables;	
		
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
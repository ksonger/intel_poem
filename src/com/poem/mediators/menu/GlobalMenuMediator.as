package com.poem.mediators.menu 
{
	import com.poem.views.menu.GlobalMenu;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class GlobalMenuMediator extends Mediator
	{
		[Inject]
		public var view:GlobalMenu;;
		
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
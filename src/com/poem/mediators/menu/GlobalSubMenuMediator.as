package com.poem.mediators.menu 
{
	import com.poem.views.menu.GlobalSubMenu;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class GlobalSubMenuMediator extends Mediator
	{
		[Inject]
		public var view:GlobalSubMenu;
		
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
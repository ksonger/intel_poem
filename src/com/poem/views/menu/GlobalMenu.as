package com.poem.views.menu 
{
	import com.poem.interfaces.IDisposable;
	import com.poem.interfaces.IInitializable;
	import com.poem.constants.Screens;
	import com.poem.models.PoemModel;
	import com.poem.signals.ChangeScreenSignal;
	
	import flash.display.Sprite;
	
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class GlobalMenu extends Sprite implements IDisposable, IInitializable
	{
		public var dashboard:GlobalMenuItemDashboard;
		public var office:GlobalMenuItemOffice;
		public var ev:GlobalMenuItemEv;
		
		[Inject]
		public var changeScreen:ChangeScreenSignal;
		
		[Inject]
		public var model:PoemModel;
		
		public function initialize() : void
		{
			createMenus();
			addToStage();
		}
		
		public function dispose() : void
		{
			while (numChildren > 0)
				removeChildAt(0);
		}

		private function addToStage() : void
		{
			addChild(dashboard);
			addChild(office);
			addChild(ev);
		}	
		
		private function createMenus() : void
		{
			dashboard = new GlobalMenuItemDashboard();
			dashboard.x = 0;
			dashboard.y = 0;

			office = new GlobalMenuItemOffice();
			office.x = 93;
			office.y = 0;	
			
			ev = new GlobalMenuItemEv();
			ev.x = 186;
			ev.y = 0;				
		}
	}
}
package com.poem.views.menu 
{
	import com.poem.constants.Screens;
	import com.poem.interfaces.IDisposable;
	import com.poem.interfaces.IInitializable;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import com.greensock.*;
	import com.greensock.easing.*;	
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class GlobalMenuItemOffice extends GlobalMenuItem implements IDisposable, IInitializable
	{	
		
		private var subMenu:GlobalSubMenu;
		
		public override function setValues() : void
		{
			screenName = Screens.OFFICE;
			icon_path = model.config.menuOfficeIconURL;
			mask_height = 182;
			mask_y = -100;
		}
		
		public override function createSubMenu() : void
		{
			subMenu = new GlobalSubMenu();
			subMenu.x = 0;
			subMenu.y = 85;
			
			container.addChildAt(subMenu, 0);
		}
		
		public override function showSubMenu() : void
		{
			TweenMax.to(subMenu, 1, {y:-110, ease:Expo.easeOut});
		}
		
		public override function hideSubMenu() : void
		{
			TweenMax.to(subMenu, 1, {y:85});
		}		
		
	}
}
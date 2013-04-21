package com.poem.views.menu 
{
	import com.poem.interfaces.IDisposable;
	import com.poem.interfaces.IInitializable;
	import com.poem.constants.Screens;	
	import flash.display.Loader;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class GlobalMenuItemDashboard extends GlobalMenuItem implements IDisposable, IInitializable
	{	

		public override function setValues() : void
		{
			screenName = Screens.DASHBOARD;
			icon_path = model.config.menuDashboardIconURL;
			mask_height = 82;
			mask_y = 0;
		}
		
		public override function setDashboard() : void
		{
			SET_LAST_CLICKED = this;
		}		
		
		
	}
}
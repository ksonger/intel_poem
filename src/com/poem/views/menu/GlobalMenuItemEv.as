package com.poem.views.menu 
{
	import com.poem.constants.Screens;
	import com.poem.interfaces.IDisposable;
	import com.poem.interfaces.IInitializable;
	import flash.display.Loader;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class GlobalMenuItemEv extends GlobalMenuItem implements IDisposable, IInitializable
	{	

		public override function setValues() : void
		{
			screenName = Screens.EVUSAGE;
			icon_path = model.config.menuEvIconURL;
			mask_height = 82;
			mask_y = 0;
		}		
		
	}
}
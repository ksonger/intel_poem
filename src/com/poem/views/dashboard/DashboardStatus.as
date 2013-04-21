package com.poem.views.dashboard 
{
	import com.poem.interfaces.IDisposable;
	import com.poem.constants.Screens;
	import com.poem.models.PoemModel;
	import com.poem.signals.LoadStatusBitmapsSignal;
	import com.poem.constants.EnergyCategory;
	import com.poem.interfaces.IInitializable;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class DashboardStatus extends Sprite implements IDisposable, IInitializable
	{
		[Inject]
		public var model:PoemModel;
				
		public function initialize() : void
		{
		}
		
		public function dispose() : void
		{
			while (numChildren > 0)
				removeChildAt(0);
				
			model = null;
		}
		
	
	}
}
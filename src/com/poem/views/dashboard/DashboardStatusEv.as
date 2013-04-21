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
	import flash.display.Loader;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class DashboardStatusEv extends DashboardStatus implements IDisposable, IInitializable
	{
		
		public var status:DashboardStatusSpriteEv;
		public var matte:Loader;
		
		public override function initialize() : void
		{
			createMatte();
			createEvStatus();
			addToStage();
		}
		
		public function addToStage() : void
		{
			addChild(matte);	
			addChild(status);	
		}		
	
		public function createMatte() : void
		{
			matte = new Loader();
			matte.load(new URLRequest(model.config.dashboardStatusMatteURL));	
		}			
		
		private function createEvStatus() : void
		{
			status = new DashboardStatusSpriteEv('ev');
			status.x = 13;
			status.y = 13;
		}	

	}
}
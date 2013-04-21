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
	public class DashboardStatusOffice extends DashboardStatus implements IDisposable, IInitializable
	{
		
		public var status:DashboardStatusSpriteOffice;
		public var status_pc:DashboardStatusSpritePC;
		public var status_printer:DashboardStatusSpritePrinter;
		public var status_plug:DashboardStatusSpritePluggable;
		public var matte:Loader;
		
		public override function initialize() : void
		{
			createMatte();
			createStatus();
			addToStage();
		}
		
		public function addToStage() : void
		{
			addChild(matte);	
			addChild(status);	
			addChild(status_pc);
			addChild(status_printer);
			addChild(status_plug);
		}		
	
		public function createMatte() : void
		{
			matte = new Loader();
			matte.load(new URLRequest(model.config.dashboardStatusMatteWideURL));	
		}			
		
		private function createStatus() : void
		{
			status = new DashboardStatusSpriteOffice('office');
			status.x = 13;
			status.y = 13;
			
			status_pc = new DashboardStatusSpritePC();
			status_pc.x = 193;
			status_pc.y = 13;
			
			status_printer = new DashboardStatusSpritePrinter();
			status_printer.x = 193;
			status_printer.y = 91;	
			
			status_plug = new DashboardStatusSpritePluggable();
			status_plug.x = 193;
			status_plug.y = 170;				
		}	

	}
}
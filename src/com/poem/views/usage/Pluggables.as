package com.poem.views.usage 
{
	import com.greensock.TweenMax;
	import com.poem.constants.EnergyCategory;
	import com.poem.interfaces.IDisposable;
	import com.poem.interfaces.IInitializable;
	import com.poem.models.EnergyComparison;
	import com.poem.models.PoemModel;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.net.URLRequest;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class Pluggables extends Sprite implements IDisposable, IInitializable
	{
		private var chartHeight:Number;
		private var category:String;
		
		[Inject]
		public var model:PoemModel;

		public function initialize() : void
		{	
			createBackground();
			createPluggables();
		}
		
		public function dispose() : void
		{
			while (numChildren > 0)
				removeChildAt(0);
				
			model = null;
		}
		private function createBackground() : void
		{
			var background:Loader = new Loader();
			background.load(new URLRequest(model.config.usagePluggableBackgroundImageURL));
			addChild(background);
			TweenMax.to(background, .5, { alpha:1} );
		}
		
		private function createPluggables() : void
		{	
			var monitor_url:String = model.config.usagePluggableMonitorImageURL;
			var monitor:PluggableItem = new PluggableItem(monitor_url, 0);
			monitor.x = 3;
			monitor.y = 0;
			
			var lights_url:String = model.config.usagePluggableLightsImageURL;
			var lights:PluggableItem = new PluggableItem(lights_url, 1);
			lights.x = 73;
			lights.y = 0;
			
			var fan_url:String = model.config.usagePluggableFanImageURL;
			var fan:PluggableItem = new PluggableItem(fan_url, 2);
			fan.x = 3;
			fan.y = 100;	
			
			var heater_url:String = model.config.usagePluggableHeaterImageURL;
			var heater:PluggableItem = new PluggableItem(heater_url, 3);
			heater.x = 73;
			heater.y = 100;	
			
			var computer_url:String = model.config.usagePluggableComputerImageURL;
			var computer:PluggableItem = new PluggableItem(computer_url, 4);
			computer.x = 3;
			computer.y = 195;	
			
			var battery_url:String = model.config.usagePluggableBatteryImageURL;
			var battery:PluggableItem = new PluggableItem(battery_url, 5);
			battery.x = 73;
			battery.y = 195;				
			
			addChild(lights);
			addChild(monitor);
			addChild(heater);
			addChild(fan);
			addChild(battery);
			addChild(computer);
						
		}
	}
}
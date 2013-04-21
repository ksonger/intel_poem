package com.poem.views.dashboard 
{
	import com.greensock.TweenMax;
	import com.poem.constants.TextStyles;
	import com.poem.interfaces.IDisposable;
	import com.poem.interfaces.IInitializable;
	import com.poem.interfaces.IUpdateable;
	import com.poem.helpers.TextFieldHelper;
	import com.poem.models.PoemModel;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class DashboardStatusSpriteEv extends DashboardStatusSpriteLarge implements IDisposable, IInitializable, IUpdateable
	{	
		
		public function DashboardStatusSpriteEv(typ:String = null):void	{
			this.typ = typ;
		}

		public override function setValues() : void
		{
			header_label = model.labelManager.getLabel("c13");
			snapshot_label = model.labelManager.getLabel("c12");
			average_label = model.labelManager.getLabel("c11");
			
			snapshotTrend = model.sensorData.evInstantaneousPowerValue.snapshotTrend;
			snapshotTarget = model.sensorData.evInstantaneousPowerValue.snapshotTarget;
			status = model.sensorData.evInstantaneousPowerValue.status;
			
			snapshot = model.sensorData.evInstantaneousPowerValue.snapshot;
			average = model.sensorData.evInstantaneousPowerValue.average;
			unit = model.sensorData.evInstantaneousPowerValue.unit;
		}
		
		public override function createBackground() : void
		{
			background.load(new URLRequest(model.config.dashboardStatusBackgroundURL));			
			
			chart.x = 140;
			chart.y = 195;
			
			trend.x = 135;
			trend.y = 185;			

		}	

	}
}
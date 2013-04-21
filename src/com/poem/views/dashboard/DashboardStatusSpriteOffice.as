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
	public class DashboardStatusSpriteOffice extends DashboardStatusSpriteLarge implements IDisposable, IInitializable, IUpdateable
	{	

		public function DashboardStatusSpriteOffice(typ:String = null):void	{
			this.typ = typ;
		}
		public override function setValues() : void
		{
			header_label = model.labelManager.getLabel("c6");
			snapshot_label = model.labelManager.getLabel("c43");
			average_label = model.labelManager.getLabel("c11");
			target_label = model.labelManager.getLabel("c10");
		
			snapshotTrend = model.sensorData.officeIntantaneousPowerValue.snapshotTrend;
			snapshotTarget = model.sensorData.officeIntantaneousPowerValue.snapshotTarget;
			status = model.sensorData.officeIntantaneousPowerValue.status;
			
			
			snapshot = model.sensorData.officeIntantaneousPowerValue.snapshot;
			average = model.sensorData.officeIntantaneousPowerValue.average;	
			unit = model.sensorData.officeIntantaneousPowerValue.unit;	
			targetValue = model.sensorData.officeIntantaneousPowerValue.targetValue;
			
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
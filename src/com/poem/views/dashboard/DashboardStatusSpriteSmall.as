package com.poem.views.dashboard 
{
	
	import com.poem.constants.TextStyles;
	import com.poem.interfaces.IDisposable;
	import com.poem.interfaces.IInitializable;
	import com.poem.interfaces.IUpdateable;
	import com.poem.helpers.TextFieldHelper;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class DashboardStatusSpriteSmall extends DashboardStatusSprite implements IDisposable, IInitializable, IUpdateable
	{

		public override function createTrend() : void
		{	
			configureAssetListeners(trend.contentLoaderInfo);
			switch ( snapshotTrend ){
				case "up":
					trend.load(new URLRequest(model.config.dashboardStatusTrendUpSmallURL));
					break;
				case "down":
					trend.load(new URLRequest(model.config.dashboardStatusTrendDownSmallURL));
					break;			
			}		
			
		}			
		
		public override function createStatus() : void
		{	
			configureAssetListeners(statusloader.contentLoaderInfo);
			switch ( status ){
				case "bad":
					statusloader.load(new URLRequest(model.config.dashboardStatusFlowerPoorURL));
					break;
				case "neutral":
					statusloader.load(new URLRequest(model.config.dashboardStatusFlowerFairURL));
					break;
				case "good":
					statusloader.load(new URLRequest(model.config.dashboardStatusFlowerGoodURL));
					break;				
			}		
			
		}
		
		public override function createChart() : void
		{	
			configureAssetListeners(chart.contentLoaderInfo);
			switch (snapshotTrend){
				case "down":
					chart.load(new URLRequest(model.config.dashboardStatusChartPoorSmallURL));
					break;
				case "normal":
					chart.load(new URLRequest(model.config.dashboardStatusChartFairSmallURL));
					break;
				case "up":
					chart.load(new URLRequest(model.config.dashboardStatusChartGoodSmallURL));
					break;				
			}			
		}
		
		public override function createText() : void
		{
			
			header_label = header_label.toUpperCase();
			header_txt = TextFieldHelper.createTextField(68, 8, 110, header_label, "HEADER", TextStyles.DASH_STATUS_HEADER_SMALL, TextFieldAutoSize.LEFT, false, true);
			
			var y_inc:Number = header_txt.textHeight;

			average_label = average_label.toUpperCase() + ": " + average + unit;
			average_txt = TextFieldHelper.createTextField(68, y_inc + 10, 150, average_label, "AVERAGE", TextStyles.DASH_STATUS_SUBHEADER_SMALL, TextFieldAutoSize.LEFT);
			
			target_label = model.labelManager.getLabel("c10");
			target_label = target_label.toUpperCase() + ": " + targetValue + unit;
			
			//target_txt = TextFieldHelper.createTextField(68, y_inc+22, 150, target_label, "TARGET", TextStyles.DASH_STATUS_SUBHEADER_SMALL, TextFieldAutoSize.LEFT);		
			
			//snapshot_label = snapshot_label.toUpperCase() + ": " + snapshot + unit;
			//snapshot_txt = TextFieldHelper.createTextField(68, y_inc + 22, 150, snapshot_label, "SNAPSHOT", TextStyles.DASH_STATUS_SUBHEADER_SMALL, TextFieldAutoSize.LEFT);
			
		}
		
		public override function createBackground() : void
		{
			background.load(new URLRequest(model.config.dashboardStatusBackgroundSmallURL));
			
			statusloader.scaleX = .4;
			statusloader.scaleY = .4;
			statusloader.x = -4;
			statusloader.y = -14;
			
			chart.x = 42;
			chart.y = 56;
			
			trend.x = 38;
			trend.y = 56;			
			
		}			
		/**********************************/
		/***** LOADER LISTENERS ***********/
		/**********************************/
		public function configureAssetListeners(dispatcher:IEventDispatcher):void {
			dispatcher.addEventListener(Event.COMPLETE, graphicCompleteHandler,false,0,true);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, graphicIoErrorHandler,false,0,true);

		}
		public function graphicCompleteHandler(e:Event):void {
			var bm:Bitmap = e.target.content as Bitmap;
			bm.smoothing = true;
		}
		public function graphicIoErrorHandler(event:IOErrorEvent):void {
			var msg:String='Dashboard small image not loaded: '+event.text;
			trace(msg);
		}

	}
}
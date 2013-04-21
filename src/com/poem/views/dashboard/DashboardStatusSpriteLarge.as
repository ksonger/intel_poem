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
	public class DashboardStatusSpriteLarge extends DashboardStatusSprite implements IDisposable, IInitializable, IUpdateable
	{

		public override function createTrend() : void
		{	
			configureAssetListeners(trend.contentLoaderInfo);
			switch ( snapshotTrend ){
				case "up":
					trend.load(new URLRequest(model.config.dashboardStatusTrendUpURL));
					break;
				case "down":
					trend.load(new URLRequest(model.config.dashboardStatusTrendDownURL));
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
				case "normal":
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
			
			
			
			switch ( snapshotTrend ){
				case "down":
					chart.load(new URLRequest(model.config.dashboardStatusChartPoorURL));
					break;
				case "normal":
					chart.load(new URLRequest(model.config.dashboardStatusChartFairURL));
					break;
				case "up":
					chart.load(new URLRequest(model.config.dashboardStatusChartGoodURL));
					break;				
			}			
		}		
		
		public override function createText() : void
		{
			header_label = header_label.toUpperCase();
			header_txt = TextFieldHelper.createTextField(8, 6, 160, header_label, "HEADER", TextStyles.DASH_STATUS_HEADER, TextFieldAutoSize.LEFT, false, true);
			
			var y_inc:Number = header_txt.y + header_txt.textHeight + 5;

			if (this.typ == 'office') 
			{
				average_label = average_label.toUpperCase() + ": " + average + unit;
				average_txt = TextFieldHelper.createTextField(8, y_inc, 150, average_label, "AVERAGE", TextStyles.DASH_STATUS_SUBHEADER, TextFieldAutoSize.LEFT);			
				snapshot_label = snapshot_label.toUpperCase() + ": " + snapshot + unit;
				snapshot_txt = TextFieldHelper.createTextField(8, y_inc, 150, snapshot_label, "TARGET", TextStyles.DASH_STATUS_SUBHEADER, TextFieldAutoSize.LEFT);
				snapshot_txt.height = 0;
				snapshot_txt.visible = false;
				if (target_label != null){
					target_label = target_label.toUpperCase() + ": " + targetValue + unit;
					target_txt = TextFieldHelper.createTextField(8, y_inc+15, 150, target_label, "TARGET", TextStyles.DASH_STATUS_SUBHEADER, TextFieldAutoSize.LEFT);		
				}
			}
			if (this.typ == 'ev' || this.typ == null) 
			{
				average_label = average_label.toUpperCase() + ": " + average + unit;
				average_txt = TextFieldHelper.createTextField(8, y_inc+15, 150, average_label, "AVERAGE", TextStyles.DASH_STATUS_SUBHEADER, TextFieldAutoSize.LEFT);			
				snapshot_label = snapshot_label.toUpperCase() + ": " + snapshot + unit;
				snapshot_txt = TextFieldHelper.createTextField(8, y_inc, 150, snapshot_label, "TARGET", TextStyles.DASH_STATUS_SUBHEADER, TextFieldAutoSize.LEFT);
				if (target_label != null){
					target_label = target_label.toUpperCase() + ": " + targetValue + unit;
					target_txt = TextFieldHelper.createTextField(8, y_inc + 23, 150, target_label, "TARGET", TextStyles.DASH_STATUS_SUBHEADER, TextFieldAutoSize.LEFT);
					target_txt.height = 0;
					target_txt.visible = false;
				}
			}
			target_txt.visible = !model.sensorData.notificationsDisabled;
		}		
		public function showHideTarget():void {

			target_txt.visible = !target_txt.visible;
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
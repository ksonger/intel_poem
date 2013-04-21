package com.poem.services 
{
	import air.net.URLMonitor;
	import com.poem.helpers.notifications.PopupAlertManager;
	import com.poem.models.PoemModel;
	import com.poem.models.PoemData;
	import com.poem.models.PoemDataParser;
	import com.poem.signals.PoemTargetUpdatedSignal;
	import flash.desktop.NativeApplication;
	import flash.events.IOErrorEvent;
	import flash.events.StatusEvent;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLLoader;
	import flash.events.Event;
	import flash.net.URLVariables;
	import mx.rpc.events.ResultEvent;
	import com.adobe.serialization.json.JSON;
	import flash.utils.*;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class LocalService implements IPoemService
	{
		[Inject]
		public var model:PoemModel;	
		
		[Inject]
		public var targetUpdated:PoemTargetUpdatedSignal;
		

		public var pam:PopupAlertManager;
		
		private var urlLoader:URLLoader;
		
		private var monitor:URLMonitor
		private var monitorStatus:Boolean = true;
		private var dbconnect:Boolean;
		
		private var attempts:Number = 0;
		private var aInt:Number;
		private var hasSucceeded:Boolean = false;
		
		public function loadData() : void
		{
			var request:URLRequest = new URLRequest("assets/json/static_data.json");
            request.method = URLRequestMethod.POST;	
			var args:Object = new Object();
			args.userID = model.config.userID;
			args.userPassword = model.config.password;
			args.hostname = model.config.hostname;
			args.queryExtraInformation = "true";
			request.data = unescape(JSON.encode(args));
			
			urlLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			urlLoader.addEventListener(Event.COMPLETE, handleData,false,0,true);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, handleError,false,0,true);
			monitor = new URLMonitor(request);
			monitor.addEventListener(StatusEvent.STATUS, onChangeStatus,false,0,true);
			monitor.start();
			if (monitorStatus) 
			{
				urlLoader.load(request);
			}
		}
		public function reloadData() : void
		{
			var request:URLRequest = new URLRequest(model.config.sensorDB);
            request.method = URLRequestMethod.POST;	
			var args:Object = new Object();
			args.userID = model.config.userID;
			args.userPassword = model.config.password;
			args.hostname = model.config.hostname;
			args.queryExtraInformation = "true";
			request.data = unescape(JSON.encode(args));
			urlLoader.load(request);
		}
		private function onChangeStatus(e:StatusEvent):void 
		{
			if (monitor.available != monitorStatus)	{
				if (!monitor.available && dbconnect)	{
					showMonitorAlert(model.labelManager.getLabel('c80'),model.config.offline32);
				}
				if (monitor.available)	{
					dbconnect = true;
					model.dbconnected = true;
					showMonitorAlert(model.labelManager.getLabel('c81'), model.config.online32);
					model.targetUpdateSend = true;
					targetUpdated.dispatch();
				}
				monitorStatus = monitor.available;
				model.connected = monitorStatus;
			}
		}
		private function showMonitorAlert(msg:String, pth:String):void 
		{
			if (pam == null) 
			{
				pam = new PopupAlertManager();
			}
			pam.displayMessage(msg, pth);
		}
		
		public function handleData(event:Event) : void 
		{
			hasSucceeded = true;
			dbconnect = true;
			var rawJson:String = event.target.data;
			var data:Object = JSON.decode(rawJson);
			// Setting the rawData will trigger the SensorDataUpdatedSignal
			//trace('DATA IS: ' + event.target.data);
			model.sensorData = PoemDataParser.parse(data);
			urlLoader.removeEventListener(Event.COMPLETE, handleData);
			urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, handleError);
			urlLoader = null;
		}
		public function handleError(event:IOErrorEvent):void {
			
			attempts++;
			if (attempts < Number(model.config.sensorAttempts))	{
				aInt = setTimeout(reloadData, Number(model.config.sensorInterval)*1000);
			}	else 
			{
				if (!hasSucceeded) 
				{
					var msg:String='Data not loaded: '+event.text;
					showMonitorAlert(model.labelManager.getLabel('c79'), model.config.dbError32);
					setTimeout(exitApp, 10000);
				}
			}
			
			
		}
		private function exitApp():void 
		{
			try 
			{
				NativeApplication.nativeApplication.exit();
			} 
			catch (err:Error) 
			{
				
			}
		}
		
		private function jsonLoaded(event:Event) : void
		{
			var rawJson:String = event.target.data;
			var data:Object = JSON.decode(rawJson);
			
			// Setting the rawData will trigger the SensorDataUpdatedSignal
			model.sensorData = PoemDataParser.parse(data);
		}
		public function sendComfortData(lvl:Number):void {
			var request:URLRequest = new URLRequest(model.config.sensorDBFeedback);
            request.method = URLRequestMethod.POST;	
			var args:Object = new Object();
			args.userID = model.config.userID;
			
			args.userPassword = model.config.password;
			args.feedbackCategory = "temperatureComfort";
			args.feedbackValue = String(lvl);
			request.data = unescape(JSON.encode(args));
			urlLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			urlLoader.addEventListener(Event.COMPLETE, handleComfortData,false,0,true);
			if (monitor.available) 
			{
				urlLoader.load(request);
			}
		}
		public function sendTargetData():void {
			trace("RemoteService - sending target data...");
			var request:URLRequest = new URLRequest(model.config.sensorDBFeedback);
            request.method = URLRequestMethod.POST;	
			var args:Object = new Object();
			args.userID = model.config.userID;
			args.userPassword = model.config.password;
			args.feedbackCategory = "setTargetValue";
			args.pcTargetValue = model.sensorData.pcInstantaneousPowerValue.targetValue;
			args.printerTargetValue = model.sensorData.printerInstantaneousPowerValue.targetValue;
			args.pluggableTargetValue = model.sensorData.plugableInstantaneousPowerValue.targetValue;
			args.evTargetValue = model.sensorData.evInstantaneousPowerValue.targetValue;
			args.officeTargetValue = model.sensorData.officeIntantaneousPowerValue.targetValue;

			if (model.sensorData.pcTargetsVisible)	{
				args.pcTargetValueEnabled = '1';
			}	else 
			{
				args.pcTargetValueEnabled = '0';
			}
			
			if (model.sensorData.printerTargetsVisible)	{
				args.printerTargetValueEnabled = '1';
			}	else 
			{
				args.printerTargetValueEnabled = '0';
			}
			
			if (model.sensorData.pluggableTargetsVisible)	{
				args.pluggableTargetValueEnabled = '1';
			}	else 
			{
				args.pluggableTargetValueEnabled = '0';
			}
			
			if (model.sensorData.officeTargetsVisible)	{
				args.officeTargetValueEnabled = '1';
			}	else 
			{
				args.officeTargetValueEnabled = '0';
			}
			
			if (model.sensorData.evTargetsVisible)	{
				args.evTargetValueEnabled = '1';
			}	else 
			{
				args.evTargetValueEnabled = '0';
			}

			request.data = unescape(JSON.encode(args));
			urlLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			urlLoader.addEventListener(Event.COMPLETE, handleTargetData,false,0,true);
			if (monitor.available) 
			{
				urlLoader.load(request);
			}
		}
		public function sendTargetAlertData():void {
			var request:URLRequest = new URLRequest(model.config.sensorDBFeedback);
            request.method = URLRequestMethod.POST;	
			var args:Object = new Object();
			args.userID = model.config.userID;
			args.userPassword = model.config.password;
			args.feedbackCategory = "alertMessageEnabled";
			if (!model.sensorData.notificationsDisabled)	{
				args.disabled = '0';
			}	else 
			{
				args.disabled = '1';
			}
			request.data = unescape(JSON.encode(args));
			urlLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			urlLoader.addEventListener(Event.COMPLETE, handleTargetAlertsData,false,0,true);
			if (monitor.available) 
			{
				urlLoader.load(request);
			}
		}
		private function handleTargetAlertsData(e:Event):void 
		{
			trace('Target alerts response: ' + e);
		}
		
		private function handleComfortData(e:Event):void 
		{
			trace('Comfort response: ' + e.target.data);
		}
		private function handleTargetData(e:Event):void 
		{
			trace('Target response: ' + e);
		}
	}
}
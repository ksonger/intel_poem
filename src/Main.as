package  
{
	import com.adobe.serialization.json.JSON;
	import com.hexagonstar.util.debug.Debug;
	import com.poem.PoemContext;
	import com.poem.helpers.notifications.PopupAlertManager;
	import com.poem.models.*;
	import com.poem.services.RemoteService;
	import com.poem.signals.*;
	import com.poem.views.PoemApplicationView;
	import flash.display.MovieClip;
	import flash.net.LocalConnection;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	import flash.desktop.DockIcon;
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemTrayIcon;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowResize;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.NativeWindowType;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.system.System;
	import flash.utils.*;	
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class Main extends Sprite
	{
		
		// This variable helps determine if the main application window is created.
		private var isApplicationLoaded:Boolean = false;
		
		private var context:PoemContext;
		private var poemApplicationView:PoemApplicationView;
		private var IntervalTimer:Timer;
		
		// This member will be used as an event listener that is called when the configuration data is finished loading
		[Inject]
		public var configLoaded:ConfigurationDataLoadedSignal;
		
		// This member will be used as an event listener that is called when data from the sensorDB is upated
		[Inject]
		public var dataUpdated:SensorDataUpdatedSignal;
		
		[Inject]
		public var bitmapsLoaded:PoemIconBitmapsLoadedSignal;
		
		// This member will be used to dispatch a signal that will invoke the "LoadSensorDataCommand".
		[Inject]
		public var loadData:LoadDataSignal;
		
		// This member will be used to dispatch a signal that will invoke the "LoadNotificationAreaCommand".
		[Inject]
		public var loadIconBitmaps:LoadIconBitmapsSignal;
		
		[Inject]
		public var model:PoemModel;
		
		[Inject]
		public var targetUpdated:PoemTargetUpdatedSignal;
		
		public var tv:NativeWindow;
		public var pam:PopupAlertManager;
		
		public var checkMemoryIntervalID:uint = setInterval(checkMemoryUsage, 1000);
		public var showWarning:Boolean = true;
		public var gcMemory:uint = 25000000;
		
		public function Main() 
		{
			
			Debug.monitor(stage);
			
			// Setting this flag will keep our application running in the notification area even when our main application window is closed.
			NativeApplication.nativeApplication.autoExit = false;
			
			// Instantiate the context, and pass a reference to this.
			context = new PoemContext(this);
			
			// create an event listener for when the configuration data finishes loading
			configLoaded.add(configLoadedHandler);
			
			// create an event listener for when the data is updated
			dataUpdated.add(dataUpdatedHandler);
			
			// create an event listener for when the icon bitmaps are loaded
			bitmapsLoaded.add(bitmapsLoadedHandler);
		}
		
		public function configLoadedHandler() : void
		{
			
			//removeListener
			configLoaded.remove(configLoadedHandler);
			
			// Send the loadData signal, this will trigger the "LoadSensorDataCommand"
			loadData.dispatch();
		}
		
		public function dataUpdatedHandler() : void
		{
			
			//removeListener
			dataUpdated.remove(dataUpdatedHandler);
			
			// Send the loadNotificationArea signal, this will trigger the "LoadNotificationAreaCommand"
			loadIconBitmaps.dispatch();
		}
		
		//RUNTIME... NOT CALLED ON INIT		
		private function loadDataSignalHandler() : void
		{
			loadIconBitmaps.dispatch();
			
		}	
		
		private function createNotificationWindow() : void
		{
			var status:String = model.sensorData.officeIntantaneousPowerValue.status;
			
			var path:String;
			switch (status){
				case "good":
					path = model.config.aboveTarget32;				
					break;
				case "bad":
					path = model.config.belowTarget32;					
					break;
				case "neutral":
					path = model.config.onTarget32;						
					break;
			}			
			
			if (pam == null) 
			{
				pam = new PopupAlertManager();	
			}	
			if (!model.sensorData.notificationsDisabled) 
			{
				pam.displayMessage(model.sensorData.alertMessage, path);
			}			
		}
		
		private function bitmapsLoadedHandler(bitmaps:Array) : void
		{
			//removeListener
			bitmapsLoaded.remove(bitmapsLoadedHandler);
			
			//listen for the Key Press/data refresh (?)
			loadData.add(loadDataSignalHandler);
			
			startIntervalTimer();
			//showMenuClick();
			
			//Add a tooltip and menu to the system tray icon
			var iconMenu:NativeMenu = new NativeMenu();
			
			if(NativeApplication.supportsSystemTrayIcon){
				var sysTray:SystemTrayIcon = NativeApplication.nativeApplication.icon as SystemTrayIcon;
				sysTray.tooltip = "Poem";
				sysTray.bitmaps = bitmaps;
				
				iconMenu.addItem(new NativeMenuItem("", true)); //separator				
				
				var showCommand:NativeMenuItem = iconMenu.addItem(new NativeMenuItem("Open POEM"));
				showCommand.addEventListener(Event.SELECT, showMenuClick);
				
				var exitCommand:NativeMenuItem = iconMenu.addItem(new NativeMenuItem("Exit POEM"));
				exitCommand.addEventListener(Event.SELECT,exitMenuClick);
				
				sysTray.menu = iconMenu;
			}
			if(NativeApplication.supportsDockIcon){
				DockIcon(NativeApplication.nativeApplication.icon).menu = iconMenu;
			}
			var windowOptions:NativeWindowInitOptions = new NativeWindowInitOptions();
				windowOptions.systemChrome = NativeWindowSystemChrome.NONE; 
				windowOptions.type = NativeWindowType.NORMAL; 
				windowOptions.maximizable = false;
				windowOptions.minimizable = true;
				windowOptions.resizable = false;
				windowOptions.transparent = true;
				
				tv = new NativeWindow(windowOptions);
				tv.stage.scaleMode = StageScaleMode.NO_SCALE;
				tv.stage.align = StageAlign.TOP_LEFT;
				tv.width = 768;
				tv.height = 546;
				tv.bounds = new Rectangle(0, 0, 815, 605);
				tv.addEventListener(Event.ACTIVATE, windowActivated,false,0,true); // wait for the window to be ready before doing stage-based things to it.
				tv.addEventListener(Event.CLOSE, windowClosed,false,0,true);
				tv.activate(); // actually draws the window on the screen
				
				createNotificationWindow();
		}
		
		public function showMenuClick(event:Event = null) : void 
		{
			tv.visible = true;
			tv.activate();
		}
		
		public function exitMenuClick(event:Event) : void 
		{
			IntervalTimer.stop();
			NativeApplication.nativeApplication.exit();
		}
		
		public function windowActivated(event:Event) : void
		{
			
			if (this.isApplicationLoaded == false)
			{				
				this.stage.nativeWindow.removeEventListener(Event.ACTIVATE, windowActivated);
				
				tv.x = (Capabilities.screenResolutionX/2) - (tv.width/2); 
				tv.y = (Capabilities.screenResolutionY / 2) - (tv.height / 2);
				tv.stage.addChild(this);
				this.isApplicationLoaded = true;
				
				// By adding this view to the stage, the PoemApplicationMediator.onRegister function will be called
				this.addChild(new PoemApplicationView());
			}
		}
		
		public function windowClosed(event:Event) : void
		{
			tv.visible = false;
			tv.minimize();
			Debug.forceGC();
		}
		
		//SET DATA RETRIEVAL REFRESH
		private function startIntervalTimer():void{
			var interval:Number = model.config.dataRetrievalInterval * 1000;
			IntervalTimer = new Timer(interval, 0);
			IntervalTimer.addEventListener(TimerEvent.TIMER, updateDisplay,false,0,true);
			IntervalTimer.start();
		}		
		
		private function updateDisplay(event:TimerEvent):void {
			if (model.targetUpdateSend)	{
				clearTimeout(model.tInt);
				targetUpdated.dispatch();
			}
			loadData.dispatch();
		}		
		
		//CHECK FOR MEMORY LEAKS
		private function checkMemoryUsage():void {
			if (System.totalMemory > gcMemory) {
				 collect();
			}
		}
		private function collect():void {
		   System.gc();
		   System.gc();
		}
	}
}
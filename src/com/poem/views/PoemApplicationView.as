package com.poem.views 
{
	import com.adobe.serialization.json.JSON;
	import com.greensock.*;
	import com.greensock.plugins.*;
	import com.hexagonstar.util.debug.Debug;
	import com.poem.constants.EnergyCategory;
	import com.poem.constants.Screens;
	import com.poem.interfaces.IDisposable;
	import com.poem.interfaces.IInitializable;
	import com.poem.models.PoemModel;
	import com.poem.signals.ChangeScreenSignal;
	import com.poem.signals.UpdateUsageScreenSignal;
	import com.poem.views.alert.*;
	import com.poem.views.ambient.*;
	import com.poem.views.comfort.*;
	import com.poem.views.dashboard.*;
	import com.poem.views.framework.*;
	import com.poem.views.menu.*;
	import com.poem.views.usage.UsageDetailsView;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class PoemApplicationView extends Sprite implements IInitializable, IDisposable
	{
		private var currentOverlay:Sprite;
		
		private var dashboard:DashboardView;
		
		private var ev:EVView;
		
		public var usageDetails:UsageDetailsView;
		
		[Inject]
		public var changeScreen:ChangeScreenSignal;
		
		[Inject]
		public var updateScreen:UpdateUsageScreenSignal;		
		
		[Inject]
		public var model:PoemModel;
		
		
		public function initialize() : void
		{
			TweenPlugin.activate([TintPlugin, DropShadowFilterPlugin]);
			
			this.createFramework();
			this.createEV();
			this.createMenu();	
			this.createAmbientValues();
			this.createAlert();
			this.createComfort();		
						
			// First time the application is shown, we will display the dashboard
			this.showDashboard();
		
			// create an event handler for change screen events.  these events are fired by the global
			// menu as well as the dashboardStatusSprites.
			changeScreen.add(changeScreenHandler);
			
			sendOpenPOEM();
		}
		
		private function sendOpenPOEM():void 
		{
			trace("RemoteService - sending openPOEM...");
			var request:URLRequest = new URLRequest(model.config.sensorDBFeedback);
            request.method = URLRequestMethod.POST;	
			var args:Object = new Object();
			args.userID = model.config.userID;
			args.userPassword = model.config.password;
			args.feedbackCategory = "openPOEM";
			request.data = unescape(com.adobe.serialization.json.JSON.encode(args));
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			urlLoader.load(request);
		}
		
		public function dispose() : void
		{
			while (numChildren > 0) removeChildAt(0);
				
			currentOverlay = null;
			model.appState.currentScreen = null;
			model.appState.usageLoaded = false;
			changeScreen.remove(changeScreenHandler);
			model = null;
		}
		
		private function changeScreenHandler(text:String) : void
		{
			
			model.appState.currentScreen = text;
			
			switch ( text){
				case Screens.DASHBOARD:
										

						clearOverlay();

					
					//CREATE DASHBOARD
					if (text != Screens.EVUSAGE) 
					{
						showDashboard();
					}
					
					//SET VAR THAT USAGE SCREEN HAS BEEN DISPOSED
					model.appState.usageLoaded = false;
					
					break;
				case Screens.EVUSAGE:
					hideDashboard();
					hideUsageDetails();
					break;
				default:
					
					//CHECK TO SEE IF USAGE SCREEN ALREADY CREATED	
					if (model.appState.usageLoaded == false){
						
						// CLEAR THE DASHBOARD
						clearOverlay();
						
						// CREATE A NEW USAGE SCREEN
						showUsageDetails(text);
						
					} else {
						
						// IF A USAGE SCREEN HAS ALR3EADY BEEN CREATED, THEN UPDATE IT WITH THE NEW SECTION LABEL FROM THE MODEL
						updateScreen.dispatch();
					}
					
					//SET VAR THAT USAGE SCREEN HAS BEEN CREATED
					model.appState.usageLoaded = true;

					break;
					
			}
			
			Debug.forceGC();			
		}	
		private function createEV():void {
			ev = new EVView();
			ev.x = 40;
			ev.y = 135;
			this.addChild(ev);	
		}
		
		private function dispose_screen():void{
		}

		private function createComfort() : void
		{
			var comfort:Comfort = new Comfort();
			comfort.x = 610;
			comfort.y = 20;
			this.addChild(comfort);	
		}			
		
		private function createAlert() : void
		{
			var alert:AlertView = new AlertView();
			alert.x = 235;
			alert.y = 20;
			this.addChild(alert);	
		}		
		
		private function createAmbientValues() : void
		{
			var ambient_outdoor:Ambient = new AmbientOutdoor();
			ambient_outdoor.x = 423;
			ambient_outdoor.y = 460;
			this.addChild(ambient_outdoor);
			
			var ambient_indoor:Ambient = new AmbientIndoor();
			ambient_indoor.x = 610;
			ambient_indoor.y = 460;
			this.addChild(ambient_indoor);		
		}		
		
		private function createFramework() : void
		{
			var framework:Framework = new Framework();
			
			// by adding this view the FrameworkMediator.onRegister() will be called.
			this.addChild(framework);
		}

		
		private function createMenu() : void
		{
			var menu:GlobalMenu = new GlobalMenu();
			menu.x = 50;
			menu.y = 450;
			this.addChild(menu);
		}
		
		public function showDashboard() : void
		{
			
			dashboard = new DashboardView();
			this.addChildAt(dashboard, 1);
			
			this.currentOverlay = dashboard;
		}
		
		public function hideDashboard() : void
		{
			try 
			{
				this.removeChild(dashboard);
			} 
			catch (err:Error) 
			{
				
			}
			this.currentOverlay = null;
		}
		public function showUsageDetails(category:String) : void
		{
			
			usageDetails = new UsageDetailsView(category, this);
			usageDetails.x = 39;
			usageDetails.y = 128;			
			this.addChildAt(usageDetails, 1);
			
			this.currentOverlay = usageDetails;
		}
		
		public function hideUsageDetails() : void
		{
			
		
			try 
			{
				this.removeChild(usageDetails);
			} 
			catch (err:Error) 
			{
				
			}
			model.appState.usageLoaded = false;
			this.currentOverlay = null;
		}
		
		private function clearOverlay(event:Event = null) : void
		{
			
			if ( currentOverlay != null )
			{
				try 
				{
					removeChild( currentOverlay as Sprite );
				} 
				catch (err:Error) 
				{
					
				}
			}
		}
	}
}
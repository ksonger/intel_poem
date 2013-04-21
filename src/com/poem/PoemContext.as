package com.poem 
{
	import com.poem.helpers.*;
	import flash.display.DisplayObjectContainer;
	import org.robotlegs.mvcs.SignalContext;
	import com.poem.signals.*;
	import com.poem.models.*;
	import com.poem.services.*;
	import com.poem.controllers.*;
	import com.poem.mediators.*;
	import com.poem.mediators.dashboard.*;
	import com.poem.mediators.ambient.*;
	import com.poem.mediators.alert.*;
	import com.poem.mediators.comfort.*;
	import com.poem.mediators.menu.*;
	import com.poem.mediators.usage.*;
	import com.poem.mediators.framework.*;
	import com.poem.views.*;
	import com.poem.views.menu.*;
	import com.poem.views.dashboard.*;
	import com.poem.views.ambient.*;
	import com.poem.views.alert.*;
	import com.poem.views.comfort.*;
	import com.poem.views.usage.*;
	import com.poem.views.framework.*;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class PoemContext extends SignalContext
	{
		
		public function PoemContext(contextView:DisplayObjectContainer) 
		{
			this.contextView = contextView;
		}
		
		override public function startup():void 
		{
			
			// Map models
			injector.mapSingleton(PoemModel);	
			
			// Map views to their mediators	
			mediatorMap.mapView(PoemApplicationView, PoemApplicationMediator);
			mediatorMap.mapView(Framework, FrameworkMediator);
			
			mediatorMap.mapView(DashboardView, DashboardMediator);
			mediatorMap.mapView(EVView, EVMediator);
			mediatorMap.mapView(DashboardStatusEv, DashboardStatusEvMediator);
			mediatorMap.mapView(DashboardStatusOffice, DashboardStatusOfficeMediator);
			mediatorMap.mapView(DashboardStatusSpriteEv, DashboardStatusSpriteEvMediator);
			mediatorMap.mapView(DashboardStatusSpriteOffice, DashboardStatusSpriteOfficeMediator);
			mediatorMap.mapView(DashboardStatusSpriteOfficeTotal, DashboardStatusSpriteOfficeTotalMediator);
			mediatorMap.mapView(DashboardStatusSpritePC, DashboardStatusSpritePCMediator);
			mediatorMap.mapView(DashboardStatusSpritePrinter, DashboardStatusSpritePrinterMediator);
			mediatorMap.mapView(DashboardStatusSpritePluggable, DashboardStatusSpritePluggableMediator);
			
			mediatorMap.mapView(GlobalMenu, GlobalMenuMediator);
			mediatorMap.mapView(GlobalSubMenu, GlobalSubMenuMediator);
			mediatorMap.mapView(GlobalSubMenuItem, GlobalSubMenuItemMediator);
			mediatorMap.mapView(GlobalMenuItemDashboard, GlobalMenuItemDashboardMediator);
			mediatorMap.mapView(GlobalMenuItemOffice, GlobalMenuItemOfficeMediator);
			mediatorMap.mapView(GlobalMenuItemEv, GlobalMenuItemEvMediator);
			
			mediatorMap.mapView(AmbientOutdoor, AmbientOutdoorMediator);
			mediatorMap.mapView(AmbientIndoor, AmbientIndoorMediator);
			
			mediatorMap.mapView(AlertView, AlertMediator);
			mediatorMap.mapView(Comfort, ComfortMediator);	
			mediatorMap.mapView(HeaderView, HeaderViewMediator);
			mediatorMap.mapView(BarChart, BarChartMediator);
			mediatorMap.mapView(Bar, BarMediator);
			mediatorMap.mapView(Marker, MarkerMediator);
			mediatorMap.mapView(Pluggables, PluggablesMediator);
			mediatorMap.mapView(PluggableItem, PluggableItemMediator);
			
			mediatorMap.mapView(ToolTipHelper, ToolTipHelperMediator);
			mediatorMap.mapView(MarkerToolTipHelper,MarkerToolTipHelperMediator);
			
			mediatorMap.mapView(BarChartLegend, BarChartLegendMediator);
			mediatorMap.mapView(UsageDetailsView, UsageDetailsMediator);
			mediatorMap.mapView(ComparisonMarker, ComparisonMarkerMediator);
			mediatorMap.mapView(CloseButton, CloseButtonMediator);
			mediatorMap.mapView(MinimizeButton, MinimizeButtonMediator);
			
			// Map the service classes
			injector.mapSingletonOf(IPoemService, RemoteService); // This mapping could map to either the LocalService or RemoteService
			injector.mapSingletonOf(IConfigurationService, PoemConfigurationService);
			injector.mapSingleton(PoemImageService);
			
			// Map the signals
			injector.mapSingleton(AddMarkerToolTipSignal);
			injector.mapSingleton(RemoveMarkerToolTipSignal);
			injector.mapSingleton(ConfigurationDataLoadedSignal);
			injector.mapSingleton(SensorDataUpdatedSignal);
			injector.mapSingleton(PoemIconBitmapsLoadedSignal);
			injector.mapSingleton(NotificationAreaLoadedSignal);
			injector.mapSingleton(ShowDashboardSignal);
			injector.mapSingleton(ChangeScreenSignal);
			injector.mapSingleton(UpdateUsageScreenSignal);
			
			// Map certain signals to commands they are intended to invoke.  
			signalCommandMap.mapSignalClass(LoadDataSignal, LoadSensorDataCommand);
			signalCommandMap.mapSignalClass(LoadIconBitmapsSignal, LoadIconBitmapsCommand);
			signalCommandMap.mapSignalClass(ComfortIconsLoadedSignal, InitComfortIconsCommand);
			signalCommandMap.mapSignalClass(ComfortLevelSendSignal, ComfortLevelSendCommand);
			signalCommandMap.mapSignalClass(ComfortReadySignal, ComfortReadyCommand);
			signalCommandMap.mapSignalClass(PoemTargetUpdatedSignal, PoemTargetUpdatedCommand);
			signalCommandMap.mapSignalClass(TargetAlertsUpdatedSignal, TargetAlertsUpdatedCommand);
			
			// Map the application signal to the LoadConfigurationData command, then dispatch the signal
			ApplicationStartedSignal(signalCommandMap.mapSignalClass(ApplicationStartedSignal, LoadConfigurationDataCommand, true)).dispatch();
		}
	}
}
package com.poem.services 
{
	import com.poem.helpers.LabelManager;
	import com.poem.models.ConfigurationData;
	import com.poem.models.PoemModel;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class PoemConfigurationService implements IConfigurationService
	{
		[Inject]
		public var model:PoemModel;
		
		private var loader:URLLoader;
		private var _data:String;
				
		public function loadConfigurationData() : void
		{
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, handleXml,false,0,true);
			loader.load(new URLRequest("config.xml"));
		}
		
		
		//public function handleXml(event:Event) : void
		public function handleXml(event:Event = null) : void
		{
			// Instantiate an XML object
			var configXml:XML = new XML(event.target.data);
			configXml.ignoreWhitespace = true;
			
			
			// make sure to load the labelManager before you load the configData.  The reason is
			// that the configData triggers the "ConfigurationDataLoadedSignal".
			var labelManager:LabelManager = new LabelManager();
			labelManager.loadLabels(configXml);
			model.labelManager = labelManager;
						
			// load the configData after the labelManager
			var configData:ConfigurationData = new ConfigurationData();
			
			configData.userID = configXml.user.id;
			configData.password = configXml.user.pass;
			configData.hostname = configXml.user.hostname;
			configData.sensorDB = configXml.sensorDB;
			configData.sensorAttempts = configXml.sensorAttempts;
			configData.sensorInterval = configXml.sensorInterval;
			configData.sensorDBFeedback = configXml.sensorDBFeedback;
			
			configData.dataRetrievalInterval = configXml.dataRetrievalInterval;
			
			configData.icon16 = configXml.notificationAreaIcons.default.icon16;
			configData.icon32 = configXml.notificationAreaIcons.default.icon32;
			configData.icon48 = configXml.notificationAreaIcons.default.icon48;
			configData.icon128 = configXml.notificationAreaIcons.default.icon128;
			
			configData.onTarget16 = configXml.notificationAreaIcons.onTarget.icon16;
			configData.onTarget32 = configXml.notificationAreaIcons.onTarget.icon32;
			configData.onTarget48 = configXml.notificationAreaIcons.onTarget.icon48;
			configData.onTarget128 = configXml.notificationAreaIcons.onTarget.icon128;	

			configData.aboveTarget16 = configXml.notificationAreaIcons.aboveTarget.icon16;
			configData.aboveTarget32 = configXml.notificationAreaIcons.aboveTarget.icon32;
			configData.aboveTarget48 = configXml.notificationAreaIcons.aboveTarget.icon48;
			configData.aboveTarget128 = configXml.notificationAreaIcons.aboveTarget.icon128;	
			
			configData.belowTarget16 = configXml.notificationAreaIcons.belowTarget.icon16;
			configData.belowTarget32 = configXml.notificationAreaIcons.belowTarget.icon32;
			configData.belowTarget48 = configXml.notificationAreaIcons.belowTarget.icon48;
			configData.belowTarget128 = configXml.notificationAreaIcons.belowTarget.icon128;	
			
			configData.online32 = configXml.notificationAreaIcons.monitorStatus.online32;
			configData.offline32 = configXml.notificationAreaIcons.monitorStatus.offline32;
			configData.dbError32 = configXml.notificationAreaIcons.monitorStatus.dbError32;
			
			configData.backgroundImageURL = configXml.imageMappings.add.(@name == "background").@value;
			configData.minimizeButtonImageURL = configXml.imageMappings.add.(@name == "minimizeButton").@value;
			configData.closeButtonImageURL = configXml.imageMappings.add.(@name == "closeButton").@value;
			configData.dashboardBackgroundImageURL = configXml.imageMappings.add.(@name == "dashboardBackground").@value;
			
			configData.alertIconURL = configXml.imageMappings.add.(@name == "alertIcon").@value;
			configData.comfortHotIconURL = configXml.imageMappings.add.(@name == "comfortHotIcon").@value;
			configData.comfortColdIconURL = configXml.imageMappings.add.(@name == "comfortColdIcon").@value;
			configData.comfortArrowIconURL = configXml.imageMappings.add.(@name == "comfortArrowIcon").@value;
			
			configData.menuDashboardIconURL = configXml.imageMappings.add.(@name == "menuIconDashboard").@value;
			configData.menuOfficeIconURL = configXml.imageMappings.add.(@name == "menuIconOffice").@value;
			configData.menuEvIconURL = configXml.imageMappings.add.(@name == "menuIconEv").@value;
			configData.submenuBackgroundURL = configXml.imageMappings.add.(@name == "submenuBackground").@value;
			
			configData.dashboardStatusBackgroundURL = configXml.imageMappings.add.(@name == "dashboardStatusBackground").@value;
			configData.dashboardStatusBackgroundSmallURL = configXml.imageMappings.add.(@name == "dashboardStatusBackgroundSmall").@value;
			configData.dashboardStatusMatteURL = configXml.imageMappings.add.(@name == "dashboardStatusMatte").@value;
			configData.dashboardStatusMatteWideURL = configXml.imageMappings.add.(@name == "dashboardStatusMatteWide").@value;
			
			configData.dashboardStatusFlowerPoorURL = configXml.imageMappings.add.(@name == "dashboardStatusFlowerPoor").@value;
			configData.dashboardStatusFlowerFairURL = configXml.imageMappings.add.(@name == "dashboardStatusFlowerFair").@value;
			configData.dashboardStatusFlowerGoodURL = configXml.imageMappings.add.(@name == "dashboardStatusFlowerGood").@value;
			
			configData.dashboardStatusChartPoorURL = configXml.imageMappings.add.(@name == "dashboardStatusChartPoor").@value;
			configData.dashboardStatusChartFairURL = configXml.imageMappings.add.(@name == "dashboardStatusChartFair").@value;
			configData.dashboardStatusChartGoodURL = configXml.imageMappings.add.(@name == "dashboardStatusChartGood").@value;
			
			configData.dashboardStatusChartPoorSmallURL = configXml.imageMappings.add.(@name == "dashboardStatusChartPoorSmall").@value;
			configData.dashboardStatusChartFairSmallURL = configXml.imageMappings.add.(@name == "dashboardStatusChartFairSmall").@value;
			configData.dashboardStatusChartGoodSmallURL = configXml.imageMappings.add.(@name == "dashboardStatusChartGoodSmall").@value;			
			
			configData.dashboardStatusTrendUpURL = configXml.imageMappings.add.(@name == "dashboardStatusTrendUp").@value;
			configData.dashboardStatusTrendDownURL = configXml.imageMappings.add.(@name == "dashboardStatusTrendDown").@value;
			configData.dashboardStatusTrendUpSmallURL = configXml.imageMappings.add.(@name == "dashboardStatusTrendUpSmall").@value;
			configData.dashboardStatusTrendDownSmallURL = configXml.imageMappings.add.(@name == "dashboardStatusTrendDownSmall").@value;			
			
			configData.usageStatusFairImageURL = configXml.imageMappings.add.(@name == "usageStatusFairImage").@value;
			configData.usageStatusGoodImageURL = configXml.imageMappings.add.(@name == "usageStatusGoodImage").@value;
			configData.usageStatusPoorImageURL = configXml.imageMappings.add.(@name == "usageStatusPoorImage").@value;
			
			configData.statusFairOffImageURL = configXml.imageMappings.add.(@name == "statusFairOff").@value;
			configData.statusGoodOffImageURL = configXml.imageMappings.add.(@name == "statusGoodOff").@value;
			configData.statusPoorOffImageURL = configXml.imageMappings.add.(@name == "statusPoorOff").@value;
			configData.statusFairOnImageURL = configXml.imageMappings.add.(@name == "statusFairOn").@value;
			configData.statusGoodOnImageURL = configXml.imageMappings.add.(@name == "statusGoodOn").@value;
			configData.statusPoorOnImageURL = configXml.imageMappings.add.(@name == "statusPoorOn").@value;
			
			configData.usageBackgroundImageURL = configXml.imageMappings.add.(@name == "usageBackground").@value;
			configData.barChartBackgroundImageURL = configXml.imageMappings.add.(@name == "barChartBackground").@value;
			
			configData.usagePluggableBackgroundImageURL = configXml.imageMappings.add.(@name == "usagePluggableBackground").@value;
			configData.usagePluggableMonitorImageURL = configXml.imageMappings.add.(@name == "usagePluggableMonitor").@value;
			configData.usagePluggableLightsImageURL = configXml.imageMappings.add.(@name == "usagePluggableLights").@value;
			configData.usagePluggableFanImageURL = configXml.imageMappings.add.(@name == "usagePluggableFan").@value;
			configData.usagePluggableHeaterImageURL = configXml.imageMappings.add.(@name == "usagePluggableHeater").@value;
			configData.usagePluggableComputerImageURL = configXml.imageMappings.add.(@name == "usagePluggableComputer").@value;
			configData.usagePluggableBatteryImageURL = configXml.imageMappings.add.(@name == "usagePluggableBattery").@value;
			configData.usageAddTargetIcon = configXml.imageMappings.add.(@name == "usageAddTargetIcon").@value;
			configData.usageRemoveTargetIcon = configXml.imageMappings.add.(@name == "usageRemoveTargetIcon").@value;
			
			configData.usagePluggableToggleBackgroundImageURL = configXml.imageMappings.add.(@name == "usagePluggableToggleBackground").@value;
			configData.usagePluggableToggleHandleImageURL = configXml.imageMappings.add.(@name == "usagePluggableToggleHandle").@value;
			
			configData.menuBackground = configXml.imageMappings.add.(@name == "menuBackground").@value;
			configData.evImage = configXml.imageMappings.add.(@name == "evImage").@value;
			
			configData.barChartCapImageURL = configXml.imageMappings.add.(@name == "barChartCap").@value;
			
			model.config = configData;
			
			//loader.removeEventListener(Event.COMPLETE, handleXml);
			loader = null;
		}
	}
}
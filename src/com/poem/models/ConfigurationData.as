package com.poem.models 
{
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class ConfigurationData 
	{
		private var _userID:String;
		private var _password:String;
		private var _hostname:String;
		private var _sensorDB:String;
		private var _sensorAttempts:String;
		private var _sensorInterval:String;
		private var _sensorDBFeedback:String;
		
		private var _dataRetrievalInterval:Number;
		
		private var _icon16:String;
		private var _icon32:String;
		private var _icon48:String;
		private var _icon128:String;
		
		private var _aboveTarget16:String;
		private var _aboveTarget32:String;
		private var _aboveTarget48:String;
		private var _aboveTarget128:String;	
		
		private var _belowTarget16:String;
		private var _belowTarget32:String;
		private var _belowTarget48:String;
		private var _belowTarget128:String;	
		
		private var _onTarget16:String;
		private var _onTarget32:String;
		private var _onTarget48:String;
		private var _onTarget128:String;
		
		private var _online32:String;
		private var _offline32:String;
		private var _dbError32:String;
		
		private var _backgroundImageURL:String;
		private var _minimuzeButtonImageURL:String;
		private var _closeButtonImageURL:String;
		private var _dashboardBackgroundImageURL:String;
		
		private var _barChartCapImageURL:String;
		
		private var _alertIconURL:String;
		private var _comfortHotIconURL:String;
		private var _comfortColdIconURL:String;
		private var _comfortArrowIconURL:String;
		
		private var _menuDashboardIconURL:String;
		private var _menuOfficeIconURL:String;
		private var _menuEvIconURL:String;
		private var _submenuBackgroundURL:String;
		
		private var _dashboardStatusBackgroundURL:String;
		private var _dashboardStatusBackgroundSmallURL:String;
		private var _dashboardStatusMatteURL:String;
		private var _dashboardStatusMatteWideURL:String;
		
		private var _dashboardStatusFlowerPoorURL:String;
		private var _dashboardStatusFlowerFairURL:String;
		private var _dashboardStatusFlowerGoodURL:String;
		
		private var _dashboardStatusChartPoorURL:String;
		private var _dashboardStatusChartFairURL:String;
		private var _dashboardStatusChartGoodURL:String;
		
		private var _dashboardStatusChartPoorSmallURL:String;
		private var _dashboardStatusChartFairSmallURL:String;
		private var _dashboardStatusChartGoodSmallURL:String;		
		
		private var _dashboardStatusTrendUpURL:String;
		private var _dashboardStatusTrendDownURL:String;
		private var _dashboardStatusTrendUpSmallURL:String;
		private var _dashboardStatusTrendDownSmallURL:String;		
		
		private var _usageBackgroundImageURL:String;
		private var _barChartBackgroundImageURL:String;		
		
		private var _usagePluggableBackgroundImageURL:String;		
		private var _usagePluggableMonitorImageURL:String;		
		private var _usagePluggableLightsImageURL:String;
		private var _usagePluggableFanImageURL:String;	
		private var _usagePluggableHeaterImageURL:String;	
		private var _usagePluggableComputerImageURL:String;
		private var _usagePluggableBatteryImageURL:String;
		private var _usageAddTargetIcon:String;	
		private var _usageRemoveTargetIcon:String;	
		
		private var _usagePluggableToggleBackgroundImageURL:String;
		private var _usagePluggableToggleHandleImageURL:String;
		
		private var _usageStatusFairImageURL:String;
		private var _usageStatusGoodImageURL:String;
		private var _usageStatusPoorImageURL:String;
		
		private var _pcCategoryLabel:String;
		private var _printerCategoryLabel:String;
		private var _pluggablesCategoryLabel:String;
		
		private var _statusFairOnImageURL:String;
		private var _statusFairOffImageURL:String;
		private var _statusGoodOnImageURL:String;
		private var _statusGoodOffImageURL:String;
		private var _statusPoorOnImageURL:String;
		private var _statusPoorOffImageURL:String;
		
		private var _menuBackground:String;
		private var _evImage:String;
		
		private var _administratorLimit:Number = 3500;

		
		public function get dashboardStatusChartPoorSmallURL() : String
		{
			return _dashboardStatusChartPoorSmallURL;
		}
		
		public function set dashboardStatusChartPoorSmallURL(v:String) : void
		{
			_dashboardStatusChartPoorSmallURL = v;
		}			
		
		public function get dashboardStatusChartFairSmallURL() : String
		{
			return _dashboardStatusChartFairSmallURL;
		}
		
		public function set dashboardStatusChartFairSmallURL(v:String) : void
		{
			_dashboardStatusChartFairSmallURL = v;
		}		
		
		public function get dashboardStatusChartGoodSmallURL() : String
		{
			return _dashboardStatusChartGoodSmallURL;
		}
		
		public function set dashboardStatusChartGoodSmallURL(v:String) : void
		{
			_dashboardStatusChartGoodSmallURL = v;
		}
		
		public function get dashboardStatusTrendDownSmallURL() : String
		{
			return _dashboardStatusTrendDownSmallURL;
		}
		
		public function set dashboardStatusTrendDownSmallURL(v:String) : void
		{
			_dashboardStatusTrendDownSmallURL = v;
		}		
		
		public function get dashboardStatusTrendUpSmallURL() : String
		{
			return _dashboardStatusTrendUpSmallURL;
		}
		
		public function set dashboardStatusTrendUpSmallURL(v:String) : void
		{
			_dashboardStatusTrendUpSmallURL = v;
		}		
		
		public function get dashboardStatusTrendDownURL() : String
		{
			return _dashboardStatusTrendDownURL;
		}
		
		public function set dashboardStatusTrendDownURL(v:String) : void
		{
			_dashboardStatusTrendDownURL = v;
		}		
		
		public function get dashboardStatusTrendUpURL() : String
		{
			return _dashboardStatusTrendUpURL;
		}
		
		public function set dashboardStatusTrendUpURL(v:String) : void
		{
			_dashboardStatusTrendUpURL = v;
		}		

		public function get dashboardStatusChartPoorURL() : String
		{
			return _dashboardStatusChartPoorURL;
		}
		
		public function set dashboardStatusChartPoorURL(v:String) : void
		{
			_dashboardStatusChartPoorURL = v;
		}			
		
		public function get dashboardStatusChartFairURL() : String
		{
			return _dashboardStatusChartFairURL;
		}
		
		public function set dashboardStatusChartFairURL(v:String) : void
		{
			_dashboardStatusChartFairURL = v;
		}		
		
		public function get dashboardStatusChartGoodURL() : String
		{
			return _dashboardStatusChartGoodURL;
		}
		
		public function set dashboardStatusChartGoodURL(v:String) : void
		{
			_dashboardStatusChartGoodURL = v;
		}		

		public function get dashboardStatusFlowerPoorURL() : String
		{
			return _dashboardStatusFlowerPoorURL;
		}
		
		public function set dashboardStatusFlowerPoorURL(v:String) : void
		{
			_dashboardStatusFlowerPoorURL = v;
		}			
		
		public function get dashboardStatusFlowerFairURL() : String
		{
			return _dashboardStatusFlowerFairURL;
		}
		
		public function set dashboardStatusFlowerFairURL(v:String) : void
		{
			_dashboardStatusFlowerFairURL = v;
		}		
		
		public function get dashboardStatusFlowerGoodURL() : String
		{
			return _dashboardStatusFlowerGoodURL;
		}
		
		public function set dashboardStatusFlowerGoodURL(v:String) : void
		{
			_dashboardStatusFlowerGoodURL = v;
		}

		public function get dashboardStatusMatteWideURL() : String
		{
			return _dashboardStatusMatteWideURL;
		}
		
		public function set dashboardStatusMatteWideURL(v:String) : void
		{
			_dashboardStatusMatteWideURL = v;
		}			
		
		public function get dashboardStatusMatteURL() : String
		{
			return _dashboardStatusMatteURL;
		}
		
		public function set dashboardStatusMatteURL(v:String) : void
		{
			_dashboardStatusMatteURL = v;
		}		

		public function get dashboardStatusBackgroundSmallURL() : String
		{
			return _dashboardStatusBackgroundSmallURL;
		}
		
		public function set dashboardStatusBackgroundSmallURL(v:String) : void
		{
			_dashboardStatusBackgroundSmallURL = v;
		}		
		
		public function get dashboardStatusBackgroundURL() : String
		{
			return _dashboardStatusBackgroundURL;
		}
		
		public function set dashboardStatusBackgroundURL(v:String) : void
		{
			_dashboardStatusBackgroundURL = v;
		}		
		
		public function get menuEvIconURL() : String
		{
			return _menuEvIconURL;
		}
		
		public function set menuEvIconURL(v:String) : void
		{
			_menuEvIconURL = v;
		}			
		
		public function get menuOfficeIconURL() : String
		{
			return _menuOfficeIconURL;
		}
		
		public function set menuOfficeIconURL(v:String) : void
		{
			_menuOfficeIconURL = v;
		}			

		public function get submenuBackgroundURL() : String
		{
			return _submenuBackgroundURL;
		}
		
		public function set submenuBackgroundURL(v:String) : void
		{
			_submenuBackgroundURL = v;
		}		
		
		public function get menuDashboardIconURL() : String
		{
			return _menuDashboardIconURL;
		}
		
		public function set menuDashboardIconURL(v:String) : void
		{
			_menuDashboardIconURL = v;
		}		
		
		public function get comfortColdIconURL() : String
		{
			return _comfortColdIconURL;
		}
		
		public function set comfortColdIconURL(v:String) : void
		{
			_comfortColdIconURL = v;
		}		
		
		public function get comfortHotIconURL() : String
		{
			return _comfortHotIconURL;
		}
		
		public function set comfortHotIconURL(v:String) : void
		{
			_comfortHotIconURL = v;
		}		
		
		public function get alertIconURL() : String
		{
			return _alertIconURL;
		}
		
		public function set alertIconURL(v:String) : void
		{
			_alertIconURL = v;
		}		
		
		public function get barChartCapImageURL() : String
		{
			return _barChartCapImageURL;
		}
		
		public function set barChartCapImageURL(v:String) : void
		{
			_barChartCapImageURL = v;
		}

		
		public function get usagePluggableMonitorImageURL() : String
		{
			return _usagePluggableMonitorImageURL;
		}
		
		public function set usagePluggableMonitorImageURL(v:String) : void
		{
			_usagePluggableMonitorImageURL = v;
		}	
		public function get usagePluggableLightsImageURL() : String
		{
			return _usagePluggableLightsImageURL;
		}
		
		public function set usagePluggableLightsImageURL(v:String) : void
		{
			_usagePluggableLightsImageURL = v;
		}
		
		public function get usagePluggableFanImageURL() : String
		{
			return _usagePluggableFanImageURL;
		}
		
		public function set usagePluggableHeaterImageURL(v:String) : void
		{
			_usagePluggableHeaterImageURL = v;
		}
		
		public function get usagePluggableHeaterImageURL() : String
		{
			return _usagePluggableHeaterImageURL;
		}
		
		public function set usagePluggableComputerImageURL(v:String) : void
		{
			_usagePluggableComputerImageURL = v;
		}
		
		public function get usagePluggableComputerImageURL() : String
		{
			return _usagePluggableComputerImageURL;
		}
		
		public function set usagePluggableBatteryImageURL(v:String) : void
		{
			_usagePluggableBatteryImageURL = v;
		}
		
		public function get usagePluggableBatteryImageURL() : String
		{
			return _usagePluggableBatteryImageURL;
		}		
		
		public function set usagePluggableFanImageURL(v:String) : void
		{
			_usagePluggableFanImageURL = v;
		}
		
		public function get usagePluggableToggleBackgroundImageURL() : String
		{
			return _usagePluggableToggleBackgroundImageURL;
		}		
		
		public function set usagePluggableToggleBackgroundImageURL(v:String) : void
		{
			_usagePluggableToggleBackgroundImageURL = v;
		}
		
		public function get usagePluggableToggleHandleImageURL() : String
		{
			return _usagePluggableToggleHandleImageURL;
		}		
		
		public function set usagePluggableToggleHandleImageURL(v:String) : void
		{
			_usagePluggableToggleHandleImageURL = v;
		}		
		
		public function get usagePluggableBackgroundImageURL() : String
		{
			return _usagePluggableBackgroundImageURL;
		}
		
		public function set usagePluggableBackgroundImageURL(v:String) : void
		{
			_usagePluggableBackgroundImageURL = v;
		}		
		
		public function get barChartBackgroundImageURL() : String
		{
			return _barChartBackgroundImageURL;
		}
		
		public function set barChartBackgroundImageURL(v:String) : void
		{
			_barChartBackgroundImageURL = v;
		}		
		
		public function get usageBackgroundImageURL() : String
		{
			return _usageBackgroundImageURL;
		}
		
		public function set usageBackgroundImageURL(v:String) : void
		{
			_usageBackgroundImageURL = v;
		}
		
		public function get menuBackground() : String
		{
			return _menuBackground;
		}
		
		public function set menuBackground(v:String) : void
		{
			_menuBackground = v;
		}
		
		public function get statusFairOnImageURL() : String
		{
			return _statusFairOnImageURL;
		}
		
		public function set statusFairOnImageURL(v:String) : void
		{
			_statusFairOnImageURL = v;
		}
		
		public function get statusGoodOnImageURL() : String
		{
			return _statusGoodOnImageURL;
		}
		
		public function set statusGoodOnImageURL(v:String) : void
		{
			_statusGoodOnImageURL = v;
		}
		
		public function get statusPoorOnImageURL() : String
		{
			return _statusPoorOnImageURL;
		}
		
		public function set statusPoorOnImageURL(v:String) : void
		{
			_statusPoorOnImageURL = v;
		}
		
		public function get statusFairOffImageURL() : String
		{
			return _statusFairOffImageURL;
		}
		
		public function set statusFairOffImageURL(v:String) : void
		{
			_statusFairOffImageURL = v;
		}
		
		public function get statusGoodOffImageURL() : String
		{
			return _statusGoodOffImageURL;
		}
		
		public function set statusGoodOffImageURL(v:String) : void
		{
			_statusGoodOffImageURL = v;
		}
		
		public function get statusPoorOffImageURL() : String
		{
			return _statusPoorOffImageURL;
		}
		
		public function set statusPoorOffImageURL(v:String) : void
		{
			_statusPoorOffImageURL = v;
		}		
		/*
		public function get pluggablesCategoryLabel() : String
		{
			return _pluggablesCategoryLabel;
		}
		
		public function set pluggablesCategoryLabel(v:String) : void
		{
			_pluggablesCategoryLabel = v;
		}
		
		public function get printerCategoryLabel() : String
		{
			return _printerCategoryLabel;
		}
		
		public function set printerCategoryLabel(v:String) : void
		{
			_printerCategoryLabel = v;
		}
		
		public function get pcCategoryLabel() : String
		{
			return _pcCategoryLabel;
		}
		
		public function set pcCategoryLabel(v:String) : void
		{
			_pcCategoryLabel = v;
		}
		*/
		
		public function get usageStatusPoorImageURL() : String
		{
			return _usageStatusPoorImageURL;
		}
		
		public function set usageStatusPoorImageURL(v:String) : void
		{
			_usageStatusPoorImageURL = v;
		}
		
		public function get usageStatusGoodImageURL() : String
		{
			return _usageStatusGoodImageURL;
		}
		
		public function set usageStatusGoodImageURL(v:String) : void
		{
			_usageStatusGoodImageURL = v;
		}
		
		public function get usageStatusFairImageURL() : String
		{
			return _usageStatusFairImageURL;
		}
		
		public function set usageStatusFairImageURL(v:String) : void
		{
			_usageStatusFairImageURL = v;
		}
		
		public function get dashboardBackgroundImageURL() : String
		{
			return _dashboardBackgroundImageURL;
		}
		
		public function set dashboardBackgroundImageURL(v:String) : void
		{
			_dashboardBackgroundImageURL = v;
		}
		
		public function get backgroundImageURL() : String
		{
			return _backgroundImageURL;
		}
		
		public function set backgroundImageURL(v:String) : void
		{
			_backgroundImageURL = v;
		}
		
		public function get minimizeButtonImageURL() : String
		{
			return _minimuzeButtonImageURL;
		}
		
		public function set minimizeButtonImageURL(v:String) : void
		{
			_minimuzeButtonImageURL = v;
		}
		
		public function get closeButtonImageURL() : String
		{
			return _closeButtonImageURL;
		}
		
		public function set closeButtonImageURL(v:String) : void
		{
			_closeButtonImageURL = v;
		}
		
		public function get userID() : String
		{
			return _userID;
		}
		
		public function get password() : String
		{
			return _password;
		}
		
		//GET APP ICON
		public function get icon16() : String
		{
			return _icon16;
		}
		
		public function get icon32() : String
		{
			return _icon32;
		}
		
		public function get icon48() : String
		{
			return _icon48;
		}
		
		public function get icon128() : String
		{
			return _icon128;
		}
		
		//GET ABOVE TARGET
		public function get aboveTarget16() : String
		{
			return _aboveTarget16;
		}		
		
		public function get aboveTarget32() : String
		{
			return _aboveTarget32;
		}				
		
		public function get aboveTarget48() : String
		{
			return _aboveTarget48;
		}	
		
		public function get aboveTarget128() : String
		{
			return _aboveTarget128;
		}
		
		//GET ON TARGET
		public function get onTarget16() : String
		{
			return _onTarget16;
		}		
		
		public function get onTarget32() : String
		{
			return _onTarget32;
		}				
		
		public function get onTarget48() : String
		{
			return _onTarget48;
		}	
		
		public function get onTarget128() : String
		{
			return _onTarget128;
		}	
		
		//GET BELOW TARGET
		public function get belowTarget16() : String
		{
			return _belowTarget16;
		}		
		
		public function get belowTarget32() : String
		{
			return _belowTarget32;
		}				
		
		public function get belowTarget48() : String
		{
			return _belowTarget48;
		}	
		
		public function get belowTarget128() : String
		{
			return _belowTarget128;
		}			
		
		
		
		public function get sensorDB() : String
		{
			return _sensorDB;
		}
		
		public function set userID(v:String) : void
		{
			_userID = v;
		}
		
		public function set password(v:String) : void
		{
			_password = v;
		}
		
		public function set sensorDB(v:String) : void
		{
			_sensorDB = v;
		}		
		
		public function get dataRetrievalInterval() : Number
		{
			return _dataRetrievalInterval;
		}
		public function set dataRetrievalInterval(v:Number) : void
		{
			_dataRetrievalInterval = v;
		}	
		
		
		//SET APP ICON
		public function set icon16(v:String) : void
		{
			_icon16 = v;
		}
		
		public function set icon32(v:String) : void
		{
			_icon32 = v;
		}
		
		public function set icon48(v:String) : void
		{
			_icon48 = v;
		}
		
		public function set icon128(v:String) : void
		{
			_icon128 = v;
		}
		
		//SET ON TARGET
		public function set onTarget16(v:String) : void
		{
			_onTarget16 = v;
		}
		
		public function set onTarget32(v:String) : void
		{
			_onTarget32 = v;
		}
		
		public function set onTarget48(v:String) : void
		{
			_onTarget48 = v;
		}
		
		public function set onTarget128(v:String) : void
		{
			_onTarget128 = v;
		}	
		
		//SET ABOVE TARGET
		public function set aboveTarget16(v:String) : void
		{
			_aboveTarget16 = v;
		}
		
		public function set aboveTarget32(v:String) : void
		{
			_aboveTarget32 = v;
		}
		
		public function set aboveTarget48(v:String) : void
		{
			_aboveTarget48 = v;
		}
		
		public function set aboveTarget128(v:String) : void
		{
			_aboveTarget128 = v;
		}	
		
		//SET BELOW TARGET
		public function set belowTarget16(v:String) : void
		{
			_belowTarget16 = v;
		}
		
		public function set belowTarget32(v:String) : void
		{
			_belowTarget32 = v;
		}
		
		public function set belowTarget48(v:String) : void
		{
			_belowTarget48 = v;
		}
		
		public function set belowTarget128(v:String) : void
		{
			_belowTarget128 = v;
		}			
		
		public function get sensorDBFeedback():String 
		{
			return _sensorDBFeedback;
		}
		
		public function set sensorDBFeedback(value:String):void 
		{
			_sensorDBFeedback = value;
		}
		
		public function get comfortArrowIconURL():String 
		{
			return _comfortArrowIconURL;
		}
		
		public function set comfortArrowIconURL(value:String):void 
		{
			_comfortArrowIconURL = value;
		}
		
		public function get usageAddTargetIcon():String 
		{
			return _usageAddTargetIcon;
		}
		
		public function set usageAddTargetIcon(value:String):void 
		{
			_usageAddTargetIcon = value;
		}
		
		public function get usageRemoveTargetIcon():String 
		{
			return _usageRemoveTargetIcon;
		}
		
		public function set usageRemoveTargetIcon(value:String):void 
		{
			_usageRemoveTargetIcon = value;
		}
		
		public function get administratorLimit():Number 
		{
			return _administratorLimit;
		}
		
		public function set administratorLimit(value:Number):void 
		{
			_administratorLimit = value;
		}
		
		public function get hostname():String 
		{
			return _hostname;
		}
		
		public function set hostname(value:String):void 
		{
			_hostname = value;
		}
		
		public function get evImage():String 
		{
			return _evImage;
		}
		
		public function set evImage(value:String):void 
		{
			_evImage = value;
		}
		
		public function get online32():String 
		{
			return _online32;
		}
		
		public function set online32(value:String):void 
		{
			_online32 = value;
		}
		
		public function get offline32():String 
		{
			return _offline32;
		}
		
		public function set offline32(value:String):void 
		{
			_offline32 = value;
		}
		
		public function get dbError32():String 
		{
			return _dbError32;
		}
		
		public function set dbError32(value:String):void 
		{
			_dbError32 = value;
		}
		
		public function get sensorAttempts():String 
		{
			return _sensorAttempts;
		}
		
		public function set sensorAttempts(value:String):void 
		{
			_sensorAttempts = value;
		}
		
		public function get sensorInterval():String 
		{
			return _sensorInterval;
		}
		
		public function set sensorInterval(value:String):void 
		{
			_sensorInterval = value;
		}
		

	}

}
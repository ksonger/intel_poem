package com.poem.models 
{
	import com.poem.constants.EnergyCategory;
	import com.poem.constants.Screens;
	import com.poem.helpers.LabelManager;
	import com.poem.models.DailyEnergyConsumption;
	import com.poem.models.EnergyComparison;
	import com.poem.signals.ComfortLevelSendSignal;
	import com.poem.signals.ConfigurationDataLoadedSignal;
	import com.poem.signals.SensorDataUpdatedSignal;
	
	import mx.controls.Label;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class PoemModel 
	{
		private var _config:ConfigurationData;
		private var _sensorData:PoemData;
		private var _appState:ApplicationState = new ApplicationState();
		private var _selectedEnergyCategory:String;
		private var _comfortLevel:Number = 0;
		private var _labelManager:LabelManager;
		private var _alert:Alert;
		private var _barMax:Number;
		private var _targetUpdateSend:Boolean = false;
		private var _dbconnected:Boolean = true;
		private var _connected:Boolean = true;
		private var _tInt:Number;

		
		[Inject]
		public var loaded:ConfigurationDataLoadedSignal;
		
		[Inject]
		public var comfort:ComfortLevelSendSignal;
		
		[Inject]
		public var dataUpdated:SensorDataUpdatedSignal;
		
		public var firstLoad:Boolean = true;
		
		public function PoemModel() : void
		{
		}
		
		public function get alert() : Alert
		{
			return _alert;
		}
		
		public function set alert(v:Alert) : void
		{
			_alert = v;
		}
		
		public function get labelManager() : LabelManager
		{
			return _labelManager;
		}
		
		public function set labelManager(v:LabelManager) : void
		{
			_labelManager = v;
		}
		
		public function get appState() : ApplicationState
		{
			return _appState;
		}
		
		public function set appState(v:ApplicationState) : void
		{
			_appState = v;
		}
		
		public function get sensorData() : PoemData
		{
			return _sensorData;
		}
		
		public function set sensorData(v:PoemData) : void
		{
			_sensorData = v;
			
			// Dispatch a signal letting the rest of the application know that the data is updated
			dataUpdated.dispatch();
		}
		
		public function get config() : ConfigurationData
		{
			return _config;
		}
		
		public function set config(v:ConfigurationData) : void
		{
			_config = v;
			
			// Let the rest of the application know that the configuration data is
			// loaded.
			loaded.dispatch();
		}	
		
		public function get comfortLevel():Number 
		{
			return _comfortLevel;
		}
		
		public function set comfortLevel(value:Number):void 
		{
			_comfortLevel = value;
			comfort.dispatch();
		}
		
		public function get barMax():Number 
		{
			return _barMax;
		}
		
		public function set barMax(value:Number):void 
		{
			_barMax = value;
		}
		
		public function get targetUpdateSend():Boolean 
		{
			return _targetUpdateSend;
		}
		
		public function set targetUpdateSend(value:Boolean):void 
		{
			_targetUpdateSend = value;
		}
		
		public function get tInt():Number 
		{
			return _tInt;
		}
		
		public function set tInt(value:Number):void 
		{
			_tInt = value;
		}
		
		public function get dbconnected():Boolean 
		{
			return _dbconnected;
		}
		
		public function set dbconnected(value:Boolean):void 
		{
			_dbconnected = value;
		}
		
		public function get connected():Boolean 
		{
			return _connected;
		}
		
		public function set connected(value:Boolean):void 
		{
			_connected = value;
		}
		

		

		public function getMarkerUsageAverage(ec:EnergyComparison, category:String) : Number
		{
			var average:Number = new Number();
			
			for (var i:Number = 0; i < 7; i++)
			{
				var md:MarkerData = getDailyValue(i, category);
				var energy_value:Number = md.energyValue;
				average += energy_value;
			}
			average = Math.floor(average/7);
			return average;
		}
		
		
		public function getEnergyUsageAverage(ec:EnergyComparison) : Number
		{			
			var average:Number = new Number();
			
			for (var i:Number = 0; i < 7; i++)
			{
				var energy_value:Number = ec.weeklyEnergyConsumption[i].energy;
				average += energy_value;
			}
			average = Math.floor(average/7);
			return average;
		}
		
		public function getTargetsTotal():Number {
			var val:Number = sensorData.pcInstantaneousPowerValue.targetValue + sensorData.printerInstantaneousPowerValue.targetValue + sensorData.plugableInstantaneousPowerValue.targetValue;
			return val;
		}
		
		
		// The client wants this to be 10% higher than the highest value found in any of the bar charts data. Value sets top range for bar charts
		public function maxEnergyUsageValue() : Number
		{
			var currentMax:Number = 0;
			var pcUsageDays:Array = new Array();
			var printerUsageDays:Array = new Array();
			var pluggableUsageDays:Array = new Array();
			//should be number of days being recorded
			var len:Number = sensorData.rawData.pcEnergyComparison[0].energyConsumption.length;
			//pc energy for use, building, dept etc
			for (var i:Number = 0; i < sensorData.rawData.pcEnergyComparison.length; i++)	{
				//this should be user, dept,building etc
				pcUsageDays[i] = new Array();
				//loop through all the dates for each of these categories
				for (var j:Number = 0; j < len; j++)	{
					pcUsageDays[i].push(Number(sensorData.rawData.pcEnergyComparison[i].energyConsumption[j].energy));
				}
			}
			//printer energy for use, building, dept etc
			for (i = 0; i < sensorData.rawData.printerEnergyComparison.length; i++)	{
				//this should be user, dept,building etc
				printerUsageDays[i] = new Array();
				//loop through all the dates for each of these categories
				for (j = 0; j < len; j++)	{
					printerUsageDays[i].push(Number(sensorData.rawData.printerEnergyComparison[i].energyConsumption[j].energy));
				}
			}
			//pluggable energy for use, building, dept etc
			for (i = 0; i < sensorData.rawData.pluggableEnergyComparison.length; i++)	{
				//this should be user, dept,building etc
				pluggableUsageDays[i] = new Array();
				//loop through all the dates for each of these categories
				for (j = 0; j < len; j++)	{
					pluggableUsageDays[i].push(Number(sensorData.rawData.pluggableEnergyComparison[i].energyConsumption[j].energy));
				}
			}
			
			//loop through aggregate use for each day - pc,printer and pluggable
			//for each category - user, dept, building, floor...
			for (i = 0; i < pcUsageDays.length; i++)	{
				//get the aggregate use for that category for that day
				for (j = 0; j < len; j++)	{
					var agg:Number = pcUsageDays[i][j] + printerUsageDays[i][j] + pluggableUsageDays[i][j];
					//if it's more than currentMax, set currentMax to this value
					if (agg > currentMax) 
					{
						currentMax = agg;
					}
				}
			}
			//I think these two if statements will capture if the user's personal office target is actually the highest value in the chart data
			if (Number(sensorData.rawData.currentEnergyConsumption[3].office[5].targetValue) > currentMax)	{
				currentMax = Number(sensorData.rawData.currentEnergyConsumption[3].office[5].targetValue);
			}
			if (sensorData.officeIntantaneousPowerValue.targetValue >= currentMax)	{
				
				currentMax = sensorData.officeIntantaneousPowerValue.targetValue;
			}
			
			_barMax = currentMax;
			return currentMax * 1.1;
		}
		
		public function lookupDashboardStatusImageURL(status:String) : Array
		{
			var images:Array;
			
			switch(status)
			{
				case "fair":
				{
					images = [config.statusFairOnImageURL, config.statusFairOffImageURL];
					break;
				}
				case "good":
				{
					images = [config.statusGoodOnImageURL, config.statusGoodOffImageURL];
					break;
				}
				case "poor":
				{
					images = [config.statusPoorOnImageURL, config.statusPoorOffImageURL];
					break;
				}
			}
			
			return images;
		}
	
		public function lookupUsageStatusImageURL(status:String) : String
		{
			var imageURL:String = "";
			
			switch(status)
			{
				case "fair":
				{
					imageURL = this.config.usageStatusFairImageURL;
					break;
				}
				case "good":
				{
					imageURL = this.config.usageStatusGoodImageURL;
					break;
				}
				case "poor":
				{
					imageURL = this.config.usageStatusPoorImageURL;
					break;
				}
			}
			return imageURL;
		}
		
		//public function lookupDayOfWeekAbbr(date:Date) : String
		public function lookupDayOfWeekAbbr(index:Number) : String
		{
			var dayOfWeek:String = "";
			//switch(date.day)
			switch(index)
			{
				case 0: // Sunday
				{
					dayOfWeek = _labelManager.getLabel("c36");
					break;
				}
				case 1: // Monday
				{
					dayOfWeek = _labelManager.getLabel("c30");

					break;
				}
				case 2: // Tuesday
				{
					dayOfWeek = _labelManager.getLabel("c31");

					break;
				}
				case 3: // Wednesday
				{
					dayOfWeek = _labelManager.getLabel("c32");

					break;
				}
				case 4: // Thursday
				{
					dayOfWeek = _labelManager.getLabel("c33");

					break;
				}
				case 5: // Friday
				{
					dayOfWeek = _labelManager.getLabel("c34");

					break;
				}
				case 6: // Saturday
				{
					dayOfWeek = _labelManager.getLabel("c35");

					break;
				}
			}
			return dayOfWeek;
		}
		
		public function GetMarkerEnergyComparison() : Array
		{
			var result:Array;
			switch(this.appState.currentScreen)
			{
				case Screens.OFFICE:
				{
					result = this.sensorData.totalEnergyComparison;
					break;
				}
				case Screens.PCUSAGE:
				{
					result = this.sensorData.pcEnergyComparison;
					break;
				}
				case Screens.PRINTERUSAGE:
				{
					result = this.sensorData.printerEnergyComparison;
					break;
				}
				case Screens.PLUGGABLEUSAGE:
				{
					result = this.sensorData.pluggableEnergyComparison;
					break;
				}
			}
			return result;
		}
		
		public function GetEnergyConsumption() : Object
		{
			var result:Object;
			switch(this.appState.currentScreen)
			{
				case Screens.OFFICE:
				{
					result = this.sensorData.rawData.currentEnergyConsumption[3];
					break;
				}
				case Screens.PCUSAGE:
				{
					result = this.sensorData.rawData.currentEnergyConsumption[0];
					break;
				}
				case Screens.PRINTERUSAGE:
				{
					result = this.sensorData.rawData.currentEnergyConsumption[1];
					break;
				}
				case Screens.PLUGGABLEUSAGE:
				{
					result = this.sensorData.rawData.currentEnergyConsumption[2];
					break;
				}
				case Screens.EVUSAGE:
				{
					result = this.sensorData.rawData.currentEnergyConsumption[4];
					break;
				}
			}
			return result;
		}
		
		public function getEnergyComparison(category:String) : EnergyComparison
		{
			var ec:EnergyComparison = null; 
			switch(category)
			{
				case Screens.PCUSAGE:
				{
					ec = sensorData.pcEnergyComparison[0] as EnergyComparison;
					break;
				}
				case Screens.PRINTERUSAGE:
				{
					ec = sensorData.printerEnergyComparison[0] as EnergyComparison;
					break;
				}
				case Screens.PLUGGABLEUSAGE:
				{
					ec = sensorData.pluggableEnergyComparison[0] as EnergyComparison;
					break;
				}
				case Screens.OFFICE:
				{
					ec = sensorData.totalEnergyComparison[0] as EnergyComparison;
					break;
				}
			}
			return ec;
		}	
		
		public function getScaledValue(original_value:Number) : Number
		{
			var maxEnergyUsage:Number = this.maxEnergyUsageValue();
			var scaledValue:Number = original_value / maxEnergyUsage;	
			return scaledValue;
		}	
		
		public function getDailyValue(index:Number, category:String) : MarkerData
		{
			var data:MarkerData = new MarkerData();
			var ec:EnergyComparison;
			
			switch(category)
			{
				case "department":
				{
					ec = GetMarkerEnergyComparison()[1] as EnergyComparison;
					data.tooltip = _labelManager.getLabel("c25");
					break;
				}
				case "floor":
				{
					ec = GetMarkerEnergyComparison()[2] as EnergyComparison;
					data.tooltip = _labelManager.getLabel("c26");
					break;
				}
				case "building":
				{
					ec = GetMarkerEnergyComparison()[3] as EnergyComparison;
					data.tooltip = _labelManager.getLabel("c27");
					break;
				}					
					
			}
			
			var maxEnergyUsage:Number = this.maxEnergyUsageValue();
			var energy:Number = (ec.weeklyEnergyConsumption[index] as DailyEnergyConsumption).energy;
			var date:Date = (ec.weeklyEnergyConsumption[index] as DailyEnergyConsumption).date;
			data.energyValue = energy;
			data.dateValue = date;
			data.scaledValue =  energy / maxEnergyUsage;
			
			data.tooltip += " " + energy + " " +  ec.units;
			return data;
		}
	}
}
package com.poem.models 
{
	import com.poem.constants.EnergyCategory;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	 
	 
	public class PoemDataParser 
	{		
		public static function parse(v:Object) : PoemData
		{
			
			//trace('PARSING POEM DATA');
			
			var data:PoemData = new PoemData();
			data.rawData = v;
			data.indoorLight = v.indoorEnvironment[2].light + v.indoorEnvironment[2].unit;
			data.indoorRH = v.indoorEnvironment[1].humidity + v.indoorEnvironment[1].unit;
			data.indoorTemp = v.indoorEnvironment[0].temperature + v.indoorEnvironment[0].unit;
			data.outdoorRH = v.outdoorEnvironment[2].humidity + v.outdoorEnvironment[2].unit;
			data.outdoorTemp = v.outdoorEnvironment[1].temperature + v.outdoorEnvironment[1].unit;
			data.wind = v.outdoorEnvironment[3].windDirection + " " + v.outdoorEnvironment[3].windSpeed + v.outdoorEnvironment[3].unit;
			data.alertInformation = v.alerts[0].msg;
			data.alertMessage = v.alerts[1].msg;
			data.pcEnergyComparison = parsePCEnergyComparison(v);
			data.printerEnergyComparison = parsePrinterEnergyComparison(v);
			data.pluggableEnergyComparison = parsePluggableEnergyComparison(v);
			data.totalEnergyComparison = calculateTotalEnergyComparison(data.pcEnergyComparison, data.printerEnergyComparison, data.pluggableEnergyComparison);
			data.pcInstantaneousPowerValue = parseInstantaneousEnergyConsumption(EnergyCategory.PC, v.currentEnergyConsumption[0].pc);
			data.printerInstantaneousPowerValue = parseInstantaneousEnergyConsumption(EnergyCategory.PRINTER, v.currentEnergyConsumption[1].printer);
			data.plugableInstantaneousPowerValue = parseInstantaneousEnergyConsumption(EnergyCategory.PLUGABLE, v.currentEnergyConsumption[2].pluggable);
			data.officeIntantaneousPowerValue = parseInstantaneousEnergyConsumption(EnergyCategory.TOTAL, v.currentEnergyConsumption[3].office);
			data.officeTargetsVisible = (v.currentEnergyConsumption[3].office[6].targetValueEnabled == '1');
			data.pcTargetsVisible = (v.currentEnergyConsumption[0].pc[6].targetValueEnabled == '1');;
			data.printerTargetsVisible = (v.currentEnergyConsumption[1].printer[6].targetValueEnabled == '1');

			//Mark passing 1, so just setting to always false
			data.pluggableTargetsVisible = false;
			
			data.evTargetsVisible = (v.currentEnergyConsumption[4].ev[6].targetValueEnabled == '1');
			try 
			{
				data.notificationsDisabled = (v.alerts[2].msgDisabled == '1');
			} 
			catch (err:Error) 
			{
				
			}
			
			
			// TODO: Parse EV data
			data.evInstantaneousPowerValue = parseEV(v.currentEnergyConsumption[4].ev);
			
			// TODO: Parse Pluggables
			data.pluggables = parsePluggableDevices(v.pluggableEnergyComparison[0].devices);
			
			return data;
		}	
		
		public static function parseEV(v:Object) : InstantaneousEnergyConsumption
		{
			var data:InstantaneousEnergyConsumption = new InstantaneousEnergyConsumption();
			for each(var i:* in v)	{
				for (var propName:String in i) {
					data[propName] = i[propName];
				}
			}
			return data;
		}
		
		public static function parsePluggableDevices(v:Object) : Array
		{
			var pluggables:Array = new Array();
			
			for each(var o:Object in v)
			{
				var pd:PluggableDevice = new PluggableDevice();
				pd.name = o.deviceName;
				pd.average = o.average;
				
				// TODO: Need data for target
				pd.target = o.snapshot;
				pd.snapshot = o.snapshot;
				pd.unit = o.unit;
				pd.state = o.state;
				pd.switchable = o.switchable == "no" ? false : true;
				pluggables.push(pd);
			}
			
			return pluggables;
		}
		
		public static function calculateTotalEnergyComparison(pcEnergyComparison:Array, printerEnergyComparison:Array, plugableEnergyComparison:Array) : Array
		{
			var userPCEnergyComparison:EnergyComparison = pcEnergyComparison[0];
			var userPrinterEnergyComparison:EnergyComparison = printerEnergyComparison[0];
			var userPlugableEnergyComparison:EnergyComparison = plugableEnergyComparison[0];
				
			var userData:EnergyComparison = new EnergyComparison();
			userData.level = userPCEnergyComparison.level;
			userData.name = userPCEnergyComparison.name;
			userData.units = userPCEnergyComparison.units;
			userData.weeklyEnergyConsumption = new Array();
			
			for (var i:Number = 0; i < 7; i++)
			{				
				var dec:DailyEnergyConsumption = new DailyEnergyConsumption();
				dec.date = (userPCEnergyComparison.weeklyEnergyConsumption[i] as DailyEnergyConsumption).date;
				dec.energy = Math.floor(((userPCEnergyComparison.weeklyEnergyConsumption[i] as DailyEnergyConsumption).energy + (userPrinterEnergyComparison.weeklyEnergyConsumption[i] as DailyEnergyConsumption).energy + (userPlugableEnergyComparison.weeklyEnergyConsumption[i] as DailyEnergyConsumption).energy));
				userData.weeklyEnergyConsumption.push(dec);
			}	
			
			var departmentPCEnergyComparison:EnergyComparison = pcEnergyComparison[1];
			var departmentPrinterEnergyComparison:EnergyComparison = printerEnergyComparison[1];
			var departmentPlugableEnergyComparison:EnergyComparison = plugableEnergyComparison[1];
				
			var departmentData:EnergyComparison = new EnergyComparison();
			departmentData.level = departmentPCEnergyComparison.level;
			departmentData.name = departmentPCEnergyComparison.name;
			departmentData.units = departmentPCEnergyComparison.units;
			departmentData.weeklyEnergyConsumption = new Array();
			
			for (i = 0; i < 7; i++)
			{				
				var dec2:DailyEnergyConsumption = new DailyEnergyConsumption();
				dec2.date = (departmentPCEnergyComparison.weeklyEnergyConsumption[i] as DailyEnergyConsumption).date;
				dec2.energy = Math.floor(((departmentPCEnergyComparison.weeklyEnergyConsumption[i] as DailyEnergyConsumption).energy + (departmentPrinterEnergyComparison.weeklyEnergyConsumption[i] as DailyEnergyConsumption).energy + (departmentPlugableEnergyComparison.weeklyEnergyConsumption[i] as DailyEnergyConsumption).energy));
				departmentData.weeklyEnergyConsumption.push(dec2);
			}
			
			var floorPCEnergyComparison:EnergyComparison = pcEnergyComparison[2];
			var floorPrinterEnergyComparison:EnergyComparison = printerEnergyComparison[2];
			var floorPlugableEnergyComparison:EnergyComparison = plugableEnergyComparison[2];
				
			var floorData:EnergyComparison = new EnergyComparison();
			floorData.level = floorPCEnergyComparison.level;
			floorData.name = floorPCEnergyComparison.name;
			floorData.units = floorPCEnergyComparison.units;
			floorData.weeklyEnergyConsumption = new Array();
			
			for (i = 0; i < 7; i++)
			{				
				var dec3:DailyEnergyConsumption = new DailyEnergyConsumption();
				dec3.date = (floorPCEnergyComparison.weeklyEnergyConsumption[i] as DailyEnergyConsumption).date;
				dec3.energy = Math.floor(((floorPCEnergyComparison.weeklyEnergyConsumption[i] as DailyEnergyConsumption).energy + (floorPrinterEnergyComparison.weeklyEnergyConsumption[i] as DailyEnergyConsumption).energy + (floorPlugableEnergyComparison.weeklyEnergyConsumption[i] as DailyEnergyConsumption).energy));
				floorData.weeklyEnergyConsumption.push(dec3);
			}
			
			var buildingPCEnergyComparison:EnergyComparison = pcEnergyComparison[3];
			var buildingPrinterEnergyComparison:EnergyComparison = printerEnergyComparison[3];
			var buildingPlugableEnergyComparison:EnergyComparison = plugableEnergyComparison[3];
			
			var buildingData:EnergyComparison = new EnergyComparison();
			buildingData.level = buildingPCEnergyComparison.level;
			buildingData.name = buildingPCEnergyComparison.name;
			buildingData.units = buildingPCEnergyComparison.units;
			buildingData.weeklyEnergyConsumption = new Array();
			
			for (i = 0; i < 7; i++)
			{				
				var dec4:DailyEnergyConsumption = new DailyEnergyConsumption();
				dec4.date = (buildingPCEnergyComparison.weeklyEnergyConsumption[i] as DailyEnergyConsumption).date;
				dec4.energy = Math.floor(((buildingPCEnergyComparison.weeklyEnergyConsumption[i] as DailyEnergyConsumption).energy + (buildingPrinterEnergyComparison.weeklyEnergyConsumption[i] as DailyEnergyConsumption).energy + (buildingPlugableEnergyComparison.weeklyEnergyConsumption[i] as DailyEnergyConsumption).energy));
				buildingData.weeklyEnergyConsumption.push(dec4);
			}
			
			var data:Array = new Array();
			data.push(userData);
			data.push(departmentData);
			data.push(floorData);
			data.push(buildingData);
			return data;
		}
		
		public static function parseInstantaneousEnergyConsumption(category:String, v:Object) : InstantaneousEnergyConsumption
		{
			
			var data:InstantaneousEnergyConsumption = new InstantaneousEnergyConsumption();
			for each(var i:* in v)	{
				for (var propName:String in i) {
					data[propName] = i[propName];
				}
			}
			return data;
		}
		
		private static function parsePCEnergyComparison(v:Object) : Array
		{
			var data:Array = new Array();
			data.push(parseEnergyComparison(v.pcEnergyComparison[0]));
			data.push(parseEnergyComparison(v.pcEnergyComparison[1]));
			data.push(parseEnergyComparison(v.pcEnergyComparison[2]));
			data.push(parseEnergyComparison(v.pcEnergyComparison[3]));
			return data;
		}
		
		private static function parsePrinterEnergyComparison(v:Object) : Array
		{
			var data:Array = new Array();
			data.push(parseEnergyComparison(v.printerEnergyComparison[0]));
			data.push(parseEnergyComparison(v.printerEnergyComparison[1]));
			data.push(parseEnergyComparison(v.printerEnergyComparison[2]));
			data.push(parseEnergyComparison(v.printerEnergyComparison[3]));
			return data;
		}
		
		private static function parsePluggableEnergyComparison(v:Object) : Array
		{
			var data:Array = new Array();
			data.push(parseEnergyComparison(v.pluggableEnergyComparison[0]));
			data.push(parseEnergyComparison(v.pluggableEnergyComparison[1]));
			data.push(parseEnergyComparison(v.pluggableEnergyComparison[2]));
			data.push(parseEnergyComparison(v.pluggableEnergyComparison[3]));
			return data;
		}
		
		private static function parseEnergyComparison(v:Object) : EnergyComparison
		{
			var data:EnergyComparison = new EnergyComparison();
			data.level = v.level;
			data.name = v.name;
			data.units = v.unit;
			data.weeklyEnergyConsumption = parseWeeklyUsage(v.energyConsumption);
			return data;
		}
		
		private static function parseWeeklyUsage(v:Array) : Array
		{
			var data:Array = new Array();
			for (var i:Number = 0; i < v.length; i++)
			{
				var dec:DailyEnergyConsumption = new DailyEnergyConsumption();
				dec.date = new Date(Date.parse(v[i].date));
				dec.energy = v[i].energy;
				data.push(dec);
			}
			return data;
		}
	}

}
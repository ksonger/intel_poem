package com.poem.models 
{
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class PoemData
	{
		private var _rawData:Object;		
		private var _pcEnergyComparison:Array = new Array();
		private var _printerEnergyComparison:Array = new Array();
		private var _pluggableEnergyComparison:Array = new Array();
		private var _totalEnergyComparison:Array = new Array();
		private var _pcInstantaneousPowerValue:InstantaneousEnergyConsumption;
		private var _printerInstantaneousPowerValue:InstantaneousEnergyConsumption;
		private var _plugableInstantaneousPowerValue:InstantaneousEnergyConsumption;
		private var _officeIntantaneousPowerValue:InstantaneousEnergyConsumption;
		private var _evInstantaneousPowerValue:InstantaneousEnergyConsumption;
		private var _indoorLight:String;
		private var _indoorRH:String;
		private var _indoorTemp:String;
		private var _outdoorRH:String;
		private var _outdoorTemp:String;
		private var _wind:String;
		private var _alertInformation:String;
		private var _alertMessage:String;
		private var _pluggables:Array = new Array();
		
		private var _currentPCTarget:Number;
		private var _currentPrinterTarget:Number;
		private var _currentPluggableTarget:Number;
		
		private var _officeTargetsVisible:Boolean;
		private var _pcTargetsVisible:Boolean;
		private var _printerTargetsVisible:Boolean;
		private var _pluggableTargetsVisible:Boolean;
		private var _evTargetsVisible:Boolean;
		
		private var _notificationsDisabled:Boolean;
		
		private var _alerts:Array;
		
		public function get pluggables() : Array
		{
			return _pluggables;
		}
		
		public function set pluggables(v:Array) : void
		{
			_pluggables = v;
		}
		
		public function get evInstantaneousPowerValue() : InstantaneousEnergyConsumption
		{
			return _evInstantaneousPowerValue;
		}
		
		public function set evInstantaneousPowerValue(v:InstantaneousEnergyConsumption) : void
		{
			_evInstantaneousPowerValue = v;
		}
		
		public function get officeIntantaneousPowerValue() : InstantaneousEnergyConsumption
		{
			return _officeIntantaneousPowerValue;
		}
		
		public function set officeIntantaneousPowerValue(v:InstantaneousEnergyConsumption) : void
		{
			_officeIntantaneousPowerValue = v;
		}
		
		public function get pcInstantaneousPowerValue() : InstantaneousEnergyConsumption
		{
			return _pcInstantaneousPowerValue;
		}
		
		public function set pcInstantaneousPowerValue(v:InstantaneousEnergyConsumption) : void
		{
			_pcInstantaneousPowerValue = v;
		}
		
		public function get printerInstantaneousPowerValue() : InstantaneousEnergyConsumption
		{
			return _printerInstantaneousPowerValue;
		}
		
		public function set printerInstantaneousPowerValue(v:InstantaneousEnergyConsumption) : void
		{
			_printerInstantaneousPowerValue = v;
		}
		
		public function get plugableInstantaneousPowerValue() : InstantaneousEnergyConsumption
		{
			return _plugableInstantaneousPowerValue;
		}
		
		public function set plugableInstantaneousPowerValue(v:InstantaneousEnergyConsumption) : void
		{
			_plugableInstantaneousPowerValue = v;
		}
		
		public function get rawData() : Object
		{
			return _rawData;
		}
		
		public function set rawData(v:Object) : void
		{
			_rawData = v;
		}
		
		public function get pcEnergyComparison() : Array
		{
			return _pcEnergyComparison;
		}
		
		public function set pcEnergyComparison(v:Array) : void
		{
			_pcEnergyComparison = v;
		}
		
		public function get printerEnergyComparison() : Array
		{
			return _printerEnergyComparison;
		}
		
		public function set printerEnergyComparison(v:Array) : void
		{
			_printerEnergyComparison = v;
		}
		
		public function get pluggableEnergyComparison() : Array
		{
			return _pluggableEnergyComparison;
		}
		
		public function set pluggableEnergyComparison(v:Array) : void
		{
			_pluggableEnergyComparison = v;
		}
		
		public function get totalEnergyComparison() : Array
		{
			return _totalEnergyComparison;
		}
		
		public function set totalEnergyComparison(v:Array) : void
		{
			_totalEnergyComparison = v;
		}
		
		public function get indoorTemp() : String
		{
			return _indoorTemp;
		}
		
		public function set indoorTemp(v:String) : void
		{
			_indoorTemp = v;
		}
		
		public function get indoorRH() : String
		{
			return _indoorRH;
		}
		
		public function set indoorRH(v:String) : void
		{
			_indoorRH = v;
		}
		
		public function get indoorLight() : String
		{
			return _indoorLight;
		}
		
		public function set indoorLight(v:String) : void
		{
			_indoorLight = v;
		}
		
		public function get outdoorTemp() : String
		{
			return _outdoorTemp;
		}
		
		public function set outdoorTemp(v:String) : void
		{
			_outdoorTemp = v;
		}
		
		public function get outdoorRH() : String
		{
			return _outdoorRH;
		}
		
		public function set outdoorRH(v:String) : void
		{
			_outdoorRH = v;
		}
		
		public function get wind() : String
		{
			return _wind;
		}
		
		public function set wind(v:String) : void
		{
			_wind = v;
		}
		
		public function get alertInformation() : String
		{
			return _alertInformation;
		}
		
		public function set alertInformation(v:String) : void
		{
			_alertInformation = v;
		}

		public function get alertMessage() : String
		{
			return _alertMessage;
		}
		
		public function set alertMessage(v:String) : void
		{
			_alertMessage = v;
		}		
		
		public function get targetValue() : String
		{
			return rawData.currentEnergyConsumption[3].targetValue;
		}
		
		public function get currentPCTarget():Number 
		{
			return _currentPCTarget;
		}
		
		public function set currentPCTarget(value:Number):void 
		{
			_currentPCTarget = value;
		}
		
		public function get currentPrinterTarget():Number 
		{
			return _currentPrinterTarget;
		}
		
		public function set currentPrinterTarget(value:Number):void 
		{
			_currentPrinterTarget = value;
		}
		
		public function get currentPluggableTarget():Number 
		{
			return _currentPluggableTarget;
		}
		
		public function set currentPluggableTarget(value:Number):void 
		{
			_currentPluggableTarget = value;
		}
		
		public function get officeTargetsVisible():Boolean 
		{
			return _officeTargetsVisible;
		}
		
		public function set officeTargetsVisible(value:Boolean):void 
		{
			_officeTargetsVisible = value;
		}
		
		public function get pcTargetsVisible():Boolean 
		{
			return _pcTargetsVisible;
		}
		
		public function set pcTargetsVisible(value:Boolean):void 
		{
			_pcTargetsVisible = value;
		}
		
		public function get printerTargetsVisible():Boolean 
		{
			return _printerTargetsVisible;
		}
		
		public function set printerTargetsVisible(value:Boolean):void 
		{
			_printerTargetsVisible = value;
		}
		
		public function get pluggableTargetsVisible():Boolean 
		{
			return _pluggableTargetsVisible;
		}
		
		public function set pluggableTargetsVisible(value:Boolean):void 
		{
			_pluggableTargetsVisible = value;
		}
		
		public function get alerts():Array 
		{
			return _alerts;
		}
		
		public function set alerts(value:Array):void 
		{
			_alerts = value;
		}
		
		
		public function get evTargetsVisible():Boolean 
		{
			return _evTargetsVisible;
		}
		
		public function set evTargetsVisible(value:Boolean):void 
		{
			_evTargetsVisible = value;
		}
		
		public function get notificationsDisabled():Boolean 
		{
			return _notificationsDisabled;
		}
		
		public function set notificationsDisabled(value:Boolean):void 
		{
			_notificationsDisabled = value;
		}
	}
}
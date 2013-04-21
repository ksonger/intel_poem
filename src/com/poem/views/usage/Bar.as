package com.poem.views.usage 
{
	import com.greensock.TweenMax;
	import com.poem.constants.TextStyles;
	import com.poem.helpers.TextFieldHelper;
	import com.poem.interfaces.IDisposable;
	import com.poem.interfaces.IInitializable;
	import com.poem.models.DailyEnergyConsumption;
	import com.poem.models.EnergyComparison;
	import com.poem.models.PoemModel;
	import com.poem.signals.UpdateUsageScreenSignal;
	
	import flash.display.CapsStyle;
	import flash.display.GradientType;
	import flash.display.LineScaleMode;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class Bar extends Sprite implements IDisposable, IInitializable
	{
		private var barShape:Sprite = new Sprite();
		private var chartHeight:Number;
		private var dec:DailyEnergyConsumption;
		private var scaledHeight:Number;
		private var label_txt:String;
		private var label:TextField = new TextField();
		private var index:Number;
		private var maxEnergyValue:Number;
		private var average:Boolean;
		private var cap:Loader;
		
		[Inject]
		public var model:PoemModel;
		
		[Inject]
		public var updateScreen:UpdateUsageScreenSignal;
		
		public function Bar(x:Number, chartHeight:Number, maxEnergyValue:Number, label_txt:String, average:Boolean, index:Number = Number.NaN) 
		{	
			this.x = x;
			this.index = index;
			this.maxEnergyValue = maxEnergyValue;
			this.chartHeight = chartHeight;
			this.label_txt = label_txt;
			this.average = average;
		}
		
		public function initialize() : void
		{
			
			updateScreen.add(updateScreenHandler);
			
			getDailyEnergyConsumption();
			createGradientBackground();
			createCap();
			createEnergyValueLabel();
			
			updateScreenHandler();
		}

		private function getDailyEnergyConsumption() : void
		{
			var ec:EnergyComparison = model.getEnergyComparison(model.appState.currentScreen);
			if (average == false){ 
				dec = ec.weeklyEnergyConsumption[index];
			} else {
				dec = new DailyEnergyConsumption();
				dec.energy = model.getEnergyUsageAverage(ec);				
			}	
			
			scaledHeight = Math.floor(chartHeight * (dec.energy / maxEnergyValue));
		}
		
		private function updateScreenHandler() : void
		{
			getDailyEnergyConsumption();
			createEnergyValue();
			var barheight:Number = chartHeight * (dec.energy / model.barMax);
			TweenMax.to(barShape, .5, { y:1 + Math.round(cap.y - barheight), scaleY:(dec.energy / model.barMax)} );
		}	
		
		public function dispose() : void
		{
			
			while (numChildren > 0) removeChildAt(0);
			
			updateScreen.remove(updateScreenHandler);
			
			barShape = null;
			dec = null;
			model = null;
		}
				
		private function createCap() : void
		{
			cap = new Loader();
			cap.load( new URLRequest(model.config.barChartCapImageURL) );	
			cap.x = 0;
			cap.y = chartHeight + 20;
			addChild(cap);
		}		
		
		private function createEnergyValueLabel() : void
		{
			if (average == false) var label_txt:String = model.lookupDayOfWeekAbbr(index);
			var day:TextField = TextFieldHelper.createTextField(0, 200, 40, label_txt, "day_of_week", TextStyles.USAGE_BAR_VALUE, TextFieldAutoSize.CENTER);
			addChild(day);			
		}
		
		private function createEnergyValue() : void
		{
			if (this.contains(label)) removeChild(label);
			label = TextFieldHelper.createTextField(0, 176, 40, dec.energy.toString(), "energy_value_label", TextStyles.USAGE_BAR_VALUE, TextFieldAutoSize.CENTER);
			addChild(label);			
		}		
		
		private function createGradientBackground() : void
		{
			var fillType:String = GradientType.LINEAR;
			var colors:Array = [0xd0f5f3, 0xa2e8f4];
			var alphas:Array = [1, 1];
			var ratios:Array = [0x00, 0xFF];
			var matr:Matrix = new Matrix();
			matr.createGradientBox(120, 120, 180, 0, 0);
			var spreadMethod:String = SpreadMethod.PAD;
			with (barShape.graphics)	{
				beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);  
				lineStyle(.1, 0x96be9f, 1, false, LineScaleMode.NONE, CapsStyle.SQUARE);
				drawRect(0, 0, 39, chartHeight);
				drawRect(0, 0, 39, 1);
			}
			barShape.y = chartHeight + 20;
			addChild(barShape);
		}
	}
}
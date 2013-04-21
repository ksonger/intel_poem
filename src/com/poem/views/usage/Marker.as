package com.poem.views.usage
{
	
	import com.greensock.TweenMax;
	import com.poem.helpers.MarkerToolTipHelper;
	import com.poem.models.EnergyComparison;
	import com.poem.models.MarkerData;
	import com.poem.models.PoemModel;
	import com.poem.signals.AddMarkerToolTipSignal;
	import com.poem.signals.RemoveMarkerToolTipSignal;
	import com.poem.signals.UpdateUsageScreenSignal;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Marker extends Sprite
	{
		
		[Inject]
		public var model:PoemModel;
		
		[Inject]
		public var addMarkerToolTipSignal:AddMarkerToolTipSignal;
		
		[Inject]
		public var removeMarkerToolTipSignal:RemoveMarkerToolTipSignal;	
		
		[Inject]
		public var updateScreen:UpdateUsageScreenSignal;		
		
		public var index:uint;
		public var category:String;
		public var top_category:String;
		public var color:Number;
		private var mark:Sprite;
		private var maxEnergyValue:Number;
		private var x_position:Number;
		private var average:Boolean;
		
		private var toolTip:MarkerToolTipHelper;
		private var md:MarkerData;
		private var chartHeight:Number;

		public function Marker(x_position:Number, chartHeight:Number, maxEnergyValue:Number, color:Number, top_category:String, category:String, average:Boolean, day:Number = Number.NaN) 
		{

			this.color = color;
			this.x_position = x_position;
			this.chartHeight = chartHeight;
			this.index = day;
			this.average = average;
			this.maxEnergyValue = maxEnergyValue;
			this.category = category;
			this.top_category = top_category;
		}
		
		public function initialize() : void
		{
			updateScreen.add(updateScreenHandler);
			
			//SET CIRCLE
			mark = new Sprite();
			mark.graphics.beginFill(color);
			mark.graphics.drawCircle(0, 2, 4);
			
			var hitarea:Sprite = new Sprite();
			hitarea.graphics.beginFill(0x17776f, 1);  
			hitarea.graphics.drawRect(-8, -8, 15, 15);
			
			//HITAREA
			mark.addChild(hitarea);	
			mark.hitArea = hitarea;
			hitarea.alpha = 0;				
			
			//SET X
			mark.x = x_position;
			
			//PROPS
			buttonMode = true;
			useHandCursor = true;
			mouseChildren = false;
			
			//ADD CHILD
			addChild(mark);
			
			updateScreenHandler();
		}
		
		public function dispose() : void
		{
			while (numChildren > 0)
				removeChildAt(0);
			
			updateScreen.remove(updateScreenHandler);
			model = null;
		}
		
		private function getDailyValue() : void
		{
			if (average == false){
				md = model.getDailyValue(index, category);	
			} else {
				var ec:EnergyComparison = model.getEnergyComparison(top_category);
				var department_energy_average:Number = model.getMarkerUsageAverage(ec, category);
				md = new MarkerData();
				md.energyValue = department_energy_average;
				
				md.scaledValue = model.getScaledValue(department_energy_average);
				var label_txt:String; 
				switch ( category){
					case "department":
						label_txt = model.labelManager.getLabel("c25");
					break;
					case "building":
						label_txt = model.labelManager.getLabel("c26");
					break;
					case "floor":
						label_txt = model.labelManager.getLabel("c27");
					break;					
				}
				
				md.tooltip = label_txt + ' ' + department_energy_average + ' ' + ec.units;
			}
		}		
		
		private function updateScreenHandler() : void
		{	
			getDailyValue();
			//SET Y
			var new_y:Number;
			new_y = (1 - (md.energyValue / model.barMax)) * chartHeight;		
			TweenMax.to(mark, .5, { y:new_y} );
		}			
		
		public function rollOver() : void
		{
			addMarkerToolTipSignal.dispatch(md);
		}
		
		public function rollOut() : void
		{
			removeMarkerToolTipSignal.dispatch();	
		}

	}
}
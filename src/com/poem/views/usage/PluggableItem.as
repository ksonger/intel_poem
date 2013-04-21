package com.poem.views.usage 
{
	import com.greensock.TweenMax;
	import com.poem.constants.TextStyles;
	import com.poem.helpers.TextFieldHelper;
	import com.poem.helpers.ToolTipHelper;
	import com.poem.interfaces.IDisposable;
	import com.poem.interfaces.IInitializable;
	import com.poem.models.DailyEnergyConsumption;
	import com.poem.models.EnergyComparison;
	import com.poem.models.PoemModel;
	
	import flash.display.CapsStyle;
	import flash.display.GradientType;
	import flash.display.JointStyle;
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
	public class PluggableItem extends Sprite implements IDisposable, IInitializable
	{

		[Inject]
		public var model:PoemModel;
		
		private var image_url:String;
		private var index:Number;
		private var toggle_state:String;
		
		private var on_line:Sprite;
		private var off_circle:Sprite;
		
		private var toolTip:ToolTipHelper;
		
		private var toggle_handle:Loader = new Loader();
		private var toggle_background:Loader = new Loader();
		
		public function PluggableItem(image_url:String, index:Number) 
		{
			this.image_url = image_url;
			this.index = index;
		}
		
		public function initialize() : void
		{
			createIcon();
			createToggle();
			createLabels();
			checkState();
		}
		
		public function dispose() : void
		{
			while (numChildren > 0)
				removeChildAt(0);
			model = null;
		}

		public function rollOver() : void
		{
			var name:String = model.sensorData.pluggables[index].name;
			var snapshot:Number = model.sensorData.pluggables[index].snapshot;
			var target:Number = model.sensorData.pluggables[index].target;
			var average:Number = model.sensorData.pluggables[index].average;
			var unit:String = model.sensorData.pluggables[index].unit;
			
			toolTip = new ToolTipHelper(name, snapshot, target, average, unit);
			toolTip.x = 30;
			toolTip.y = 45;
			
			toolTip.alpha = 0;
			TweenMax.to(toolTip, .25, {alpha:1, delay:.15} );			
			addChild(toolTip);
		}
		
		public function rollOut() : void
		{
			removeChild(toolTip);
		}		
		
		public function click() : void
		{
			
			if (model.sensorData.pluggables[index].switchable == false) return;
			
			if (toggle_state == "off"){ 
				TweenMax.to(toggle_background, .25, {colorTransform:{tint:0x8a8c8e, tintAmount:1}});
				toggle_handle.x = 36;	
				toggle_state = "on";
				on_line.alpha = 1;
				off_circle.alpha = 0;
			} else {
				TweenMax.to(toggle_background, .25, {colorTransform:{tint:0x8a8c8e, tintAmount:0}});
				toggle_handle.x = 8;
				toggle_state = "off";
				on_line.alpha = 0;
				off_circle.alpha = 1;
			}	
				
		}	
		
		private function createLabels() : void
		{
			
			var label_txt:String = model.sensorData.pluggables[index].snapshot + model.sensorData.pluggables[index].unit;
			var label:TextField = TextFieldHelper.createTextField(8, 6, 55, label_txt, "LABEL", TextStyles.USAGE_PLUGGABLE, TextFieldAutoSize.CENTER);
			
			addChild(label);
		}		

		private function checkState() : void
		{
			toggle_state = model.sensorData.pluggables[index].state;
			click();
		}
		
		private function createIcon() : void
		{
			var icon:Loader = new Loader();
			icon.load(new URLRequest(image_url));
			icon.x = 5;
			icon.y = 25;
			
			addChild(icon);
		}	
		
		private function createToggle() : void
		{

			toggle_handle.load(new URLRequest(model.config.usagePluggableToggleHandleImageURL));
			toggle_handle.x = 8;
			toggle_handle.y = 74;
			
			toggle_background.load(new URLRequest(model.config.usagePluggableToggleBackgroundImageURL));
			toggle_background.x = 5;
			toggle_background.y = 70;
						
			on_line = new Sprite();
			on_line.graphics.lineStyle(3, 0xa7a9ac, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 10);
			on_line.graphics.moveTo(22, 77);
			on_line.graphics.lineTo(22, 90);
			
			off_circle = new Sprite();
			off_circle.graphics.lineStyle(3, 0xa7a9ac, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 10);
			off_circle.graphics.drawCircle(45, 84, 6);
			off_circle.graphics.endFill();
			
			addChild(toggle_background);
			
			if (model.sensorData.pluggables[index].switchable == false){
				toggle_background.alpha = .5;
				return;
			} 
			
			addChild(toggle_handle);
			addChild(on_line);
			addChild(off_circle);
		}		

	}
}
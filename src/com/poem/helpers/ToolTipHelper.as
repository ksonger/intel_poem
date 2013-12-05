package com.poem.helpers
{
	import com.greensock.TweenMax;
	import com.poem.constants.TextStyles;
	import com.poem.helpers.TextFieldHelper;
	import com.poem.models.PoemModel;
	
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.sampler.Sample;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class ToolTipHelper extends Sprite
	{
		
		[Inject]
		public var model:PoemModel;		
		
		private var label:String;
		private var unit:String;
		private var snapshot:Number;
		private var target:Number;
		private var average:Number;
		private var box_width:Number;
		private var box_height:Number;
		
		private var container:Sprite = new Sprite();
		
		public function ToolTipHelper(label:String, snapshot:Number, target:Number, average:Number, unit:String):void
		{
			this.label = label;
			this.unit = unit;
			this.snapshot = snapshot;
			this.target = target;
			this.average = average;
		}
		
		public function initialize() : void
		{
			create_container();
		}
		
		public function dispose() : void
		{
			while (numChildren > 0) removeChildAt(0);
			model = null;
		}		
		
		private function create_container():void{
			
			var bg:Shape = new Shape();
			bg.graphics.beginFill(0x17776f, 1);
			bg.graphics.drawRoundRect(0, 0, 105, 40, 10);
			bg.graphics.lineStyle(10, 0xFFFFFF, 1, false, LineScaleMode.NONE, CapsStyle.SQUARE);
			bg.graphics.endFill();
			
			TweenMax.to(bg, .1, {dropShadowFilter:{color:0x000000, alpha:.2, blurX:2, blurY:2, angle:0, distance:3}});
			
			var name_txt:String = label.toUpperCase();

			var average_txt:String = model.labelManager.getLabel("c11");
			
			average_txt = average_txt.toUpperCase() + " : " + average + unit;
			
			var name_tf:TextField = TextFieldHelper.createTextField(5, 2, 50, name_txt, "TEMP", TextStyles.USAGE_PLUGGABLE_TOOLTIP_HEADER, TextFieldAutoSize.LEFT);
			var average_tf:TextField = TextFieldHelper.createTextField(5, 13, 50, average_txt, "TEMP", TextStyles.USAGE_PLUGGABLE_TOOLTIP, TextFieldAutoSize.LEFT);

			container.addChild(bg);
			container.addChild(name_tf);
			container.addChild(average_tf);
			addChild(container);
		}
		
			
		
	}
}
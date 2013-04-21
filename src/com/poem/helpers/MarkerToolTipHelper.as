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
	
	public class MarkerToolTipHelper extends Sprite
	{
		
		[Inject]
		public var model:PoemModel;		
		
		private var label:String;
		
		private var container:Sprite = new Sprite();
		
		public function MarkerToolTipHelper(label:String):void
		{
			this.label = label;
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

			var name_tf:TextField = TextFieldHelper.createTextField(5, 2, 50, label, "TEMP", TextStyles.USAGE_PLUGGABLE_TOOLTIP, TextFieldAutoSize.LEFT);
			var text_width:Number = name_tf.textWidth;
			
			var bg:Shape = new Shape();
			bg.graphics.beginFill(0x17776f, 1);
			bg.graphics.drawRoundRect(0, 0, text_width+15, 20, 10);
			bg.graphics.lineStyle(10, 0xFFFFFF, 1, false, LineScaleMode.NONE, CapsStyle.SQUARE);
			bg.graphics.endFill();
			
			TweenMax.to(bg, .1, {dropShadowFilter:{color:0x000000, alpha:.2, blurX:2, blurY:2, angle:0, distance:3}});
			
			container.addChild(bg);
			container.addChild(name_tf);
			addChild(container);
		}
		
			
		
	}
}
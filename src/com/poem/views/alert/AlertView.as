package com.poem.views.alert
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.poem.signals.LoadDataSignal;
	import com.poem.constants.TextStyles;
	import com.poem.interfaces.IDisposable;
	import com.poem.interfaces.IInitializable;
	import com.poem.helpers.TextFieldHelper;
	import com.poem.models.PoemModel;
	
	import flash.display.CapsStyle;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author Ken Songer and Erik Falat
	 */
	public class AlertView extends Sprite implements IDisposable, IInitializable
	{		
		[Inject]
		public var model:PoemModel;
		
		[Inject]
		public var loadData:LoadDataSignal;			
		
		public var header:TextField;
		public var alert_text:TextField;
		
		public var background:Sprite;
		public var mask_clip:Sprite;
		public var rule_wh:Sprite;
		public var rule_gry:Sprite;	
		
		public var icon:Loader;
		
		public var container:Sprite;
		
		public function initialize() : void
		{
			
			loadData.add(loadDataSignalHandler);
			
			createBackground();
			createAmbientValues();	
			createIcon();
			addToStage();
			animate();
		}
		
		public function dispose() : void
		{
			while (numChildren > 0)
				removeChildAt(0);
			
			loadData.remove(loadDataSignalHandler);	
			
			model = null;
		}
		
		public function update() : void
		{
			
			if (!model.sensorData.notificationsDisabled) 
			{
				var alert_txt:String = model.sensorData.alertInformation;
				container.removeChild(alert_text);
				alert_text = null;
				var alert_text_new:TextField = TextFieldHelper.createTextField(47, 40, 310, alert_txt, "ALERTTEXT", TextStyles.ALERT_VALUE, TextFieldAutoSize.LEFT, false, true);
				alert_text = alert_text_new;
				container.addChild(alert_text);
			}
		}			

		public function createAmbientValues() : void
		{
			var header_txt:String = model.labelManager.getLabel("c37");
			header_txt = header_txt.toUpperCase();
			
			var alert_txt:String = model.sensorData.alertInformation;
			
			header = TextFieldHelper.createTextField(8, 13, 150, header_txt, "ALERTS", TextStyles.ALERT_HEADER, TextFieldAutoSize.LEFT);
			alert_text = TextFieldHelper.createTextField(47, 40, 310, alert_txt, "ALERTTEXT", TextStyles.ALERT_VALUE, TextFieldAutoSize.LEFT, false, true);			
		}
		
		private function loadDataSignalHandler() : void
		{
			container.removeChild(icon);
			createIcon();
			container.addChild(icon);
		}	
		
		
		private function addToStage() : void
		{
			container = new Sprite();
			
			container.addChild(background);	
			container.addChild(rule_wh);
			container.addChild(rule_gry);
			container.addChild(icon);
			
			container.addChild(alert_text);
			container.addChild(header);
			
			addChild(container);
			addChild(mask_clip);
			container.mask = mask_clip;
		}	
		
		private function animate() : void
		{
			TweenMax.fromTo(container, 1, {y:-80}, {y:12, ease:Expo.easeOut});
		}		
		
		private function createIcon() : void
		{
			
			var status:String = model.sensorData.officeIntantaneousPowerValue.status;

			var path:String;
			switch (status){
				case "good":
					path = model.config.aboveTarget48;				
					break;
				case "bad":
					path = model.config.belowTarget48;					
					break;
				case "neutral":
					path = model.config.onTarget48;						
					break;
			}
			
			icon = new Loader();
			icon.load(new URLRequest(path));
			icon.x = 0;
			icon.y = 37;			
			
		}		
		
		// TODO:  Need to change this graphic to TextFields.
		private function createBackground() : void
		{
			rule_wh = new Sprite();
			rule_wh.graphics.lineStyle(1, 0xFFFFFF, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 10);
			rule_wh.graphics.moveTo(10, 32);
			rule_wh.graphics.lineTo(350, 32);			
			
			rule_gry = new Sprite();
			rule_gry.graphics.lineStyle(1, 0xCCCCCC, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 10);
			rule_gry.graphics.moveTo(10, 33);
			rule_gry.graphics.lineTo(350, 33);					
			
			background = new Sprite();
			background.graphics.lineStyle(1, 0xCCCCCC, 1, true, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 10);
			var fillType:String = GradientType.LINEAR;
			var colors:Array = [0xd8f7f5, 0xFFFFFF];
			var alphas:Array = [.9, .9];
			var ratios:Array = [0, 255];
			var matr:Matrix = new Matrix();
			matr.createGradientBox(372, 82, 90, 0, 0);
			var spreadMethod:String = SpreadMethod.PAD;				
			background.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);	
			background.graphics.drawRoundRect(0, 0, 370, 88, 25);
			background.graphics.endFill();		
			
			mask_clip = new Sprite();
			mask_clip.graphics.beginFill(0xFF0000, .4);		
			mask_clip.graphics.drawRect(0, 21, 372, 82);			
		}
	}
}
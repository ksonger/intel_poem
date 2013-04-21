package com.poem.views.ambient 
{
	import com.poem.interfaces.IDisposable;
	import com.poem.interfaces.IInitializable;
	import com.poem.interfaces.IUpdateable;	
	import com.poem.helpers.TextFieldHelper;
	import com.poem.models.PoemModel;
	import com.poem.constants.TextStyles;
	
	import com.greensock.*;
	import com.greensock.easing.*;

	import flash.display.CapsStyle;
	import flash.display.DisplayObject;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.SpreadMethod;
	import flash.display.GradientType;	
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.geom.Matrix;
	
	/**
	 * ...
	 * @author Ken Songer and Erik Falat
	 */
	public class Ambient extends Sprite implements IDisposable, IInitializable, IUpdateable
	{		
		[Inject]
		public var model:PoemModel;
		
		public var value_one:TextField;
		public var value_two:TextField;
		public var value_three:TextField;
		
		public var header:TextField;
		
		public var label_one:TextField;
		public var label_two:TextField;
		public var label_three:TextField;		
		
		public var background:Sprite;
		public var mask_clip:Sprite;
		public var rule_wh:Sprite;
		public var rule_gry:Sprite;		
		
		public var container:Sprite;		
		
		public function initialize() : void
		{
			createBackground();
			createAmbientValues();	
			addToStage();
			animate();
		}
		
		public function dispose() : void
		{
			while (container.numChildren > 0) container.removeChildAt(0);
			while (numChildren > 0) removeChildAt(0);
		}
		
		public function update() : void
		{
			dispose();
			createBackground();
			createAmbientValues();	
			addToStage();
		}			
		
		public function createAmbientValues() : void
		{
		}	
		
		private function addToStage() : void
		{
			container = new Sprite();
			
			container.addChild(background);	
			container.addChild(rule_wh);
			container.addChild(rule_gry);
			
			container.addChild(header);
			
			container.addChild(value_one);
			container.addChild(value_two);
			container.addChild(value_three);
			
			container.addChild(label_one);
			container.addChild(label_two);
			container.addChild(label_three);			
			
			addChild(container);
			addChild(mask_clip);
			container.mask = mask_clip;
		}	
		
		private function animate() : void
		{
			TweenMax.fromTo(container, 1, {y:80}, {y:0, ease:Expo.easeOut});
		}		
		
		// TODO:  Need to change this graphic to TextFields.
		private function createBackground() : void
		{
			rule_wh = new Sprite();
			rule_wh.graphics.lineStyle(1, 0xFFFFFF, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 10);
			rule_wh.graphics.moveTo(10, 23);
			//rule_wh.graphics.lineTo(140, 23);			
			
			rule_gry = new Sprite();
			rule_gry.graphics.lineStyle(1, 0xCCCCCC, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 10);
			rule_gry.graphics.moveTo(10, 24);
			//rule_gry.graphics.lineTo(140, 24);			
			
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
			//background.graphics.drawRoundRect(0, 0, 150, 80, 25);
			
			mask_clip = new Sprite();
			mask_clip.graphics.beginFill(0xFF0000, .4);		
			//mask_clip.graphics.drawRect(0, 0, 150, 70);			
		}
	}
}
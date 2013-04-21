package com.poem.views.menu 
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.poem.interfaces.IDisposable;
	import com.poem.interfaces.IInitializable;
	import com.poem.models.PoemModel;
	import com.poem.constants.Screens;
	import com.poem.signals.ChangeScreenSignal;
	import com.poem.signals.PoemTargetUpdatedSignal;
	
	import flash.display.CapsStyle;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.*;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class GlobalMenuItem extends Sprite implements IDisposable, IInitializable
	{

		[Inject]
		public var model:PoemModel;
		
		[Inject]
		public var changeScreen:ChangeScreenSignal;	
		
		[Inject]
		public var targetUpdated:PoemTargetUpdatedSignal;
		
		public static var LAST_CLICKED:GlobalMenuItem;
		public var container:Sprite;
		public var background:Sprite;
		public var mask_clip:Sprite;
		public var screenName:String;
		public var icon_path:String;
		public var mask_height:Number;
		public var mask_y:Number;
		public var icon:Loader;
		
		
		public function dispose() : void
		{
			while (numChildren > 0)
				removeChildAt(0);
		}
		
		public function initialize() : void
		{
			setValues();
			createBackground();
			createIcon();
			addToStage();
			animate();
			
			//DASHBOARD
			setDashboard();
			
			//OFFICE
			createSubMenu();
		}
		
		//STATIC METHODS		
		public function set SET_LAST_CLICKED(button:GlobalMenuItem):void{
			if (LAST_CLICKED != null){
				CLEAR_LAST_CLICKED();
			}
			LAST_CLICKED = button;
			LAST_CLICKED.select();
		};
		
		public static function get GET_LAST_CLICKED():GlobalMenuItem{		
			return LAST_CLICKED;
		}		
		
		public static function CLEAR_LAST_CLICKED():void{
			if (LAST_CLICKED != null){
				LAST_CLICKED.deselect();
				LAST_CLICKED = null;
			}
		}		
				

		public function setValues() : void
		{
		}
		
		public function setDashboard() : void
		{
		}		
		
		public function createSubMenu() : void
		{
		}
		public function showSubMenu() : void
		{
		}	
		public function hideSubMenu() : void
		{
		}			

		public function createIcon() : void
		{
			icon = new Loader();
			icon.load(new URLRequest(icon_path));
			icon.x = 3;
			icon.y = 0;
		}		
		
/*		public function changeScreenHandler() : void
		{
			SET_LAST_CLICKED = this;
		}*/
		
		public function select() : void
		{
			TweenMax.to(background, .25, {colorTransform:{tint:0x41886c, tintAmount:0.4}});
			TweenMax.to(icon, .25, {colorTransform:{tint:0x333333, tintAmount:0.9}});
		};	
		
		public function deselect() : void
		{
			TweenMax.to(background, .25, {colorTransform:{tint:0xCCCCCC, tintAmount:0}});
			TweenMax.to(icon, .25, {colorTransform:{tint:0x333333, tintAmount:0}});
		};			
		
		public function rollOver() : void
		{
			//TweenMax.fromTo(container, 1, {alpha:.25}, {alpha:1, ease:Expo.easeOut});
			showSubMenu();
		};
		
		public function rollOut() : void
		{
			hideSubMenu();
		};		
		
		public function click() : void
		{
			SET_LAST_CLICKED = this;
			clearTimeout(model.tInt);
			if (model.targetUpdateSend)	{
				targetUpdated.dispatch();
			}
			if ((screenName != Screens.OFFICE)) changeScreen.dispatch(screenName);
		}		
		
		private function animate() : void
		{
			TweenMax.fromTo(container, 1, {y:80}, {y:12, ease:Expo.easeOut});
		}			
		
		private function addToStage() : void
		{
			container = new Sprite;
			
			container.addChild(background);	
			container.addChild(icon);	
			
			addChild(container);
			addChild(mask_clip);
			container.mask = mask_clip;
		}			
		
		private function createBackground() : void
		{				
			
			background = new Sprite();
			background.graphics.lineStyle(1, 0xCCCCCC, 1, true, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 10);
			var fillType:String = GradientType.LINEAR;
			var colors:Array = [0xd0f5f3, 0xFFFFFF];
			var alphas:Array = [1, 1];
			var ratios:Array = [0, 255];
			var matr:Matrix = new Matrix();
			matr.createGradientBox(85, 75, 90, 0, 0);
			var spreadMethod:String = SpreadMethod.PAD;				
			background.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);	
			background.graphics.drawRoundRect(0, 0, 85, 80, 25);
			background.graphics.endFill();		
			
			mask_clip = new Sprite();
			mask_clip.graphics.beginFill(0xFF0000, .4);		
			mask_clip.graphics.drawRect(0, mask_y, 85, mask_height);			
		}		
		
	}
}
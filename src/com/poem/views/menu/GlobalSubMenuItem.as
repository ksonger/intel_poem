package com.poem.views.menu
{	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	import com.poem.constants.TextStyles;
	import com.poem.helpers.TextFieldHelper;
	import com.poem.signals.ChangeScreenSignal;
	
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	
	public class GlobalSubMenuItem extends Sprite
	{
		
		[Inject]
		public var changeScreen:ChangeScreenSignal;			
		
		public static var LAST_CLICKED:GlobalSubMenuItem;

		public var container:Sprite = new Sprite();
		public var label:TextField = new TextField();
		
		private var screen:String;
		private var label_txt:String;
		
		public function GlobalSubMenuItem(label_txt:String, screen:String)
		{	
			this.label_txt = label_txt;
			this.screen = screen;
		};
	
		public function initialize() : void
		{
			//CREATE BACKGROUND SHAPE
			create_label(label_txt);
			
			//ADD CHILD
			label.alpha = .4;
		}
		
		public function dispose() : void
		{
			while (numChildren > 0) removeChildAt(0);
		}			
		
		//STATIC METHODS		
		public function set SET_LAST_CLICKED(button:GlobalSubMenuItem):void{
			if (LAST_CLICKED != null){
				CLEAR_LAST_CLICKED();
			}
			LAST_CLICKED = button;
			LAST_CLICKED.select();
		};
		
		public static function get GET_LAST_CLICKED():GlobalSubMenuItem{		
			return LAST_CLICKED;
		}		
		
		public static function CLEAR_LAST_CLICKED():void{
			if (LAST_CLICKED != null){
				LAST_CLICKED.deselect();
				LAST_CLICKED = null;
			}
		}		
		
		
		//OVER RIDDEN
		public function create_label(label_txt:String):void{
			//var label:TextField = new TextField();
			label = TextFieldHelper.createTextField(0, 0, 90, label_txt, "LABEL", TextStyles.SUB_MENU, TextFieldAutoSize.LEFT, false, true);
			addChild(label);
			
			if(label.textHeight < 20) label.y = 5; 
			//container.addChild(label);
		}	
		
		// EVENT HANDLERS
		public function rollOver():void{
			TweenMax.to(label, 1, {alpha:.8});
			//TweenMax.to(label, 1, {colorTransform:{tint:0x666666, tintAmount:.8}});
		};
		
		public function rollOut():void{
			TweenMax.to(label, 1, {alpha:.4});
			//TweenMax.to(label, 1, {colorTransform:{tint:0x666666, tintAmount:0}});
		};		
		
		public function click():void{
			changeScreen.dispatch(screen);
		};
		
		// LAST CLICKED METHODS 
		private function select():void{	
			TweenMax.to(label, 1, {alpha:1});
			//TweenMax.to(label, 1, {colorTransform:{tint:0x333333, tintAmount:.8}});
		}		
		
		private function deselect():void{	
			TweenMax.to(label, 1, {alpha:.4});
			//TweenMax.to(label, 1, {colorTransform:{tint:0xCCCCCC, tintAmount:0}});
		}
		
	}
}
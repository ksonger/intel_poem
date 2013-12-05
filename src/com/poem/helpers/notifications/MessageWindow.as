package com.poem.helpers.notifications
{
	/**
	 * ...
	 * @author Ken Songer
	 */

	import com.poem.constants.TextStyles;
	import com.poem.helpers.TextFieldHelper;
	import com.poem.helpers.notifications.PopupAlertManager;
	import com.poem.models.PoemModel;
	import flash.desktop.NativeApplication;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	
	import flash.display.CapsStyle;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.Loader;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.NativeWindowType;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.net.URLRequest

	/**
	 * A lightweight window to display the message.
	 */
	public class MessageWindow extends NativeWindow
	{
		public var timeToLive:uint;
		private static const stockWidth:int = 250;
		private var manager:PopupAlertManager;
		private var icon:Loader;
		private var alert_text:TextField;
		private var background:Sprite;
		
		[Inject]
		public var model:PoemModel;
		
		
					
		public function MessageWindow(message:String, icon_url:String, manager:PopupAlertManager):void{
			
			this.manager = manager;
			
			var options:NativeWindowInitOptions = new NativeWindowInitOptions();
			options.type = NativeWindowType.LIGHTWEIGHT;
			options.systemChrome = NativeWindowSystemChrome.NONE;
			options.transparent = true;
			super(options);
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN,onClick,false,0,true);
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			manager.addEventListener(PopupAlertManager.LIFE_TICK,lifeTick,false,0,true);
			width = MessageWindow.stockWidth;
			
			icon = new Loader();
			configureAssetListeners(icon.contentLoaderInfo);
			icon.load(new URLRequest(icon_url));
			icon.x = 4;
					
			
			alert_text = new TextField();
			alert_text = TextFieldHelper.createTextField(37, 10, 190, message, "ALERTTEXT", TextStyles.ALERT_VALUE, TextFieldAutoSize.LEFT, false, true);
			
			if(alert_text.textHeight < 32) height = alert_text.textHeight + 32;
			else height = alert_text.textHeight + 25;
			
			
			
			draw();	
			alwaysInFront = true;
		}

	
		private function onClick(event:MouseEvent):void{
			close();
		}
		
		public function lifeTick(event:Event):void{
			timeToLive--;
			if(timeToLive < 1){
				close();
			}
		}
		
		public override function close():void{
			manager.removeEventListener(PopupAlertManager.LIFE_TICK,lifeTick,false);
			super.close();
			if (model == null)	{
				//NativeApplication.nativeApplication.exit();
			}
			
		}
		
		private function draw():void{
			
			if (background == null)	{
				background = new Sprite();
			}
			background.graphics.clear();
			background.graphics.lineStyle(1, 0xCCCCCC, 1, true, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 10);
			var fillType:String = GradientType.LINEAR;
			var colors:Array = [0xd8f7f5, 0xFFFFFF];
			var alphas:Array = [.9, .9];
			var ratios:Array = [0, 255];
			var matr:Matrix = new Matrix();
			matr.createGradientBox(width, height, 90, 0, 0);
			var spreadMethod:String = SpreadMethod.PAD;				
			background.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);	
			background.graphics.drawRoundRect(0, 0, width-1, height-1, 25);
			background.graphics.endFill();	
			
			stage.addChildAt(background, 0);
		}
		
		public function animateY(endY:int):void{
			var dY:Number;
			var animate:Function = function(event:Event):void{
				dY = (endY - y)/4
				y += dY;
				if( y <= endY){
					y = endY;
					stage.removeEventListener(Event.ENTER_FRAME,animate);
				}
			}
			stage.addEventListener(Event.ENTER_FRAME,animate,false,0,true);
		}
		
		/**********************************/
		/***** LOADER LISTENERS ***********/
		/**********************************/
		public function configureAssetListeners(dispatcher:IEventDispatcher):void {
			dispatcher.addEventListener(Event.INIT, graphicCompleteHandler,false,0,true);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, graphicIoErrorHandler,false,0,true);
		}
		public function graphicCompleteHandler(e:Event):void {
			alert_text.y = ((background.height - alert_text.height) / 2);
			icon.x = alert_text.x - e.target.content.width;
			icon.y = alert_text.y + ((alert_text.height - e.target.content.height) / 2);
			stage.addChild(icon);
			stage.addChild(alert_text);
		}
		public function graphicIoErrorHandler(event:IOErrorEvent):void {
			var msg:String='Message image not loaded: '+event.text;
			trace(msg);
		}
	}
}
package com.poem.views.dashboard 
{
	import com.greensock.TweenMax;
	import com.poem.constants.TextStyles;
	import com.poem.models.PoemModel;
	import com.poem.interfaces.IInitializable;
	import com.poem.signals.TargetAlertsUpdatedSignal;
	import com.poem.views.PoemApplicationView;
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import com.poem.helpers.TextFieldHelper;
	import com.poem.interfaces.IDisposable;
	import flash.text.TextFieldAutoSize;
	import flash.utils.*;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class EVView extends Sprite implements IDisposable, IInitializable
	{
		[Inject]
		public var model:PoemModel;
		

		
		private var ev_image:MovieClip;
		
		
		public function initialize() : void
		{
			trace('init');
			createImage();
		}
		
		private function createImage():void 
		{
			if (ev_image == null)	{
				ev_image = new MovieClip();
				ev_image.ldr = new Loader();
				ev_image.addChild(ev_image.ldr);
				configureAssetListeners(ev_image.ldr.contentLoaderInfo);
				ev_image.ldr.load(new URLRequest(String(model.config.evImage)));
				
			}
		}	
		/**********************************/
		/***** LOADER LISTENERS ***********/
		/**********************************/
		public function configureAssetListeners(dispatcher:IEventDispatcher):void {
			dispatcher.addEventListener(Event.INIT, graphicCompleteHandler,false,0,true);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, graphicIoErrorHandler,false,0,true);
		}
		public function graphicCompleteHandler(e:Event):void {
			addChild(ev_image);
		}
		public function graphicIoErrorHandler(event:IOErrorEvent):void {
			var msg:String='Comfort image not loaded: '+event.text;
			trace(msg);
		}

		public function dispose() : void
		{
			while (numChildren > 0)
				removeChildAt(0);
			
			model = null;
		}
		
		private function addToStage() : void
		{

		}		
	}
}
package com.poem.views.comfort
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.poem.constants.TextStyles;
	import com.poem.helpers.MarkerToolTipHelper;
	import com.poem.helpers.TextFieldHelper;
	import com.poem.interfaces.IDisposable;
	import com.poem.interfaces.IInitializable;
	import com.poem.models.PoemModel;
	import com.poem.signals.ComfortIconsLoadedSignal;
	import com.poem.signals.ComfortReadySignal;
	import flash.display.MovieClip;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;
	import flash.utils.clearTimeout;
	
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
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;	
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public dynamic class Comfort extends Sprite implements IDisposable, IInitializable
	{		
		[Inject]
		public var model:PoemModel;
		
		[Inject]
		public var loaded:ComfortIconsLoadedSignal;
		
		private var _bg:Sprite;
		private var _submit:MovieClip;
		private var _submit_bg:Sprite;
		private var _header:TextField;
		private var _msk:Sprite;
		private var _expanded:Boolean = false;
		private var _selected:Boolean = false;
		private var _hitarea:Sprite;
		private var _icons:Array = new Array();
		private var fillType:String;
		private var colors:Array;
		private var alphas:Array;
		private var ratios:Array;
		private var matr:Matrix;
		private var spreadMethod:String;
		private var _comfortLevel:Number = 0;
		private var _arrow:MovieClip;
		public var toolTip:MovieClip;
		private var fine_txt:String;
		private var tip_txt:String;
		private var tInt:Number;
		private var _submitDialog:MovieClip;
		private var _submitted_txt:String;
		public var submittedDialogVisible:Boolean = false;
		
		public function initialize() : void
		{
			makeBackground();
			makeArrow();
			makeHeading();
			makeSubmit();
			makeHitarea();
			makeTooltip();
			makeSubmitDialog();
			addChild(_bg);
			addChild(_arrow);
			addChild(_header);
			addChild(_submit);
			createIcons();
			addChild(_hitarea);
			makeMask();
			addChild(toolTip);
			addChild(_submitDialog);
		}
		
		private function makeSubmitDialog():void 
		{
			_submitted_txt = model.labelManager.getLabel("c61");
			_submitDialog = new MovieClip();
			_submitDialog.tf = TextFieldHelper.createTextField(5, 18, 96, _submitted_txt, "SUBMITTED", TextStyles.COMFORT_TOOLTIP, TextFieldAutoSize.CENTER, false,true);
			_submitDialog.bg = new Shape();
			with (_submitDialog.bg.graphics)	{
				lineStyle(1, 0xCCCCCC, 1, true, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 10);
				beginFill(0xFFFFFF, 1);
				drawRoundRect(0, 0, _submitDialog.tf.width+15, _submitDialog.tf.y + _submitDialog.tf.height+8, 10);
				endFill();
			}
			_submitDialog.addChild(_submitDialog.bg);
			_submitDialog.addChild(_submitDialog.tf);
			_submitDialog.close = new Sprite();
			with (_submitDialog.close.graphics)	{
				beginFill(0xFF0000, 0);
				drawRect(0, 0, 7, 7);
				endFill();
				lineStyle(2, 0xCCCCCC, .5, true, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 10);
				moveTo(0, 0);
				lineTo(7, 7);
				moveTo(7, 0);
				lineTo(0, 7);
			}
			_submitDialog.close.y = 5;
			_submitDialog.close.x = _submitDialog.bg.width - _submitDialog.close.width - 5;
			_submitDialog.close.useHandCursor = true;
			_submitDialog.close.buttonMode = true;
			_submitDialog.addChild(_submitDialog.close);
			TweenMax.to(_submitDialog.bg, .1, { dropShadowFilter: { color:0x000000, alpha:.2, blurX:2, blurY:2, angle:0, distance:3 }} );
			_submitDialog.x = 41;
			_submitDialog.y = 50;
			_submitDialog.alpha = 0;
		}
			
		private function makeTooltip():void 
		{
			fine_txt = model.labelManager.getLabel("c57");
			toolTip = new MovieClip();
			toolTip.name_tf = TextFieldHelper.createTextField(5, 2, 50, fine_txt, "TIP", TextStyles.COMFORT_TOOLTIP, TextFieldAutoSize.CENTER);
			toolTip.bg = new Shape();
			with (toolTip.bg.graphics)	{
				lineStyle(1, 0xCCCCCC, 1, true, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 10);
				beginFill(0xFFFFFF, 1);
				drawRoundRect(0, 0, toolTip.name_tf.width+15, 20, 10);
				endFill();
			}
			toolTip.addChild(toolTip.bg);
			toolTip.addChild(toolTip.name_tf);
			TweenMax.to(toolTip.bg, .1, { dropShadowFilter: { color:0x000000, alpha:.2, blurX:2, blurY:2, angle:0, distance:3 }} );
			toolTip.alpha = 0;
		}
		
		private function makeMask():void 
		{
			_msk = new Sprite();
			with (_msk.graphics)	{
				beginFill(0xFF0000, .5);
				drawRect( -100, 20, 250, 81);
				endFill();
			}
			addChild(_msk);
			_bg.mask = _msk;
		}
		
		private function makeHitarea():void 
		{
			_hitarea = new Sprite();
			with (_hitarea.graphics)	{
				beginFill(0xFF0000, 0);
				drawRect( 0, 20, 140, 81);
				endFill();
			}
			_hitarea.useHandCursor = true;
			_hitarea.buttonMode = true;
		}
		
		private function makeSubmit():void 
		{
			_submit = new MovieClip();
			_submit_bg = new Sprite();
			fillType = GradientType.LINEAR;
			colors = [0xafcac9, 0x6f6f6f];
			alphas = [1, 1];
			ratios = [0, 255];
			matr= new Matrix();
			matr.createGradientBox(55, 20, 90, 0, 0);
			spreadMethod = SpreadMethod.PAD;	
			with (_submit_bg.graphics)	{
				lineStyle(1, 0x999999, 1, true, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 10);
				beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);		
				drawRoundRect(0, 0, 55, 20, 10);
				endFill();
			}
			var submit_txt:String = model.labelManager.getLabel("c22");
			var label:TextField = TextFieldHelper.createTextField(4, 0, 50, submit_txt, "Submit", TextStyles.COMFORT_SUBMIT, TextFieldAutoSize.LEFT);
			_submit.addChild(_submit_bg);
			_submit.addChild(label);
			_submit.x = 80;
			_submit.y = 25;
			var ds:DropShadowFilter = new DropShadowFilter(2, 45, 0x000000, 1, 2, 2, .3, 2, false, false, false);
			_submit.filters = [ds];
			_submit.mouseChildren = false;
			_submit.useHandCursor = true;
			_submit.buttonMode = true;
		}
		
		private function makeBackground():void 
		{
			
			fillType = GradientType.LINEAR;
			colors = [0xd8f7f5, 0xFFFFFF];
			alphas = [.9, .9];
			ratios = [0, 255];
			matr = new Matrix();
			matr.createGradientBox(372, 82, 90, 0, 0);
			spreadMethod = SpreadMethod.PAD;
			_bg = new Sprite();
			_bg.x = 50;
			with (_bg.graphics)	{
				lineStyle(1, 0xCCCCCC, 1, true, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 10);	
				beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);		
				drawRoundRect(0, 0, 95, 100, 25);
				endFill();
				lineStyle(1, 0xFFFFFF, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 10);
				moveTo(10, 50);
				lineTo(85, 50);
				lineStyle(1, 0xCCCCCC, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 10);
				moveTo(10, 51);
				lineTo(85, 51);	
			}
			var grid:Rectangle = new Rectangle(10, 20, 70, 70);
			_bg.scale9Grid = grid;
		}	
		
		private function makeHeading():void {
			_header = TextFieldHelper.createTextField(20, 28, 150, String(model.labelManager.getLabel("c2")).toUpperCase(), "COMFORT", TextStyles.ALERT_HEADER, TextFieldAutoSize.LEFT);
		}
		private function makeArrow():void 
		{
			_arrow = new MovieClip();
			_arrow.x = 10;
			_arrow.y = 32;
			_arrow.ldr = new Loader();
			_arrow.addChild(_arrow.ldr);
			_arrow.mouseChildren = false;
			_arrow.buttonMode = true;
			_arrow.useHandCursor = true;
			_arrow.scale = 1;
			configureAssetListeners(_arrow.ldr.contentLoaderInfo);
			_arrow.ldr.load(new URLRequest(model.config.comfortArrowIconURL));
			
		}
		
		public function dispose() : void
		{
			while (numChildren > 0)
				removeChildAt(0);
				
			model = null;
		}				
		
		private function createIcons() : void
		{
			var lvl:Number = -3;
			var scales:Array = [1, .75, .5];
			var copenx:Array = [ -90, -42, -2];
			var cclosex:Array = [ 56, 58, 60];
			for (var i:Number = 0; i < 3; i++)	{
				var c:String = '_cold' + String(i);
				this[c] = new MovieClip();
				this[c].name = c;
				this[c].lvl = lvl;
				this[c].selected = false;
				this[c].scale = scales[i];
				this[c].openx = copenx[i];
				this[c].closex = cclosex[i];
				this[c].ldr = new Loader();
				this[c].addChild(this[c].ldr);
				this[c].mouseChildren = false;
				this[c].buttonMode = true;
				this[c].useHandCursor = true;
				configureAssetListeners(this[c].ldr.contentLoaderInfo);
				this[c].ldr.load(new URLRequest(model.config.comfortColdIconURL));
				lvl++;
				this.addChild(this[c]);
				_icons.push(this[c]);
			}	
			lvl = 3
			var hopenx:Array = [ 110, 77, 48];
			var hclosex:Array = [ 112, 114, 116];
			for (i = 0; i < 3; i++)	{
				var h:String = '_hot' + String(i);
				this[h] = new MovieClip();
				this[h].name = h;
				this[h].lvl = lvl;
				this[h].selected = false;
				this[h].scale = scales[i];
				this[h].openx = hopenx[i];
				this[h].closex = hclosex[i];
				this[h].ldr = new Loader();
				this[h].addChild(this[h].ldr);
				this[h].mouseChildren = false;
				this[h].buttonMode = true;
				this[h].useHandCursor = true;
				configureAssetListeners(this[h].ldr.contentLoaderInfo);
				this[h].ldr.load(new URLRequest(model.config.comfortHotIconURL));
				lvl--;
				this.addChild(this[h]);
				_icons.push(this[h]);
			}
			if (this['_neutral'] == null)	{
				var n:String = '_neutral';
				this[n] = new MovieClip();
				with (this[n].graphics)	{
					beginFill(0xFF0000, 0);
					drawRect( -8, 0, 16, 25);
					endFill();
					lineStyle(4, 0xB6CAD1, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 10);
					moveTo(0, 0);
					lineTo(0, 25);
				}
				this[n].scale = 1;
				this[n].lvl = 0;
				this[n].closex =100;
				this[n].openx = 30;
				this[n].y = this.height - this[n].height - 8;
				this[n].x = this[n].closex;
				this.addChild(this[n]);
				this[n].buttonMode = true;
				this[n].useHandCursor = true;
				_icons.push(this[n]);
			}
		}		
			
		public function get submit():MovieClip 
		{
			return _submit;
		}
		
		public function set submit(value:MovieClip):void 
		{
			_submit = value;
		}
		
		public function get bg():Sprite 
		{
			return _bg;
		}
		
		public function set bg(value:Sprite):void 
		{
			_bg = value;
		}
		
		public function get header():TextField 
		{
			return _header;
		}
		
		public function set header(value:TextField):void 
		{
			_header = value;
		}
		
		public function get selected():Boolean 
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void 
		{
			_selected = value;
		}
		
		public function get expanded():Boolean 
		{
			return _expanded;
		}
		
		public function set expanded(value:Boolean):void 
		{
			_expanded = value;
		}
		
		public function get hitarea():Sprite 
		{
			return _hitarea;
		}
		
		public function set hitarea(value:Sprite):void 
		{
			_hitarea = value;
		}
		
		public function get icons():Array 
		{
			return _icons;
		}
		
		public function set icons(value:Array):void 
		{
			_icons = value;
		}
		
		public function get arrow():MovieClip 
		{
			return _arrow;
		}
		
		public function set arrow(value:MovieClip):void 
		{
			_arrow = value;
		}
		
		public function get submitDialog():MovieClip 
		{
			return _submitDialog;
		}
		
		public function set submitDialog(value:MovieClip):void 
		{
			_submitDialog = value;
		}
		
		public function get submitted_txt():String 
		{
			return _submitted_txt;
		}
		
		public function set submitted_txt(value:String):void 
		{
			_submitted_txt = value;
		}
		/**********************************/
		/***** LOADER LISTENERS ***********/
		/**********************************/
		public function configureAssetListeners(dispatcher:IEventDispatcher):void {
			dispatcher.addEventListener(Event.INIT, graphicCompleteHandler,false,0,true);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, graphicIoErrorHandler,false,0,true);
		}
		public function graphicCompleteHandler(e:Event):void {
			e.target.removeEventListener(Event.COMPLETE, graphicCompleteHandler);
			e.target.content.gotoAndStop(1);
			e.target.content.parent.parent.scaleX = e.target.content.parent.parent.scaleY = e.target.content.parent.parent.scale;
			if (icons.length == 7)	{
				loaded.dispatch();
			}
		}
		public function graphicIoErrorHandler(event:IOErrorEvent):void {
			var msg:String='Comfort image not loaded: '+event.text;
			trace(msg);
		}
	}
}
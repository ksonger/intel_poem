package com.poem.views.usage 
{
	import com.greensock.TweenMax;
	import com.poem.constants.TextStyles;
	import com.poem.constants.Screens;
	import com.poem.helpers.TextFieldHelper;
	import com.poem.interfaces.IDisposable;
	import com.poem.interfaces.IInitializable;
	import com.poem.models.PoemModel;
	import com.poem.signals.PoemTargetUpdatedSignal;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.net.URLRequest;
	
	import flash.display.CapsStyle;
	import flash.display.DisplayObject;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.Sprite;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.*;
	
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public dynamic class BarChartLegend extends Sprite implements IDisposable, IInitializable
	{
		
		[Inject]
		public var model:PoemModel;
		
		[Inject]
		public var targetUpdated:PoemTargetUpdatedSignal;
		
		
		private var _target_txt:String;
		private var _target:Sprite;
		private var _target_label:TextField;
		private var _target_hitarea:Sprite;
		private var _rule:Sprite;
		private var _y_inc:Number;
		private var _y_inc_value:Number;
		private var _me_txt:String;
		private var _me:Sprite;
		private var _department_txt:String;
		private var _department:Sprite;
		private var _floor_txt:String;
		private var _floor:Sprite;
		private var _building_txt:String;
		private var _building:Sprite;
		private var _addbtn:MovieClip;
		private var _removebtn:MovieClip;
		private var _detailsClip:MovieClip;
		private var chart:BarChart;
		private var _consumption_text:TextField;
		
		public function BarChartLegend(chart:BarChart):void {
			this.chart = chart;
		}
		
		
		public function initialize() : void 
		{
			create_legend();
		}
		
		private function create_legend():void {
			
			if (model.appState.currentScreen == Screens.OFFICE)	{
				_target_txt = model.labelManager.getLabel("c6").toUpperCase() + ' ' + model.labelManager.getLabel("c10").toUpperCase()
			}
			if (model.appState.currentScreen == Screens.PCUSAGE)	{
				_target_txt = model.labelManager.getLabel("c7").toUpperCase() + ' ' + model.labelManager.getLabel("c10").toUpperCase()
			}
			if (model.appState.currentScreen == Screens.PRINTERUSAGE)	{
				_target_txt = model.labelManager.getLabel("c8").toUpperCase() + ' ' + model.labelManager.getLabel("c10").toUpperCase()
			}
			if (model.appState.currentScreen == Screens.PLUGGABLEUSAGE)	{
				_target_txt = model.labelManager.getLabel("c9").toUpperCase() + ' ' + model.labelManager.getLabel("c10").toUpperCase()
			}
			
			_target = new Sprite();
			with (_target.graphics)	{
				lineStyle(2, 0x666666, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 10);
				moveTo(-2, -72);
				lineTo(5, -72);	
			}
					
			_target_label = TextFieldHelper.createTextField(10, -80, 80, target_txt, "LABEL", TextStyles.LEGEND_HEADER, TextFieldAutoSize.LEFT, false, true);
			_target_hitarea = new Sprite();
			with (_target_hitarea.graphics)	{
				beginFill(0xFF0000, 0);
				drawRect(0, 0, 80, _target_label.height);
				endFill();
			}
			_target_hitarea.x = _target_label.x;
			_target_hitarea.y = _target_label.y;
			_target_hitarea.useHandCursor = true;
			_target_hitarea.buttonMode = true;
			_target_hitarea.addEventListener(MouseEvent.MOUSE_OVER, headerOverHandler,false,0,true);
			_target_hitarea.addEventListener(MouseEvent.MOUSE_OUT, headerOutHandler,false,0,true);
			
			_rule = new Sprite();
			with (_rule.graphics)	{
				lineStyle(1, 0xFFFFFF, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 10);
				moveTo(-2, 5);
				lineTo(90, 5);
				lineStyle(1, 0xCCCCCC, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 10);
				moveTo(-2, 6);
				lineTo(90, 6);
			}
			
			_detailsClip = new MovieClip();
			with (_detailsClip.graphics)	{
				lineStyle(1.5, 0x59a994, 1, true, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 10);
				beginFill(0x458769, 1);
				drawRoundRect(0, 0, 150, 103, 8);
				endFill();
			}
			_detailsClip.txt1 = TextFieldHelper.createTextField(5, 5, 140, model.labelManager.getLabel("c71"), "DETAILS_TEXT", TextStyles.USAGE_INSTRUCTIONS, TextFieldAutoSize.LEFT, false, true);
			_detailsClip.addChild(_detailsClip.txt1);
			
			_detailsClip.txt2 = TextFieldHelper.createTextField(5, 5, 140, model.labelManager.getLabel("c72"), "DETAILS_TEXT", TextStyles.USAGE_INSTRUCTIONS, TextFieldAutoSize.LEFT, false, true);
			_detailsClip.txt2.y = _detailsClip.txt1.y + _detailsClip.txt1.height + 5;
			_detailsClip.addChild(_detailsClip.txt2);
			
			_detailsClip.txt3 = TextFieldHelper.createTextField(5, 5, 140, model.labelManager.getLabel("c73"), "DETAILS_TEXT", TextStyles.USAGE_INSTRUCTIONS, TextFieldAutoSize.LEFT, false, true);
			_detailsClip.txt3.y = _detailsClip.txt2.y + _detailsClip.txt2.height + 5;
			_detailsClip.addChild(_detailsClip.txt3);
			
			_detailsClip.x = -170;
			_detailsClip.y = -88;
			_detailsClip.alpha = 0;
			var ds:DropShadowFilter = new DropShadowFilter(3, 45, 0x000000, 1, 2, 2, .2, 2, false, false, false);
			_detailsClip.filters = [ds];
			addChild(_detailsClip);
			
			_addbtn = new MovieClip();
			_addbtn.ldr = new Loader();
			_addbtn.addChild(_addbtn.ldr);
			_addbtn.ldr.load(new URLRequest(model.config.usageAddTargetIcon));
			configureAssetListeners(_addbtn.ldr.contentLoaderInfo);
			_addbtn.txt = TextFieldHelper.createTextField(17, -1, 80, model.labelManager.getLabel("c66"), "ADD_TEXT", TextStyles.LEGEND, TextFieldAutoSize.LEFT, false, true);
			_addbtn.addChild(_addbtn.txt);
			_addbtn.hitarea = new MovieClip();
			with (_addbtn.hitarea.graphics)	{
				beginFill(0xFF0000, 0);
				drawRect(0, 0, 102, 15);
				endFill();
			}
			_addbtn.hitarea.useHandCursor = true;
			_addbtn.hitarea.buttonMode = true;
			_addbtn.hitarea.addEventListener(MouseEvent.CLICK, addRemoveTargetHandler,false,0,true);
			_addbtn.addChild(_addbtn.hitarea);
			
			_removebtn = new MovieClip();
			_removebtn.ldr = new Loader();
			_removebtn.addChild(_removebtn.ldr);
			_removebtn.ldr.load(new URLRequest(model.config.usageRemoveTargetIcon));
			configureAssetListeners(_removebtn.ldr.contentLoaderInfo);
			_removebtn.txt = TextFieldHelper.createTextField(17, -1, 80, model.labelManager.getLabel("c67"), "ADD_TEXT", TextStyles.LEGEND, TextFieldAutoSize.LEFT, false, true);
			_removebtn.addChild(_removebtn.txt);
			_removebtn.hitarea = new MovieClip();
			with (_removebtn.hitarea.graphics)	{
				beginFill(0xFF0000, 0);
				drawRect(0, 0, 102, 15);
				endFill();
			}
			_removebtn.hitarea.useHandCursor = true;
			_removebtn.hitarea.buttonMode = true;
			_removebtn.hitarea.addEventListener(MouseEvent.CLICK, addRemoveTargetHandler,false,0,true);
			_removebtn.addChild(_removebtn.hitarea);
			
			_addbtn.y = -23;
			_removebtn.y = -23;
			
			
			_y_inc = 25;
			_y_inc_value = 20;
			
			// ME
			_me_txt = model.labelManager.getLabel("c24");
			_me = create_listing(_me_txt, 0xa2e8f4);
			_me.y = _y_inc;
			_y_inc += _y_inc_value;
			
			// MY DEPARTMENT
			_department_txt = model.labelManager.getLabel("c25");
			_department = create_listing(_department_txt, 0x5370ba);
			_department.y = _y_inc;
			_y_inc += _y_inc_value;
			
			// MY FLOOR
			_floor_txt = model.labelManager.getLabel("c26");
			_floor = create_listing(_floor_txt, 0x60c339);
			_floor.y = _y_inc;
			_y_inc += _y_inc_value;
			
			// MY BUILDING
			_building_txt = model.labelManager.getLabel("c27");
			_building = create_listing(_building_txt, 0xe6921a);
			_building.y = _y_inc;
			_y_inc += _y_inc_value;	
			
			//MY CONSUMPTION
			_consumption_text = TextFieldHelper.createTextField(-8, _y_inc, 105, model.labelManager.getLabel("c68"), "CONSUMPTION_LABEL", TextStyles.CONSUMPTION_LABEL, TextFieldAutoSize.LEFT, false, true);
			addChild(_consumption_text);

			addChild(_target);
			addChild(_target_label);
			addChild(_target_hitarea);
			addChild(_rule);			
			addChild(_addbtn);
			addChild(_removebtn);
			addChild(_me);
			addChild(_department);
			addChild(_floor);
			addChild(_building);	
			
			
			
			addEventListener(Event.ENTER_FRAME, enterHandler,false,0,true);
		}
		
		private function addRemoveTargetHandler(e:MouseEvent):void 
		{
			chart.target_line.visible = !chart.target_line.visible;
			
			if (model.appState.currentScreen == Screens.OFFICE) 
			{
				model.sensorData.officeTargetsVisible = chart.target_line.visible;
			}
			if (model.appState.currentScreen == Screens.PCUSAGE) 
			{
				model.sensorData.pcTargetsVisible = chart.target_line.visible;
			}
			if (model.appState.currentScreen == Screens.PRINTERUSAGE) 
			{
				model.sensorData.printerTargetsVisible = chart.target_line.visible;
			}
			if (model.appState.currentScreen == Screens.PLUGGABLEUSAGE) 
			{
				model.sensorData.pluggableTargetsVisible = chart.target_line.visible;
			}
			model.targetUpdateSend = true;
			clearTimeout(model.tInt);
			model.tInt = setTimeout(targetUpdated.dispatch, 10000);
		}
		
		private function enterHandler(e:Event):void 
		{
			_addbtn.visible = (!chart.target_line.visible && model.appState.currentScreen != Screens.PLUGGABLEUSAGE);
			if (model.appState.currentScreen == Screens.PLUGGABLEUSAGE)	{
				_removebtn.visible = false;
			}	else 
			{
				_removebtn.visible = !_addbtn.visible;
			}
		}
		
		private function headerOutHandler(e:MouseEvent):void 
		{
			if (model.appState.currentScreen != Screens.PLUGGABLEUSAGE) 
			{
				TweenMax.to(_detailsClip, .2, { alpha:0 } );
			}
		}
		
		private function headerOverHandler(e:MouseEvent):void 
		{
			if (model.appState.currentScreen != Screens.PLUGGABLEUSAGE)	
			{
				TweenMax.to(_detailsClip, .2, { alpha:1 } );
			}
		}
		
		private function create_listing(department_txt:String, color:Number):Sprite{

			var container:Sprite = new Sprite();
			
			var listing_mark:Sprite = create_mark(color);
			var listing_label:TextField = create_label(department_txt);
			listing_mark.y = 0;
			listing_label.y = -7;			
			
			container.addChild(listing_mark);
			container.addChild(listing_label);	

			return container;
		};
		
		private function create_label(label_txt:String):TextField{
			var label:TextField = TextFieldHelper.createTextField(10, 0, 40, label_txt, "LABEL", TextStyles.LEGEND, TextFieldAutoSize.LEFT);
			return label;			
		}
		
		private function create_mark(color:Number):Sprite{
			var mark:Sprite = new Sprite();
			mark.graphics.beginFill(color);
			mark.graphics.drawCircle(0, 2, 4);
			return mark;
		}
		
		public function dispose() : void
		{
			while (numChildren > 0)
				removeChildAt(0);
		}
		
		/**********************************/
		/***** LOADER LISTENERS ***********/
		/**********************************/
		public function configureAssetListeners(dispatcher:IEventDispatcher):void {
			dispatcher.addEventListener(Event.INIT, graphicCompleteHandler,false,0,true);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, graphicIoErrorHandler,false,0,true);
		}
		public function graphicCompleteHandler(e:Event):void {
			
		}
		public function graphicIoErrorHandler(event:IOErrorEvent):void {
			var msg:String='Bar Chart image not loaded: '+event.text;
			trace(msg);
		}
		
		
		
		public function get target_txt():String 
		{
			return _target_txt;
		}
		
		public function set target_txt(value:String):void 
		{
			_target_txt = value;
		}
		
		public function get target():Sprite 
		{
			return _target;
		}
		
		public function set target(value:Sprite):void 
		{
			_target = value;
		}
		
		public function get target_label():TextField 
		{
			return _target_label;
		}
		
		public function set target_label(value:TextField):void 
		{
			_target_label = value;
		}
		
		public function get rule():Sprite 
		{
			return _rule;
		}
		
		public function set rule(value:Sprite):void 
		{
			_rule = value;
		}
		
		public function get y_inc():Number 
		{
			return _y_inc;
		}
		
		public function set y_inc(value:Number):void 
		{
			_y_inc = value;
		}
		
		public function get y_inc_value():Number 
		{
			return _y_inc_value;
		}
		
		public function set y_inc_value(value:Number):void 
		{
			_y_inc_value = value;
		}
		
		public function get me_txt():String 
		{
			return _me_txt;
		}
		
		public function set me_txt(value:String):void 
		{
			_me_txt = value;
		}
		
		public function get me():Sprite 
		{
			return _me;
		}
		
		public function set me(value:Sprite):void 
		{
			_me = value;
		}
		
		public function get department_txt():String 
		{
			return _department_txt;
		}
		
		public function set department_txt(value:String):void 
		{
			_department_txt = value;
		}
		
		public function get department():Sprite 
		{
			return _department;
		}
		
		public function set department(value:Sprite):void 
		{
			_department = value;
		}
		
		public function get floor_txt():String 
		{
			return _floor_txt;
		}
		
		public function set floor_txt(value:String):void 
		{
			_floor_txt = value;
		}
		
		public function get floor():Sprite 
		{
			return _floor;
		}
		
		public function set floor(value:Sprite):void 
		{
			_floor = value;
		}
		
		public function get building_txt():String 
		{
			return _building_txt;
		}
		
		public function set building_txt(value:String):void 
		{
			_building_txt = value;
		}
		
		public function get building():Sprite 
		{
			return _building;
		}
		
		public function set building(value:Sprite):void 
		{
			_building = value;
		}
		
		public function get consumption_text():TextField 
		{
			return _consumption_text;
		}
		
		public function set consumption_text(value:TextField):void 
		{
			_consumption_text = value;
		}
	}

}
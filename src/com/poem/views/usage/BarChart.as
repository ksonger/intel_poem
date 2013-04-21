package com.poem.views.usage 
{
	import adobe.utils.CustomActions;
	import com.greensock.TweenMax;
	import com.poem.constants.Screens;
	import com.poem.constants.TextStyles;
	import com.poem.helpers.SpriteHelper;
	import com.poem.helpers.TextFieldHelper;
	import com.poem.interfaces.IDisposable;
	import com.poem.interfaces.IInitializable;
	import com.poem.models.DailyEnergyConsumption;
	import com.poem.models.EnergyComparison;
	import com.poem.models.MarkerData;
	import com.poem.models.PoemModel;
	import com.poem.signals.UpdateUsageScreenSignal;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.filters.BevelFilter;
	import flash.filters.DropShadowFilter;
	import flash.text.AntiAliasType;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class BarChart extends Sprite implements IDisposable, IInitializable
	{
		
		
		[Inject]
		public var model:PoemModel;
		
		[Inject]
		public var updateScreen:UpdateUsageScreenSignal;	
	
		private var _chartHeight:Number;
		private var category:String;
		private var _target_line:Sprite;
		private var barChartLegend:BarChartLegend;
		private var _background:Loader;
		private var _usageView:*;
		private var _tipClip:MovieClip;
		private var _currentUnits:String = '';
		private var _dragText:String;
		private var _shade:Sprite;
		private var _msk:Sprite;
		private var _baseY:Number = -6;
		private var _draggableRange:Number = 160;
		private var _shadeMinimum:Number = 16;
		public var target_text_above:TextField;
		public var target_text_below:TextField;
		public var target_text:MovieClip;
		public var dragging:Boolean = false;
		public var css:StyleSheet = new StyleSheet();
		
		
		public function BarChart(_chartHeight:Number, category:String, usageView:UsageDetailsView) 
		{
			this._chartHeight = _chartHeight;
			this.category = category;
			_usageView = usageView;
		}	
		
		public function initialize() : void
		{
			_dragText = model.labelManager.getLabel("c64");
			updateScreen.add(updateScreenHandler);
			createBackground();
			createBars();
			addTargetLine();
			updateTargetLine();
			createLegend();	
		}
		
		public function dispose() : void
		{
			while (numChildren > 0)
				removeChildAt(0);
			
			updateScreen.remove(updateScreenHandler);
			model = null;
		}
		
		private function updateScreenHandler() : void
		{
			updateTargetLine();
			updateLegend();
		}		

		private function addTargetLine() : void
		{
			_target_line = new Sprite();
			with (_target_line.graphics)	{
				lineStyle(2.5, 0x438668, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 10);
				moveTo(0, 0);		
				lineTo(436, 0);
				lineStyle(6, 0x438668, 0, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 10);
				moveTo(0, 0);		
				lineTo(436, 0);
				moveTo(424.5, -14);
				lineStyle(.1, 0x438668, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 10);
				beginFill(0x438668);
				lineTo(431, -4);
				lineTo(418, -4);
				lineTo(424.5, -14);
				moveTo(424.5, 14);
				lineTo(431, 5);
				lineTo(418, 5);
				lineTo(424.5,15)
				endFill();
			}
			var bf:BevelFilter = new BevelFilter(1, 45, 0xFFFFFF, .3, 0x000000, .3, 3, 3, 3);
			_target_line.filters = [bf];
			_target_line.x = 119;

			target_text_above = new TextField();
			target_text_above.autoSize = TextFieldAutoSize.LEFT;
			target_text_above.antiAliasType = AntiAliasType.ADVANCED;
			target_text_above.wordWrap = false;
			target_text_above.selectable = false;
			target_text_above.x = 32;
			target_text_above.y = -19;
			target_text_above.embedFonts = true;
			
			css.setStyle(".style1", TextStyles.TARGET_ABOVE);
			css.setStyle(".style2", TextStyles.TARGET_BELOW);
			css.setStyle(".style3", TextStyles.TARGET_BELOW_BOLD);
			
			target_text_above.styleSheet = css;
			target_text_above.htmlText = '<span class="style1">' + model.labelManager.getLabel("c75").toUpperCase() + ' = ' + model.labelManager.getLabel("c76").toUpperCase() + ' + ' + model.labelManager.getLabel("c77").toUpperCase() + ' + ' + model.labelManager.getLabel("c78").toUpperCase() +  '</span>';
			if (target_text != null)	{
				target_text.removeChild(target_text_above);
				target_text.removeChild(target_text_below);
				removeChild(target_text);
			}
			target_text = new MovieClip();
			target_text_below = new TextField();
			target_text_below.autoSize = TextFieldAutoSize.LEFT;
			target_text_below.antiAliasType = AntiAliasType.ADVANCED;
			target_text_below.wordWrap = false;
			target_text_below.selectable = false;
			target_text_below.x = 32;
			target_text_below.y = 2;
			target_text_below.embedFonts = true;
			target_text = new MovieClip();
			target_text.x = 100;
			target_text.alpha = 0;
			addChild(target_text);
	
			target_text_below.styleSheet = css;
			target_text_below.htmlText = '<span class="style2"> </span>';
			target_text.addChild(target_text_above);
			target_text.addChild(target_text_below);
			target_text.addEventListener(Event.ENTER_FRAME, tgtTextEnterHandler,false,0,true);
			_target_line.useHandCursor = true;
			_target_line.buttonMode = true;
			addChild(_target_line);
		}		
		
		private function tgtTextEnterHandler(e:Event):void 
		{
			target_text.y = _target_line.y;
			if (!dragging && e.target.alpha > 0)	{
				TweenMax.to(e.target, .3, { alpha:0 } );
			}
			if (dragging && e.target.alpha < 1)	{
				TweenMax.to(e.target, .3, { alpha:1 } );
			}
			e.target.visible = (e.target.alpha > 0);
		}
		
		private function updateTargetLine() : void
		{
				
				var target:Number;
				var maxEnergyValue:Number = model.maxEnergyUsageValue();
				var scaledHeight:Number;
				switch(model.appState.currentScreen)
				{
					case Screens.OFFICE:
					{
						target = model.sensorData.pcInstantaneousPowerValue.targetValue + model.sensorData.printerInstantaneousPowerValue.targetValue + model.sensorData.plugableInstantaneousPowerValue.targetValue;
						target_line.y = 10 + _draggableRange - ((_draggableRange * ((target) / maxEnergyValue)));
						target_line.visible = model.sensorData.officeTargetsVisible;
						break;
					}
					case Screens.PCUSAGE:
					{
						target = model.sensorData.pcInstantaneousPowerValue.targetValue;
						target_line.y = 10 + _draggableRange - ((_draggableRange * ((target) / maxEnergyValue)));
						target_line.visible = model.sensorData.pcTargetsVisible;
						break;
					}
					case Screens.PRINTERUSAGE:
					{
						target = model.sensorData.printerInstantaneousPowerValue.targetValue;
						target_line.y = 10 + _draggableRange - ((_draggableRange * ((target) / maxEnergyValue)));
						target_line.visible = model.sensorData.printerTargetsVisible;
						break;
					}
					case Screens.PLUGGABLEUSAGE:
					{
						target = model.sensorData.plugableInstantaneousPowerValue.targetValue;
						target_line.y = 10 + _draggableRange - ((_draggableRange * ((target) / maxEnergyValue)));
						target_line.visible = model.sensorData.pluggableTargetsVisible;
						break;
					}
				}
				setChildIndex(_target_line, numChildren - 1);
				createTargetTooltip();
		}
		
		private function createTargetTooltip():void 
		{
			if (_tipClip != null)	{
				removeChild(_tipClip);
			}
			_tipClip = new MovieClip();
			with (_tipClip.graphics)	{
				lineStyle(1.5, 0x59a994, 1, true, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 10);
				beginFill(0x458769, 1);
				drawRoundRect(0, 0, 105, 52, 8);
				endFill();
			}
			var txt:String;
			if (model.appState.currentScreen == Screens.OFFICE)	{
				txt = model.labelManager.getLabel("c6").toUpperCase();
				_currentUnits = String(model.sensorData.officeIntantaneousPowerValue.targetValue) + ' ' + model.labelManager.getLabel("c74");
			}
			if (model.appState.currentScreen == Screens.PCUSAGE)	{
				txt = model.labelManager.getLabel("c7").toUpperCase();
				_currentUnits = String(model.sensorData.pcInstantaneousPowerValue.targetValue) + ' ' + model.labelManager.getLabel("c74");
			}
			if (model.appState.currentScreen == Screens.PRINTERUSAGE)	{
				txt = model.labelManager.getLabel("c8").toUpperCase();
				_currentUnits = String(model.sensorData.printerInstantaneousPowerValue.targetValue) + ' ' + model.labelManager.getLabel("c74");
			}
			if (model.appState.currentScreen == Screens.PLUGGABLEUSAGE)	{
				txt = model.labelManager.getLabel("c9").toUpperCase();
				_currentUnits = String(model.sensorData.plugableInstantaneousPowerValue.targetValue) + ' ' + model.labelManager.getLabel("c74");
			}
						
			_tipClip.tf1 = TextFieldHelper.createTextField(3, 3, 99, txt.toUpperCase(), "TIP_CATEGORY", TextStyles.USAGE_INSTRUCTIONS, TextFieldAutoSize.LEFT, false, true);
			_tipClip.addChild(_tipClip.tf1);
			_tipClip.tf2 = TextFieldHelper.createTextField(3, 3, 99, _currentUnits, "TIP_UNITS", TextStyles.USAGE_INSTRUCTIONS, TextFieldAutoSize.LEFT, false, true);
			_tipClip.tf2.y = _tipClip.tf1.y + _tipClip.tf1.height;
			
			_tipClip.tf3 = TextFieldHelper.createTextField(3, 3, 99, _dragText, "TIP_INSTRUCT", TextStyles.USAGE_INSTRUCTIONS, TextFieldAutoSize.LEFT, false, true);
			_tipClip.tf3.y = _tipClip.tf2.y + _tipClip.tf2.height + 5;
			
			_tipClip.addChild(_tipClip.tf2);
			_tipClip.addChild(_tipClip.tf3);
			_tipClip.x = this.mouseX - _tipClip.width - 5;
			_tipClip.y = this.mouseY + 5;
			_tipClip.alpha = 0;
			var ds:DropShadowFilter = new DropShadowFilter(3, 45, 0x000000, 1, 2, 2, .2, 2, false, false, false);
			tipClip.filters = [ds];
			addChild(_tipClip);
		}
		
		
		private function createLegend() : void
		{
			barChartLegend = new BarChartLegend(this);
			barChartLegend.x = 15;
			barChartLegend.y = 85;
			addChild(barChartLegend);
		}
		
		private function updateLegend() : void
		{
			barChartLegend.dispose();
			removeChild(barChartLegend);
			createLegend();
		}
		
		private function createBackground() : void
		{
			_background = new Loader();
			configureAssetListeners(_background.contentLoaderInfo);
			_background.load(new URLRequest(model.config.barChartBackgroundImageURL));
			addChild(_background);
			_background.y = -6;
			TweenMax.to(_background, .5, { alpha:1} );
		}		
		
		private function createBars() : void
		{
			//ADD THE BARS
			var xInc:Number = 125;
			var ec:EnergyComparison = model.getEnergyComparison(category);		
			var maxEnergyUsageValue:Number = model.maxEnergyUsageValue();		
			
			for (var j:Number = ec.weeklyEnergyConsumption.length-1; j > -1; j--)
			{
				//BAR
				var day_txt:String = model.lookupDayOfWeekAbbr(ec.weeklyEnergyConsumption[j].date.getDay());
				var bar:Bar = new Bar(xInc, _chartHeight, maxEnergyUsageValue, day_txt, false, j);	

				//CREATE MARKER DATA OBJECTS
				var department_md:MarkerData = model.getDailyValue(j, "department");
				var floor_md:MarkerData = model.getDailyValue(j, "floor");
				var building_md:MarkerData = model.getDailyValue(j, "building");
				
				//CREATE MARKERS
				var department:Marker = new Marker(xInc+5, _chartHeight, maxEnergyUsageValue, 0x5370ba, category, "department", false, j);
				var floor:Marker = new Marker(xInc+20, _chartHeight, maxEnergyUsageValue, 0x60c339, category, "floor", false, j);
				var building:Marker = new Marker(xInc + 35, _chartHeight, maxEnergyUsageValue, 0xe6921a, category, "building", false, j);
				department.y = 20;
				floor.y = 20;
				building.y = 20;
				
				xInc += 50;
				 
				addChild(bar);
				addChild(department);
				addChild(floor);
				addChild(building);
			}
			
			//AVERAGE
			xInc += 18;
			
			var department_marker:Marker = new Marker(xInc+5, _chartHeight, maxEnergyUsageValue, 0x5370ba, category, "department", true);
			var floor_marker:Marker = new Marker(xInc+20, _chartHeight, maxEnergyUsageValue, 0x60c339, category, "floor", true);
			var building_marker:Marker = new Marker(xInc+35, _chartHeight, maxEnergyUsageValue, 0xe6921a, category, "building", true);			
			department_marker.y = 20;
			floor_marker.y = 20;
			building_marker.y = 20;
			//CREATE AVARAGE BAR
			var average_bar:Bar = new Bar(xInc, _chartHeight, maxEnergyUsageValue, model.labelManager.getLabel("c11"), true);
			
			addChild(average_bar);
			addChild(department_marker);
			addChild(floor_marker);
			addChild(building_marker);
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
			var msg:String='Comfort image not loaded: '+event.text;
			trace(msg);
		}
		
		public function get target_line():Sprite 
		{
			return _target_line;
		}
		
		public function set target_line(value:Sprite):void 
		{
			_target_line = value;
		}
		
		public function get background():Loader 
		{
			return _background;
		}
		
		public function set background(value:Loader):void 
		{
			_background = value;
		}
		
		public function get chartHeight():Number 
		{
			return _chartHeight;
		}
		
		public function set chartHeight(value:Number):void 
		{
			_chartHeight = value;
		}
		
		public function get usageView():* 
		{
			return _usageView;
		}
		
		public function set usageView(value:*):void 
		{
			_usageView = value;
		}
		
		public function get tipClip():MovieClip 
		{
			return _tipClip;
		}
		
		public function set tipClip(value:MovieClip):void 
		{
			_tipClip = value;
		}
		
		public function get shade():Sprite 
		{
			return _shade;
		}
		
		public function set shade(value:Sprite):void 
		{
			_shade = value;
		}
		
		public function get shadeMinimum():Number 
		{
			return _shadeMinimum;
		}
		
		public function set shadeMinimum(value:Number):void 
		{
			_shadeMinimum = value;
		}
		
		public function get draggableRange():Number 
		{
			return _draggableRange;
		}
		
		public function set draggableRange(value:Number):void 
		{
			_draggableRange = value;
		}
	}
}
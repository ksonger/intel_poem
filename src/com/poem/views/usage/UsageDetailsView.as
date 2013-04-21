package com.poem.views.usage 
{
	
	import com.greensock.events.LoaderEvent;
	import com.greensock.TweenMax;
	import com.poem.constants.EnergyCategory;
	import com.poem.constants.Screens;
	import com.poem.constants.TextStyles;
	import com.poem.helpers.MarkerToolTipHelper;
	import com.poem.helpers.SpriteHelper;
	import com.poem.helpers.TextFieldHelper;
	import com.poem.interfaces.IDisposable;
	import com.poem.interfaces.IInitializable;
	import com.poem.models.MarkerData;
	import com.poem.models.PoemModel;
	import com.poem.signals.AddMarkerToolTipSignal;
	import com.poem.signals.RemoveMarkerToolTipSignal;
	import com.poem.signals.UpdateUsageScreenSignal;
	import com.poem.views.dashboard.DashboardStatusSprite;
	import com.poem.views.dashboard.DashboardStatusSpriteOfficeTotal;
	import com.poem.views.dashboard.DashboardStatusSpritePC;
	import com.poem.views.dashboard.DashboardStatusSpritePluggable;
	import com.poem.views.dashboard.DashboardStatusSpritePrinter;
	import com.poem.views.dashboard.DashboardStatusSpriteSmall;
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.text.TextFieldAutoSize;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.net.URLRequest;
	
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class UsageDetailsView extends Sprite implements IDisposable, IInitializable
	{
		[Inject]
		public var model:PoemModel;
		
		[Inject]
		public var addMarkerToolTipSignal:AddMarkerToolTipSignal;
		
		[Inject]
		public var removeMarkerToolTipSignal:RemoveMarkerToolTipSignal;	

		[Inject]
		public var updateScreen:UpdateUsageScreenSignal;		
		
		private var category:String;
		private var toolTip:MarkerToolTipHelper;
		private var status:DashboardStatusSprite;
		private var pluggables:Pluggables;
		public var instructionsClip:MovieClip;
		public var barChart:BarChart;
		private var _appView:*;
		private var _instructionsText1:String;
		private var _instructionsText2:String;
		private var ev_image:MovieClip;
		
		
		public function UsageDetailsView(category:String, appView:*)
		{
			this.category = category;
			_appView = appView;
		}
		
		public function initialize() : void
		{
			_instructionsText1 = model.labelManager.getLabel("c62");
			_instructionsText2 = model.labelManager.getLabel("c63");
			updateScreen.add(updateScreenHandler);
			addMarkerToolTipSignal.add(addMarkerToolTipSignalHandler);
			removeMarkerToolTipSignal.add(removeMarkerToolTipSignalHandler);
			
			createBackground();
			createStatus();
			createBarChart();
			createEnergyStatus();
			createEnergySummary();
			createLimitInstructions();
			createPluggables();
			if (category == Screens.PLUGGABLEUSAGE) pluggables.alpha = 1;
		}
		
		
		
		private function createLimitInstructions():void 
		{
			instructionsClip = new MovieClip();
			with (instructionsClip.graphics)	{
				lineStyle(1.5, 0x59a994, 1, true, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 10);
				beginFill(0x458769, 1);
				drawRoundRect(0, 0, 180, 52, 8);
				endFill();
			}
			
			instructionsClip.tf1 = TextFieldHelper.createTextField(3, 3, 174, _instructionsText1, "TARGET_INSTRUCTIONS1", TextStyles.USAGE_INSTRUCTIONS, TextFieldAutoSize.LEFT, false, true);
			instructionsClip.addChild(instructionsClip.tf1);
			instructionsClip.tf2 = TextFieldHelper.createTextField(3, 3, 174, _instructionsText2, "TARGET_INSTRUCTIONS2", TextStyles.USAGE_INSTRUCTIONS, TextFieldAutoSize.LEFT, false, true);
			instructionsClip.tf2.y = instructionsClip.tf1.y + instructionsClip.tf1.height + 5;
			instructionsClip.addChild(instructionsClip.tf2);
			instructionsClip.x = 420;
			instructionsClip.y = 13;
			instructionsClip.visible = false;
			instructionsClip.addEventListener(Event.ENTER_FRAME, instructionsEnterHandler,false,0,true);
			addChild(instructionsClip);
		}
		
		private function instructionsEnterHandler(e:Event):void 
		{
			try 
			{
				
				e.target.visible = barChart.shade.visible;
			} 
			catch (err:Error) 
			{
				
			}
		}

		private function updateScreenHandler() : void
		{
			if (this.contains(status)) removeChild(status);
			createStatus();		
			
			if (model.appState.currentScreen == Screens.PLUGGABLEUSAGE) {
				pluggables.alpha = 1;
			} else {
				pluggables.alpha = 0;	
			}
		}		
		
		private function removeMarkerToolTipSignalHandler() : void
		{
			removeChild(toolTip);		
		}
		
		private function addMarkerToolTipSignalHandler(md:MarkerData) : void
		{
			var label:String = md.tooltip;
			toolTip = new MarkerToolTipHelper(label);
			toolTip.x = mouseX + 5;
			toolTip.y = mouseY + 5;
			if (mouseX > 650) toolTip.x = toolTip.x - 100;
			
			toolTip.alpha = 0;
			TweenMax.to(toolTip, .25, {alpha:1, delay:.15} );
			addChild(toolTip);			
		}
		
		private function createStatus() : void
		{
			
			//switch(category)
			switch(model.appState.currentScreen)
			{
				case Screens.DASHBOARD:
				{
					break;
				}
				case Screens.OFFICE:
				{
					status = new DashboardStatusSpriteOfficeTotal();
					break;
				}					
				case Screens.PCUSAGE:
				{
					status = new DashboardStatusSpritePC();
					break;
				}
				case Screens.PRINTERUSAGE:
				{
					status = new DashboardStatusSpritePrinter();
					break;
				}
				case Screens.PLUGGABLEUSAGE:
				{
					status = new DashboardStatusSpritePluggable();
					break;
				}
				case Screens.EVUSAGE:
				{
					break;
				}
			}

			
			status.x = 160;
			status.y = 5;
			status.scaleX = .85;
			status.scaleY = .85;
			addChildAt(status, 1);
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
	
		
		private function createPluggables() : void
		{
			//var pluggables:Pluggables = new Pluggables();
			pluggables = new Pluggables();
			pluggables.x = 10;
			pluggables.y = 5;
			pluggables.alpha = 0;
			addChild(pluggables);
		}		
		
		private function createBackground() : void
		{
			var background:Loader = new Loader();
			background.load(new URLRequest(model.config.usageBackgroundImageURL));
			addChild(background);
			TweenMax.to(background, .5, { alpha:1} );
		}
		
		private function createBarChart() : void
		{
			if (barChart != null)	{
				removeChild(barChart);
			}

			barChart = new BarChart(150, this.category, this);
			barChart.x = 160;
			barChart.y = 87;
			addChild(barChart);
		}
		
		private function createEnergySummary() : void
		{
		}
		
		private function createEnergyStatus() : void
		{
		}
		
		public function dispose() : void
		{
			while (numChildren > 0) removeChildAt(0);
			
			updateScreen.remove(updateScreenHandler);
			addMarkerToolTipSignal.remove(addMarkerToolTipSignalHandler);
			removeMarkerToolTipSignal.remove(removeMarkerToolTipSignalHandler);			
			
			model = null;
		}
		
		public function get appView():* 
		{
			return _appView;
		}
		
		public function set appView(value:*):void 
		{
			_appView = value;
		}
	}
}
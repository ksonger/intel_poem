package com.poem.mediators.usage 
{
	import com.greensock.TweenMax;
	import com.poem.constants.Screens;
	import com.poem.constants.TextStyles;
	import com.poem.helpers.TextFieldHelper;
	import com.poem.models.PoemModel;
	import com.poem.signals.PoemTargetUpdatedSignal;
	import com.poem.views.usage.BarChart;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextFieldAutoSize;
	import org.robotlegs.mvcs.Mediator;
	import flash.utils.*;
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class BarChartMediator extends Mediator
	{
		private var dragging:Boolean = false;
		private var tInt:Number;
		private var wInt:Number;
		private var maxValue:Number;
		[Inject]
		public var view:BarChart;
		
		[Inject]
		public var model:PoemModel;
		
		[Inject]
		public var targetUpdated:PoemTargetUpdatedSignal;
		
		override public function onRegister():void 
		{
			view.initialize();
			maxValue = model.maxEnergyUsageValue();
			view.target_line.addEventListener(MouseEvent.MOUSE_DOWN, targetPressHandler,false,0,true);
			view.target_line.addEventListener(MouseEvent.MOUSE_OVER, targetOverHandler,false,0,true);
			view.usageView.appView.addEventListener(MouseEvent.MOUSE_UP, targetReleaseHandler,false,0,true);
			view.tipClip.addEventListener(Event.ENTER_FRAME, tipEnterHandler,false,0,true);
			view.addEventListener(Event.ENTER_FRAME, enterHandler,false,0,true);
			view.addEventListener(MouseEvent.MOUSE_MOVE, targetOutHandler,false,0,true);
			view.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler,false,0,true);
		}
		
		private function mouseWheelHandler(e:MouseEvent):void 
		{
			if (model.appState.currentScreen == Screens.OFFICE || model.appState.currentScreen == Screens.PCUSAGE || model.appState.currentScreen == Screens.PRINTERUSAGE)	
			{
				if (view.target_line.visible) 
				{
					clearTimeout(tInt);
					clearTimeout(wInt);
					clearTimeout(model.tInt);
					maxValue = model.maxEnergyUsageValue();
					var ypos:Number = view.target_line.y - e.delta*1.5;
					if (ypos < 10) {
						ypos = 10;
					}
					if (ypos > 170) {
						ypos = 170;
					}
					TweenMax.to(view.target_line, .2, { y:ypos } );
					dragging = true;
					view.dragging = true;
					enterHandler(new Event(Event.ENTER_FRAME));
					view.tipClip.removeChild(view.tipClip.tf2);
					var txt:String;
					switch(model.appState.currentScreen)
					{
						case Screens.OFFICE:
						{
							txt = String(model.sensorData.officeIntantaneousPowerValue.targetValue) + ' ' + model.labelManager.getLabel("c74");
							view.tipClip.tf2 = TextFieldHelper.createTextField(3, 3, 99, txt, "TIP_CATEGORY", TextStyles.USAGE_INSTRUCTIONS, TextFieldAutoSize.LEFT, false, true);
							view.tipClip.tf2.y = view.tipClip.tf1.y + view.tipClip.tf1.height;
							view.tipClip.addChild(view.tipClip.tf2);
							break;
						}
						case Screens.PCUSAGE:
						{
							txt = String(model.sensorData.pcInstantaneousPowerValue.targetValue) + ' ' + model.labelManager.getLabel("c74");
							view.tipClip.tf2 = TextFieldHelper.createTextField(3, 3, 99, txt, "TIP_CATEGORY", TextStyles.USAGE_INSTRUCTIONS, TextFieldAutoSize.LEFT, false, true);
							view.tipClip.tf2.y = view.tipClip.tf1.y + view.tipClip.tf1.height;
							view.tipClip.addChild(view.tipClip.tf2);
							break;
						}
						case Screens.PRINTERUSAGE:
						{
							txt = String(model.sensorData.printerInstantaneousPowerValue.targetValue) + ' ' + model.labelManager.getLabel("c74");
							view.tipClip.tf2 = TextFieldHelper.createTextField(3, 3, 99, txt, "TIP_CATEGORY", TextStyles.USAGE_INSTRUCTIONS, TextFieldAutoSize.LEFT, false, true);
							view.tipClip.tf2.y = view.tipClip.tf1.y + view.tipClip.tf1.height;
							view.tipClip.addChild(view.tipClip.tf2);
							break;
						}
						case Screens.PLUGGABLEUSAGE:
						{
							txt = String(model.sensorData.plugableInstantaneousPowerValue.targetValue) + ' ' + model.labelManager.getLabel("c74");
							view.tipClip.tf2 = TextFieldHelper.createTextField(3, 3, 99, txt, "TIP_CATEGORY", TextStyles.USAGE_INSTRUCTIONS, TextFieldAutoSize.LEFT, false, true);
							view.tipClip.tf2.y = view.tipClip.tf1.y + view.tipClip.tf1.height;
							view.tipClip.addChild(view.tipClip.tf2);
							break;
						}
					}
				
					model.targetUpdateSend = true;
					wInt = setTimeout(draggingToFalse, 1000);
				}
			}
		}
		
		private function draggingToFalse():void 
		{
			try 
			{
				clearTimeout(wInt);
				dragging = false;
				view.dragging = false;
			} 
			catch (err:Error) 
			{
				
			}
		}
		
		private function enterHandler(e:Event):void 
		{
			if (dragging) 
			{
				
				try 
				{
						if (view.target_line.y > 10 && view.target_line.y < 170) 
						{
							var val:Number;
							if (model.appState.currentScreen == Screens.OFFICE)	{
								
								var totalNum:Number = model.sensorData.pcInstantaneousPowerValue.targetValue + model.sensorData.printerInstantaneousPowerValue.targetValue + model.sensorData.plugableInstantaneousPowerValue.targetValue;
								var pcPct:Number = model.sensorData.pcInstantaneousPowerValue.targetValue / totalNum;
								var printerPct:Number = model.sensorData.printerInstantaneousPowerValue.targetValue / totalNum;
								var pluggablePct:Number = model.sensorData.plugableInstantaneousPowerValue.targetValue / totalNum;
								val = maxValue - (maxValue * ((view.target_line.y - 10)/view.draggableRange));
								model.sensorData.officeIntantaneousPowerValue.targetValue = Math.round(val);
								model.sensorData.pcInstantaneousPowerValue.targetValue = Math.round(val * pcPct);
								model.sensorData.printerInstantaneousPowerValue.targetValue = Math.round(val * printerPct);
								model.sensorData.plugableInstantaneousPowerValue.targetValue = Math.round(val * pluggablePct);
							}	else 
							{
								if (model.appState.currentScreen == Screens.PCUSAGE)	{
									val = maxValue - (maxValue * ((view.target_line.y - 10)/view.draggableRange));
									model.sensorData.pcInstantaneousPowerValue.targetValue = Math.round(val);
									model.sensorData.officeIntantaneousPowerValue.targetValue = Math.round(model.sensorData.pcInstantaneousPowerValue.targetValue + model.sensorData.printerInstantaneousPowerValue.targetValue +model.sensorData.plugableInstantaneousPowerValue.targetValue);
								}
								if (model.appState.currentScreen == Screens.PRINTERUSAGE)	{
									val = maxValue - (maxValue * ((view.target_line.y - 10)/view.draggableRange));
									model.sensorData.printerInstantaneousPowerValue.targetValue = Math.round(val);
									model.sensorData.officeIntantaneousPowerValue.targetValue = Math.round(model.sensorData.pcInstantaneousPowerValue.targetValue + model.sensorData.printerInstantaneousPowerValue.targetValue +model.sensorData.plugableInstantaneousPowerValue.targetValue);
								}
								if (model.appState.currentScreen == Screens.PLUGGABLEUSAGE)	{
									val = maxValue - (maxValue * ((view.target_line.y - 10)/view.draggableRange));
									model.sensorData.plugableInstantaneousPowerValue.targetValue = Math.round(val);
									model.sensorData.officeIntantaneousPowerValue.targetValue = Math.round(model.sensorData.pcInstantaneousPowerValue.targetValue + model.sensorData.printerInstantaneousPowerValue.targetValue +model.sensorData.plugableInstantaneousPowerValue.targetValue);
								}	
								if (model.sensorData.officeIntantaneousPowerValue.targetValue > maxValue)	{
									model.sensorData.rawData.currentEnergyConsumption[3].office[5].targetValue = model.sensorData.officeIntantaneousPowerValue.targetValue;
								}
							}
									
						
							if (model.appState.currentScreen == Screens.OFFICE)	{
								view.target_text_below.htmlText = "<span class='style3'>" + String(model.sensorData.officeIntantaneousPowerValue.targetValue) + "WH = </span><span class='style2'>" + String(model.sensorData.pcInstantaneousPowerValue.targetValue) + "WH + " + String(model.sensorData.printerInstantaneousPowerValue.targetValue) + "WH + " + String(model.sensorData.plugableInstantaneousPowerValue.targetValue) + "WH</span>";
							}
							if (model.appState.currentScreen == Screens.PCUSAGE)	{
								view.target_text_below.htmlText = "<span class='style2'>" + String(model.sensorData.officeIntantaneousPowerValue.targetValue) + "WH = </span><span class='style3'>" + String(model.sensorData.pcInstantaneousPowerValue.targetValue) + "WH</span><span class='style2'> + " + String(model.sensorData.printerInstantaneousPowerValue.targetValue) + "WH + " + String(model.sensorData.plugableInstantaneousPowerValue.targetValue) + "WH</span>";
							}
							if (model.appState.currentScreen == Screens.PRINTERUSAGE)	{
								view.target_text_below.htmlText = "<span class='style2'>" + String(model.sensorData.officeIntantaneousPowerValue.targetValue) + "WH = " + String(model.sensorData.pcInstantaneousPowerValue.targetValue) + "WH + </span><span class='style3'>" + String(model.sensorData.printerInstantaneousPowerValue.targetValue) + "WH</span><span class='style2'> + " + String(model.sensorData.plugableInstantaneousPowerValue.targetValue) + "WH</span>";
							}
							if (model.appState.currentScreen == Screens.PLUGGABLEUSAGE)	{
								view.target_text_below.htmlText = "<span class='style2'>" + String(model.sensorData.officeIntantaneousPowerValue.targetValue) + "WH = " + String(model.sensorData.pcInstantaneousPowerValue.targetValue) + "WH + " + String(model.sensorData.printerInstantaneousPowerValue.targetValue) + "WH + </span><span class='style3'>" + String(model.sensorData.plugableInstantaneousPowerValue.targetValue) + "WH</span>";
							}
						}

				} 
				catch (err:Error) 
				{
					trace(dragging + ' ' + err);
				}
			}
		}
	
		private function tipEnterHandler(e:Event):void 
		{
			try 
			{
				view.tipClip.visible = (view.tipClip.alpha > 0);
			} 
			catch (err:Error) 
			{
				
			}
		}
		
		private function targetOutHandler(e:MouseEvent):void 
		{
			try 
			{
				TweenMax.to(view.tipClip, .3, { alpha:0 } );
			} 
			catch (err:Error) 
			{
				
			}
		}
		
		private function targetOverHandler(e:MouseEvent):void 
		{
			try 
			{
				clearTimeout(tInt);
				view.tipClip.x = view.mouseX - view.tipClip.width - 5;
				view.tipClip.y = view.mouseY + 5;
				tInt = setTimeout(showTip, 500);
			} 
			catch (err:Error) 
			{
				
			}
		}
		
		private function showTip():void 
		{
			try 
			{
				clearTimeout(tInt);
				view.tipClip.removeChild(view.tipClip.tf1);
				var txt:String;
				if (model.appState.currentScreen == Screens.OFFICE)	{
					txt = model.labelManager.getLabel("c6").toUpperCase();
				}
				if (model.appState.currentScreen == Screens.PCUSAGE)	{
					txt = model.labelManager.getLabel("c7").toUpperCase();
				}
				if (model.appState.currentScreen == Screens.PRINTERUSAGE)	{
					txt = model.labelManager.getLabel("c8").toUpperCase();
				}
				if (model.appState.currentScreen == Screens.PLUGGABLEUSAGE)	{
					txt = model.labelManager.getLabel("c9").toUpperCase();
				}
				view.tipClip.tf1 = TextFieldHelper.createTextField(3, 3, 99, txt.toUpperCase(), "TIP_CATEGORY", TextStyles.USAGE_INSTRUCTIONS, TextFieldAutoSize.LEFT, false, true);
				view.tipClip.addChild(view.tipClip.tf1);
			
				if (!dragging && view.mouseY >= view.target_line.y-8 && view.mouseY <=view.target_line.y + view.target_line.height && view.mouseX >= view.target_line.x && view.mouseX <= view.target_line.x + view.target_line.width)	{
					TweenMax.to(view.tipClip, .3, { alpha:1 } );
				}	else 
				{
					if (!isNaN(tInt))	{
						TweenMax.to(view.tipClip, .1, { alpha:0 } );
					}
				}
			} 
			catch (err:Error) 
			{
				
			}
		}
		
		
		private function targetPressHandler(e:MouseEvent):void 
		{
			
			
			try 
			{
				clearTimeout(tInt);
				clearTimeout(model.tInt);
				maxValue = model.maxEnergyUsageValue();
				dragging = true;
				view.dragging = true;
				TweenMax.to(view.tipClip, .3, { alpha:0 } );
				var rect:Rectangle = new Rectangle(view.target_line.x, 10, 0, 160);
				e.target.startDrag(false, rect);
			} 
			catch (err:Error) 
			{
				trace('here: ' + err);
			}
		}
		private function targetReleaseHandler(e:MouseEvent):void 
		{
			//sensorData.rawData.currentEnergyConsumption[3].office[5].targetValue
				try 
				{
					if (dragging) 
					{
						clearTimeout(tInt);
						view.target_line.stopDrag();
						var val:Number;
				
						view.tipClip.removeChild(view.tipClip.tf2);
						var txt:String;
						switch(model.appState.currentScreen)
						{
							case Screens.OFFICE:
							{
								txt = String(model.sensorData.officeIntantaneousPowerValue.targetValue) + ' ' + model.labelManager.getLabel("c74");
								view.tipClip.tf2 = TextFieldHelper.createTextField(3, 3, 99, txt, "TIP_CATEGORY", TextStyles.USAGE_INSTRUCTIONS, TextFieldAutoSize.LEFT, false, true);
								view.tipClip.tf2.y = view.tipClip.tf1.y + view.tipClip.tf1.height;
								view.tipClip.addChild(view.tipClip.tf2);
								break;
							}
							case Screens.PCUSAGE:
							{
								txt = String(model.sensorData.pcInstantaneousPowerValue.targetValue) + ' ' + model.labelManager.getLabel("c74");
								view.tipClip.tf2 = TextFieldHelper.createTextField(3, 3, 99, txt, "TIP_CATEGORY", TextStyles.USAGE_INSTRUCTIONS, TextFieldAutoSize.LEFT, false, true);
								view.tipClip.tf2.y = view.tipClip.tf1.y + view.tipClip.tf1.height;
								view.tipClip.addChild(view.tipClip.tf2);
								break;
							}
							case Screens.PRINTERUSAGE:
							{
								txt = String(model.sensorData.printerInstantaneousPowerValue.targetValue) + ' ' + model.labelManager.getLabel("c74");
								view.tipClip.tf2 = TextFieldHelper.createTextField(3, 3, 99, txt, "TIP_CATEGORY", TextStyles.USAGE_INSTRUCTIONS, TextFieldAutoSize.LEFT, false, true);
								view.tipClip.tf2.y = view.tipClip.tf1.y + view.tipClip.tf1.height;
								view.tipClip.addChild(view.tipClip.tf2);
								break;
							}
							case Screens.PLUGGABLEUSAGE:
							{
								txt = String(model.sensorData.plugableInstantaneousPowerValue.targetValue) + ' ' + model.labelManager.getLabel("c74");
								view.tipClip.tf2 = TextFieldHelper.createTextField(3, 3, 99, txt, "TIP_CATEGORY", TextStyles.USAGE_INSTRUCTIONS, TextFieldAutoSize.LEFT, false, true);
								view.tipClip.tf2.y = view.tipClip.tf1.y + view.tipClip.tf1.height;
								view.tipClip.addChild(view.tipClip.tf2);
								break;
							}
						}
			
						model.targetUpdateSend = true;
						dragging = false;
						view.dragging = false;
						clearTimeout(model.tInt);
						model.tInt = setTimeout(targetUpdated.dispatch, 30000);
					}
				} 
				catch (err:Error) 
				{
					
				}
		}
		
		override public function onRemove():void 
		{
			view.dispose();
			view = null;
		}
	}
}
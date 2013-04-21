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
	public class DashboardView extends Sprite implements IDisposable, IInitializable
	{
		[Inject]
		public var model:PoemModel;
		
		[Inject]
		public var targetAlertsUpdated:TargetAlertsUpdatedSignal;
		
		private var ev_status:DashboardStatusEv;
		private var office_status:DashboardStatusOffice;
		
		private var on_line:Sprite;
		private var off_circle:Sprite;
		
		private var tipClip:MovieClip;
		
		private var toggleClip:MovieClip;
		
		private var toggle_handle:Loader = new Loader();
		private var toggle_background:Loader = new Loader();
		private var toggle_state:String = 'on';
		
		private var index:Number;
		private var tInt:Number;
		
		
		public function initialize() : void
		{
			createStatusOffice();
			createStatusEv();
			createAlertsToggle();
			createTargetTooltip();
			addToStage();
		}
		
		private function createAlertsToggle():void 
		{
			
			toggleClip = new MovieClip();
			toggleClip.x = 125;
			toggleClip.y = 414;
			addChild(toggleClip);
			
			toggleClip.txt = TextFieldHelper.createTextField(0, 0, 90, model.labelManager.getLabel("c65").toUpperCase(), "TOGGLE_LABEL", TextStyles.TOGGLE_LABEL, TextFieldAutoSize.LEFT);
			toggleClip.addChild(toggleClip.txt);
			toggleClip.hitarea = new Sprite();
			toggleClip.addChild(toggleClip.hitarea);
			with (toggleClip.hitarea.graphics)	{
				beginFill(0xFF0000, 0);
				drawRect(0, 0, 90, toggleClip.txt.height);
				endFill();
			}
			toggleClip.hitarea.useHandCursor = true;
			toggleClip.hitarea.buttonMode = true;
			
			toggle_handle.load(new URLRequest(model.config.usagePluggableToggleHandleImageURL));
			toggle_handle.x = 106;
			toggle_handle.y = 4;
			
			toggle_background.load(new URLRequest(model.config.usagePluggableToggleBackgroundImageURL));
			toggle_background.x = 103;
			toggle_background.y = 0;
						
			on_line = new Sprite();
			on_line.graphics.lineStyle(3, 0xa7a9ac, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 10);
			on_line.graphics.moveTo(117, 7);
			on_line.graphics.lineTo(117, 20);
			
			off_circle = new Sprite();
			off_circle.graphics.lineStyle(3, 0xa7a9ac, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 10);
			off_circle.graphics.drawCircle(143, 14, 6);
			off_circle.graphics.endFill();
			
			toggleClip.addChild(toggle_background);
			
			toggleClip.addChild(on_line);
			toggleClip.addChild(off_circle);
			toggleClip.addChild(toggle_handle);
			
			
			toggleClip.useHandCursor = true;
			toggleClip.buttonMode = true;
			
			toggleClip.hitarea.addEventListener(MouseEvent.ROLL_OVER, targetOverHandler,false,0,true);
			toggleClip.hitarea.addEventListener(MouseEvent.ROLL_OUT, targetOutHandler,false,0,true);
			toggleClip.addEventListener(MouseEvent.CLICK, toggleClick,false,0,true);
			
			
			if (model.sensorData.notificationsDisabled == false && toggle_state == 'off')	{
				toggleClick(new MouseEvent(MouseEvent.CLICK));
			}
			if (model.sensorData.notificationsDisabled == true && toggle_state == 'on')	{
				toggleClick(new MouseEvent(MouseEvent.CLICK));
			}
		}	
		
		private function createTargetTooltip():void 
		{
			tipClip = new MovieClip();
			with (tipClip.graphics)	{
				lineStyle(1.5, 0x59a994, 1, true, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 10);
				beginFill(0x458769, 1);
				drawRoundRect(0, 0, 190, 65, 8);
				endFill();
			}
			
			tipClip.tf1 = TextFieldHelper.createTextField(3, 3, 175, model.labelManager.getLabel("c69"), "TIP1", TextStyles.USAGE_INSTRUCTIONS, TextFieldAutoSize.LEFT, false, true);
			tipClip.addChild(tipClip.tf1);
			tipClip.tf2 = TextFieldHelper.createTextField(3, 3, 175, model.labelManager.getLabel("c70"), "TIP2", TextStyles.USAGE_INSTRUCTIONS, TextFieldAutoSize.LEFT, false, true);
			tipClip.tf2.y = tipClip.tf1.y + tipClip.tf1.height + 5;
			tipClip.addChild(tipClip.tf2);
			
			tipClip.x = this.mouseX - tipClip.width - 5;
			tipClip.y = this.mouseY + 5;
			tipClip.alpha = 0;
			var ds:DropShadowFilter = new DropShadowFilter(3, 45, 0x000000, 1, 2, 2, .2, 2, false, false, false);
			tipClip.filters = [ds];
		}
		
		public function toggleClick(e:MouseEvent) : void
		{			
			if (toggle_state == "off"){ 
				TweenMax.to(toggle_background, .25, {colorTransform:{tint:0x8a8c8e, tintAmount:0}});
				toggle_handle.x = 106;	
				toggle_state = "on";
				on_line.alpha = 0;
				off_circle.alpha = 1;
			} else {
				TweenMax.to(toggle_background, .25, {colorTransform:{tint:0x8a8c8e, tintAmount:1}});
				toggle_handle.x = 134;
				toggle_state = "off";
				on_line.alpha = 1;
				off_circle.alpha = 0;
			}	
			model.sensorData.notificationsDisabled = (toggle_state == 'off');
			targetAlertsUpdated.dispatch();
			model.sensorData.notificationsDisabled = (toggle_state == 'off');
			try 
			{
				office_status.status.showHideTarget();
			} 
			catch (err:Error) 
			{
				
			}
		}
		
		private function tipEnterHandler(e:Event):void 
		{
			try 
			{
				tipClip.visible = (tipClip.alpha > 0);
			} 
			catch (err:Error) 
			{
				
			}
		}
		
		private function targetOutHandler(e:MouseEvent):void 
		{
			try 
			{
				TweenMax.to(tipClip, .3, { alpha:0 } );
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
				tipClip.x = mouseX - (tipClip.width/2);
				tipClip.y = toggleClip.y - tipClip.height - 10;
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
				if (mouseY >= toggleClip.y && mouseY <=toggleClip.y + toggleClip.height && mouseX >= toggleClip.x && mouseX <= toggleClip.x + toggleClip.width)	{
					TweenMax.to(tipClip, .3, { alpha:1 } );
				}	else 
				{
					if (!isNaN(tInt))	{
						TweenMax.to(tipClip, .1, { alpha:0 } );
					}
				}
			} 
			catch (err:Error) 
			{
				
			}
		}
		
		
		
		

		public function dispose() : void
		{
			while (numChildren > 0)
				removeChildAt(0);
			
			model = null;
		}
		
		private function addToStage() : void
		{
			addChild(office_status);	
			addChild(ev_status);
			addChild(tipClip);
		}		

		
		private function createStatusOffice() : void
		{
			office_status = new DashboardStatusOffice();
			office_status.x = 105;
			office_status.y = 150;			
		}			
		
		private function createStatusEv() : void
		{
			ev_status = new DashboardStatusEv();
			ev_status.x = 500;
			ev_status.y = 150;			
		}		
		

	}
}
package com.poem.mediators.comfort 
{
	import com.greensock.TweenLite;
	import com.poem.constants.TextStyles;
	import com.poem.helpers.TextFieldHelper;
	import com.poem.models.PoemModel;
	import com.poem.signals.ComfortReadySignal;
	import com.poem.views.comfort.Comfort;
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.events.Event;
	import flash.text.TextFieldAutoSize;
	import flash.utils.*;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;

	/**
	 * ...
	 * @author Ken Songer
	 */
	public class ComfortMediator extends Mediator
	{
		[Inject]
		public var view:Comfort;
		
		[Inject]
		public var model:PoemModel;
		
		[Inject]
		public var comfortReady:ComfortReadySignal;
		
		
		override public function onRegister():void 
		{
			view.initialize();
			comfortReady.dispatch();
		}
		public function init():void {
			view.toolTip.addEventListener(Event.ENTER_FRAME, toolTipEnterHandler,false,0,true);
			view.submit.addEventListener(MouseEvent.CLICK, doSubmit,false,0,true);
			view.bg.addEventListener(MouseEvent.MOUSE_OVER, bgOver,false,0,true);
			view.arrow.addEventListener(MouseEvent.CLICK, arrowClickHandler,false,0,true);
			view.submitDialog.close.addEventListener(MouseEvent.CLICK, submittedCloseHandler,false,0,true);
			view.submitDialog.addEventListener(Event.ENTER_FRAME, submittedEnterHandler,false,0,true);
			for (var i:Number = 0; i < 3; i++)	{
				var c:String = '_cold' + String(i);
				var h:String = '_hot' + String(i);
				view[c].addEventListener(MouseEvent.MOUSE_OVER, iconOverHandler,false,0,true);
				view[c].addEventListener(MouseEvent.MOUSE_OUT, iconOutHandler,false,0,true);
				view[c].addEventListener(MouseEvent.CLICK, iconClickHandler,false,0,true);
				view[c].addEventListener(Event.ENTER_FRAME, iconEnterHandler,false,0,true);
				view[h].addEventListener(MouseEvent.MOUSE_OVER, iconOverHandler,false,0,true);
				view[h].addEventListener(MouseEvent.MOUSE_OUT, iconOutHandler,false,0,true);
				view[h].addEventListener(MouseEvent.CLICK, iconClickHandler,false,0,true);
				view[h].addEventListener(Event.ENTER_FRAME, iconEnterHandler,false,0,true);
			}
			view['_neutral'].addEventListener(MouseEvent.MOUSE_OVER, iconOverHandler,false,0,true);
			view['_neutral'].addEventListener(MouseEvent.MOUSE_OUT, iconOutHandler,false,0,true);
			view['_neutral'].addEventListener(MouseEvent.CLICK, iconClickHandler,false,0,true);
			view['_neutral'].addEventListener(Event.ENTER_FRAME, iconEnterHandler,false,0,true);
			
			view.hitarea.addEventListener(MouseEvent.CLICK, doExpand,false,0,true);
			view.addEventListener(Event.ENTER_FRAME, enterHandler,false,0,true);
		}
		
		private function submittedEnterHandler(e:Event):void 
		{
			e.target.visible = (e.target.alpha > 0);
			if (e.target.alpha > 0 && view.submittedDialogVisible == false)	{
				TweenLite.to(e.target, .3, { alpha:0 } );
			}
			if (e.target.alpha < 1 && view.submittedDialogVisible == true)	{
				TweenLite.to(e.target, .3, { alpha:1 } );
			}
		}
		
		private function submittedCloseHandler(e:MouseEvent):void 
		{
			view.submittedDialogVisible = false;
		}
		
		
		
		private function toolTipEnterHandler(e:Event):void 
		{
			view.toolTip.x = view.mouseX - (view.toolTip.width / 2);
			view.toolTip.y = view.mouseY - view.toolTip.height - 1;
			view.toolTip.visible = (view.toolTip.alpha > 0);
			view.toolTip.name_tf.x = 5;
			try 
			{
				with (view.toolTip.bg.graphics)	{
					clear();
					beginFill(0xFFFFFF, 1);
					drawRoundRect(0, 0, view.toolTip.name_tf.width+15, 20, 10);
					lineStyle(10, 0x17776f, 1, false, LineScaleMode.NONE, CapsStyle.SQUARE);
					endFill();
				}
			} 
			catch (err:Error) 
			{
				trace(err);
			}
		}
		private function doSubmit(e:MouseEvent):void 
		{
			view.selected = false;
			view.expanded = false;
			TweenLite.to(view.bg, .4, { width:95, x:50 } );
			for (var i:Number = 0; i < view.icons.length; i++)	{
				try 
				{
					view.icons[i].ldr.content.gotoAndStop(1);
				} 
				catch (err:Error) 
				{
					
				}
				view.icons[i].selected = false;
			}
			with (view['_neutral'].graphics)	{
				clear();
				lineStyle(4, 0xB6CAD1, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 10);
				moveTo(0, 0);
				lineTo(0, 25);
			}
			model.comfortLevel = view.comfortLevel;
			view.comfortLevel = 0;
			
			view.submitDialog.removeChild(view.submitDialog.tf);
			if (model.connected)	{
				view.submitted_txt = model.labelManager.getLabel("c61");
			}	else 
			{
				view.submitted_txt = model.labelManager.getLabel("c82");
			}
			view.submitDialog.tf = TextFieldHelper.createTextField(5, 18, 96, view.submitted_txt, "SUBMITTED", TextStyles.COMFORT_TOOLTIP, TextFieldAutoSize.CENTER, false,true);
			view.submitDialog.addChild(view.submitDialog.tf);
			
			with (view.submitDialog.bg.graphics)	{
				clear();
				lineStyle(1, 0xCCCCCC, 1, true, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 10);
				beginFill(0xFFFFFF, 1);
				drawRoundRect(0, 0, view.submitDialog.tf.width+15, view.submitDialog.tf.y + view.submitDialog.tf.height+8, 10);
				endFill();
			}
			
			view.submittedDialogVisible = true;
			//setTimeout(submittedCloseHandler, 4000, new MouseEvent(MouseEvent.CLICK));
		}
		private function bgOver(e:MouseEvent):void 
		{
			TweenLite.to(view.toolTip, .05, { alpha:0 } );
			clearTimeout(view.tInt);
		}
		private function arrowClickHandler(e:MouseEvent):void 
		{
			view.expanded = !view.expanded;
			if (!view.expanded)	{
				view.selected = false;
				view.expanded = false;
				var n:String = '_neutral';
				with (view[n].graphics)	{
					clear();
					beginFill(0xFF0000, 0);
					drawRect( -8, 0, 16, 25);
					endFill();
					lineStyle(4, 0xB6CAD1, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 10);
					moveTo(0, 0);
					lineTo(0, 25);
				}
				TweenLite.to(view.bg, .4, { width:95, x:50 } );
				for (var i:Number = 0; i < view.icons.length; i++)	{
					try 
					{
						view.icons[i].ldr.content.gotoAndStop(1);
					} 
					catch (err:Error) 
					{
						
					}
					view.icons[i].selected = false;
				}
			}
		}
		private function iconEnterHandler(e:Event):void 
		{

				e.target.visible = (e.target.alpha > 0);
				var iy:Number = 5;
				if (e.target.lvl == 0)	{
					iy = 8;
				}
				if (e.target.lvl < 0)	{
					iy = 3;
				}
				e.target.y = view.bg.height - e.target.height - iy;
				if (view.expanded)	{
					if (e.target.x != e.target.openx)	{
						TweenLite.to(e.target, .3, { x:e.target.openx, alpha:1 } );
					}
				}	else 
				{
					var a:Number = 1;
					
					if (e.target.lvl != 3 && e.target.lvl != -3 && e.target.lvl != 0)	{
						a = 0;
					}
					if (e.target.x != e.target.closex)	{
						TweenLite.to(e.target, .3, { x:e.target.closex, alpha:a } );
					}
				}
	
		}
		
		private function iconClickHandler(e:MouseEvent):void 
		{
			for (var i:Number = 0; i < view.icons.length; i++)	{
				view.icons[i].selected = false;
				if (view.icons[i].lvl != 0) 
				{
					view.icons[i].ldr.content.gotoAndStop(1);
				}	else	{
					with (view.icons[i].graphics)	{
						clear();
						beginFill(0xFF0000, 0);
						drawRect( -8, 0, 16, 25);
						endFill();
						lineStyle(4, 0xB6CAD1, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 10);
						moveTo(0, 0);
						lineTo(0, 25);
					}
				}
			}
			if (e.target.lvl != 0) 
			{
				e.target.ldr.content.gotoAndStop(2);
			}	else	{
				with (e.target.graphics)	{
					clear();
					beginFill(0xFF0000, 0);
					drawRect( -8, 0, 16, 25);
					endFill();
					lineStyle(4, 0x00A838, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 10);
					moveTo(0, 0);
					lineTo(0, 25);
				}
			}
			e.target.selected = true;
			view.selected = true;
			view.comfortLevel = e.target.lvl;
		}
		
		private function iconOutHandler(e:MouseEvent):void 
		{
			if (!e.target.selected) 
			{
				if (e.target.lvl != 0) 
				{
					e.target.ldr.content.gotoAndStop(1);
				}	else	{
					with (e.target.graphics)	{
						clear();
						beginFill(0xFF0000, 0);
						drawRect( -8, 0, 16, 25);
						endFill();
						lineStyle(4, 0xB6CAD1, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 10);
						moveTo(0, 0);
						lineTo(0, 25);
					}
				}
				TweenLite.to(view.toolTip, .05, { alpha:0 } );
				clearTimeout(view.tInt);
			}
		}
		
		private function iconOverHandler(e:MouseEvent):void 
		{
			try 
			{
				e.target.ldr.content.gotoAndStop(2);
			} 
			catch (err:Error) 
			{
				
			}
			if (e.target.lvl == -3)	{
				view.tip_txt = model.labelManager.getLabel("c54");
			}
			if (e.target.lvl == -2)	{
				view.tip_txt = model.labelManager.getLabel("c55");
			}
			if (e.target.lvl == -1)	{
				view.tip_txt = model.labelManager.getLabel("c56");
			}
			if (e.target.lvl == 0)	{
				view.tip_txt = model.labelManager.getLabel("c57");
			}
			if (e.target.lvl == 1)	{
				view.tip_txt = model.labelManager.getLabel("c58");
			}
			if (e.target.lvl == 2)	{
				view.tip_txt = model.labelManager.getLabel("c59");
			}
			if (e.target.lvl == 3)	{
				view.tip_txt = model.labelManager.getLabel("c60");
			}
			view.tInt = setTimeout(showTip, 1500);
			if (e.target.lvl == 0)	{
				with (view['_neutral'].graphics)	{
					clear();
					beginFill(0xFF0000, 0);
					drawRect( -8, 0, 16, 25);
					endFill();
					lineStyle(4, 0x00A838, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 10);
					moveTo(0, 0);
					lineTo(0, 25);
				}
			}
		}
		private function showTip():void 
		{
			view.toolTip.removeChild(view.toolTip.name_tf);
			view.toolTip.name_tf = TextFieldHelper.createTextField(5, 2, 50, view.tip_txt, "TIP", TextStyles.COMFORT_TOOLTIP, TextFieldAutoSize.CENTER);
			view.toolTip.addChild(view.toolTip.name_tf);
			TweenLite.to(view.toolTip, .3, { alpha:1 } );
		}
		
		private function doExpand(e:MouseEvent):void 
		{
			TweenLite.to(view.bg, .3, { width:246, x: -100 } );
			view.expanded = true;
		}
		
		private function enterHandler(e:Event):void 
		{
			try 
			{
				view.submit.visible = view.selected;
				view.hitarea.visible = !view.expanded;
				view.header.x = view.bg.x + 20;
				view.arrow.x = view.bg.x + 10;
				if (view.expanded && view.arrow.ldr.content.currentFrame == 1)	{
					view.arrow.ldr.content.gotoAndStop(2);
				}
				if (!view.expanded && view.arrow.ldr.content.currentFrame == 2)	{
					view.arrow.ldr.content.gotoAndStop(1);
				}
			} 
			catch (err:Error) 
			{
				
			}
		}
		
		override public function onRemove():void 
		{
			view.dispose();
		}
				
	}
}
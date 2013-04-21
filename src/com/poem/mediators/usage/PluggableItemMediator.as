package com.poem.mediators.usage 
{
	import com.poem.views.usage.PluggableItem;
	import org.robotlegs.mvcs.Mediator;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class PluggableItemMediator extends Mediator
	{
		[Inject]
		public var view:PluggableItem;	
		
		override public function onRegister():void 
		{
			view.initialize();
			view.mouseChildren = false;
			setListeners(true);
		}
		
		override public function onRemove():void 
		{
			setListeners(false);
			view.dispose();
			view = null;
		}
		
		private function setListeners(b:Boolean):void{
			// EVENT LISTENERS
			if (b == true){
				view.addEventListener(MouseEvent.ROLL_OVER, rollOver,false,0,true);
				view.addEventListener(MouseEvent.ROLL_OUT, rollOut,false,0,true);
				view.addEventListener(MouseEvent.CLICK, click,false,0,true);	
			} else {
				view.removeEventListener(MouseEvent.ROLL_OVER, rollOver);
				view.removeEventListener(MouseEvent.ROLL_OUT, rollOut);
				view.removeEventListener(MouseEvent.CLICK, click);					
			}
			view.useHandCursor = b;
			view.buttonMode = b;			
		}	

		private function rollOver(evt:MouseEvent) : void
		{
			view.rollOver();
		};	
		
		private function rollOut(evt:MouseEvent) : void
		{
			view.rollOut();
		};			
		
		private function click(evt:MouseEvent) : void
		{
			view.click();
		};		
		
	}
}
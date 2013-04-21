package com.poem.mediators.menu 
{
	
	import com.poem.views.menu.GlobalMenuItemEv;
	import org.robotlegs.mvcs.Mediator;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class GlobalMenuItemEvMediator extends Mediator
	{
		[Inject]
		public var view:GlobalMenuItemEv;

		override public function onRegister():void 
		{
			view.initialize();
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
				view.addEventListener(MouseEvent.CLICK, click,false,0,true);	
			} else {
				view.removeEventListener(MouseEvent.ROLL_OVER, rollOver);
				view.removeEventListener(MouseEvent.CLICK, click);					
			}
			view.useHandCursor = b;
			view.buttonMode = b;			
		}
		
		private function rollOver(evt:MouseEvent) : void
		{
			view.rollOver();
		};

		private function click(evt:MouseEvent) : void
		{
			view.click();
		};
	}
}
package com.poem.mediators.usage 
{
	import com.poem.views.usage.Marker;
	import org.robotlegs.mvcs.Mediator;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class MarkerMediator extends Mediator
	{
		[Inject]
		public var view:Marker;	
		
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
				view.addEventListener(MouseEvent.ROLL_OUT, rollOut,false,0,true);
			} else {
				view.removeEventListener(MouseEvent.ROLL_OVER, rollOver);
				view.removeEventListener(MouseEvent.ROLL_OUT, rollOut);					
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
	}
}
package com.poem.mediators.framework 
{
	import com.poem.views.framework.Framework;
	import org.robotlegs.mvcs.Mediator;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class FrameworkMediator extends Mediator
	{
		[Inject]
		public var view:Framework;
		
		override public function onRegister():void 
		{
			
			view.initialize();
			view.addEventListener(MouseEvent.MOUSE_DOWN, onBackgroundMouseDown,false,0,true);
		}
		
		override public function onRemove():void 
		{
			view.dispose();
			view.removeEventListener(MouseEvent.MOUSE_DOWN, onBackgroundMouseDown);
			view = null;
		}
		
		private function onMinimizeClick(event:MouseEvent) : void
		{
			view.stage.nativeWindow.minimize();
		}
		
		private function onCloseClick(event:MouseEvent) : void
		{
			view.stage.nativeWindow.close();
		}
		
		private function onBackgroundMouseDown(event:MouseEvent) : void
		{
			view.stage.nativeWindow.startMove();
		}
	}
}
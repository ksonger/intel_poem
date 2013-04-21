package com.poem.mediators.framework 
{
	import com.poem.views.framework.CloseButton;
	import flash.events.MouseEvent;
	import org.robotlegs.mvcs.Mediator;
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class CloseButtonMediator extends Mediator
	{
		[Inject]
		public var view:CloseButton;
		
		override public function onRegister():void 
		{
			view.initialize();
			view.addEventListener(MouseEvent.CLICK, onClick,false,0,true);
		}
		
		override public function onRemove():void 
		{
			view.dispose();
			view.removeEventListener(MouseEvent.CLICK, onClick);
			view = null;
		}
		
		private function onClick(event:MouseEvent) : void
		{
			view.stage.nativeWindow.minimize();
			view.stage.nativeWindow.visible = false;
		}
	}

}
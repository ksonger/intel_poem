package com.poem.mediators.usage 
{
	import com.poem.views.usage.ComparisonMarker;
	import org.robotlegs.mvcs.Mediator;
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class ComparisonMarkerMediator extends Mediator
	{
		[Inject]
		public var view:ComparisonMarker;
		
		override public function onRegister():void 
		{
			view.initialize();
		}	
		
		override public function onRemove():void 
		{
			view.dispose();
			view = null;
		}
	}
}
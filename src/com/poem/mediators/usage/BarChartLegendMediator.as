package com.poem.mediators.usage 
{
	import com.poem.views.usage.BarChartLegend;
	import org.robotlegs.mvcs.Mediator;
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class BarChartLegendMediator extends Mediator
	{
		[Inject]
		public var view:BarChartLegend;
		
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
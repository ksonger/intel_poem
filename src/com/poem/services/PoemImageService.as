package com.poem.services 
{
	import com.poem.models.PoemModel;
	import com.poem.signals.PoemIconBitmapsLoadedSignal;
	import flash.display.Loader;
    import flash.events.Event;
    import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class PoemImageService 
	{
		private var iconBitmaps:Array;
		private var iconImageURLs:Array;
		
		[Inject]
		public var iconBitmapsLoaded:PoemIconBitmapsLoadedSignal;
				
		[Inject]
		public var model:PoemModel;
		
		public function loadIconBitmaps() : void
		{
			
			var status:String = model.sensorData.officeIntantaneousPowerValue.status;
			
			iconBitmaps = new Array();
			iconImageURLs = new Array();
			
			switch (status){
				case "good":
					iconImageURLs.push(model.config.aboveTarget128);
					iconImageURLs.push(model.config.aboveTarget48);
					iconImageURLs.push(model.config.aboveTarget32);
					iconImageURLs.push(model.config.aboveTarget16);				
				break;
				case "bad":
					iconImageURLs.push(model.config.belowTarget128);
					iconImageURLs.push(model.config.belowTarget48);
					iconImageURLs.push(model.config.belowTarget32);
					iconImageURLs.push(model.config.belowTarget16);						
				break;
				case "neutral":
					iconImageURLs.push(model.config.onTarget128);
					iconImageURLs.push(model.config.onTarget48);
					iconImageURLs.push(model.config.onTarget32);
					iconImageURLs.push(model.config.onTarget16);						
				break;
			}	
			
/*			iconImageURLs.push(model.config.icon128);
			iconImageURLs.push(model.config.icon48);
			iconImageURLs.push(model.config.icon32);
			iconImageURLs.push(model.config.icon16);*/
			loadIconBitmapsHandler();
		}
		
		private function loadIconBitmapsHandler(event:Event = null) : void
		{
        	if (event != null)
			{
        		iconBitmaps.push(event.target.content.bitmapData);
        	}
			
        	if (iconImageURLs.length > 0)
			{
        		var urlString:String = iconImageURLs.pop();
        		var loader:Loader = new Loader();
        		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadIconBitmapsHandler, false, 0, true);
				loader.load(new URLRequest(urlString));
        	} 
			else 
			{
        		iconBitmapsLoaded.dispatch(iconBitmaps);
				iconBitmaps = null;
				iconImageURLs = null;
        	}
        }	
	}

}
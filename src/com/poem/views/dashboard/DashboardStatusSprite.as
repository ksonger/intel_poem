package com.poem.views.dashboard 
{
	import com.poem.interfaces.IDisposable;
	import com.poem.interfaces.IInitializable;
	import com.poem.interfaces.IUpdateable;
	import com.poem.models.PoemModel;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class DashboardStatusSprite extends Sprite implements IDisposable, IInitializable, IUpdateable
	{
		
		[Inject]
		public var model:PoemModel;			
		
		public var container:Sprite = new Sprite();

		public var background:Loader = new Loader();
		public var statusloader:Loader = new Loader();
		public var trend:Loader = new Loader();
		public var chart:Loader = new Loader();
		
		public var header_txt:TextField = new TextField();
		
		public var average_txt:TextField = new TextField();	
		public var snapshot_txt:TextField = new TextField();
		public var target_txt:TextField = new TextField();
		
		public var header_label:String;
		public var average_label:String;
		public var snapshot_label:String;
		public var target_label:String;
		
		public var office_target_label:String;

		public var snapshotTrend:String;
		public var snapshotTarget:String;
		public var status:String;
		public var office_target:String;
		
		public var unit:String;
		
		public var snapshot:Number;
		public var average:Number;
		public var targetValue:Number;
		public var typ:String;
		

	

		public function initialize() : void
		{
				
			setValues();		
			
			createBackground();
			createStatus();
			createChart();
			createTrend();
			createText();
			addToStage();
		}

		public function dispose() : void
		{
			while (numChildren > 0) removeChildAt(0);
		}		
		
		public function update() : void
		{
			dispose();
			initialize();
		}

		public function addToStage() : void
		{
			container.addChild(background);
			container.addChild(statusloader);
			container.addChild(chart);
			//container.addChild(trend);
			
			container.addChild(header_txt);
			
			container.addChild(average_txt);
			container.addChild(snapshot_txt);
			container.addChild(target_txt);
			
			addChild(container);
		}			
	
		
		//OVERRIDDEN
		public function setBackground() : void
		{
		}
		
		public function setValues() : void
		{
		}			
		
		public function createBackground() : void
		{		
		}	

		public function createTrend() : void
		{		
		}			
		
		public function createStatus() : void
		{
		}			
		
		public function createChart() : void	
		{	
		}			

		public function createText() : void
		{
		}
	

	}
}
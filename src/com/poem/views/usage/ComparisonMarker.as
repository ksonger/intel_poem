package com.poem.views.usage 
{
	import com.poem.interfaces.IDisposable;
	import com.poem.interfaces.IInitializable;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class ComparisonMarker extends Sprite implements IDisposable, IInitializable
	{
		
		public function ComparisonMarker() 
		{
			
		}
		
		public function initialize() : void
		{
			
		}
		
		public function dispose() : void
		{
			while (numChildren > 0)
				removeChildAt(0);
		}
	}
}
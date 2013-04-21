package com.poem.views.usage 
{
	import com.poem.interfaces.IInitializable;
	import com.poem.interfaces.IDisposable;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class HeaderView extends Sprite implements IInitializable, IDisposable
	{
		
		public function HeaderView() 
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
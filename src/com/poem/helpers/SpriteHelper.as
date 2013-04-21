package com.poem.helpers 
{
	import flash.display.Sprite;
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class SpriteHelper 
	{
		
		public function SpriteHelper() 
		{
			
		}

		public static function SetBorder(target:Sprite) : void
		{
			target.graphics.lineStyle(1, 0xcccccc, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 10);
			target.graphics.drawRect(0, 0, target.width, target.height);
		}
	}

}
package com.poem.views.framework 
{
	import com.poem.interfaces.IDisposable;
	import com.poem.interfaces.IInitializable;
	import com.poem.models.PoemModel;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class CloseButton extends Sprite implements IDisposable, IInitializable
	{
		[Inject]
		public var model:PoemModel;
		
		public function initialize() : void
		{
			var backgroundLoader:Loader = new Loader();
			backgroundLoader.load(new URLRequest(model.config.closeButtonImageURL));
			
			this.buttonMode = true;
			this.useHandCursor = true;
			
			addChild(backgroundLoader);
		}
		
		public function dispose() : void
		{
			while (numChildren > 0)
				removeChildAt(0);
				
			model = null;
		}
	}
}
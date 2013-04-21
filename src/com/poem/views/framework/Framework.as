package com.poem.views.framework 
{
	import com.poem.interfaces.IDisposable;
	import com.poem.interfaces.IInitializable;
	import com.poem.models.PoemModel;
	import com.poem.constants.TextStyles;
	import com.poem.helpers.TextFieldHelper;
	
	import flash.events.IOErrorEvent;
	import flash.events.Event;	
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.StyleSheet;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class Framework extends Sprite implements IInitializable, IDisposable
	{		
		[Inject]
		public var model:PoemModel;
		
		private var sheet:StyleSheet = new StyleSheet();
		private var loader:URLLoader = new URLLoader();
		
		public function Framework() : void
		{
			
		}
		
		public function initialize() : void
		{
			createBackground();
			createMinimizeButton();
			createCloseButton();
			createTitle();
		}
		
		public function errorHandler(e:IOErrorEvent):void {
		 trace("Couldn't load the style sheet file.");
		}
		
		public function loaderCompleteHandler(event:Event):void {
			sheet.parseCSS(loader.data);
			createTitle();
		}		
			
		public function dispose() : void
		{
			while (numChildren > 0)
				removeChildAt(0);
				
			model = null;
		}
		
		private function createBackground() : void
		{
			var background:Loader = new Loader();
			background.load(new URLRequest(model.config.backgroundImageURL));
			this.addChild(background);
		}
		
		private function createMinimizeButton() : void
		{
			var minimizeButton:MinimizeButton = new MinimizeButton();
			minimizeButton.x = 720;
			minimizeButton.y = 17;
			addChild(minimizeButton);
		}
		
		private function createCloseButton() : void
		{
			var closeButton:CloseButton = new CloseButton();
			closeButton.x = 745;
			closeButton.y = 17;
			addChild(closeButton);
		}
		
		private function createTitle() : void
		{

			var app_txt:String = model.labelManager.getLabel("c1");
			var title_txt:String = model.labelManager.getLabel("c21");
			
			app_txt = app_txt.toUpperCase();
			title_txt = title_txt.toUpperCase();		
			
			var style:Object = sheet.getStyle("VBox");
			
			var app_title:TextField = TextFieldHelper.createTextField(280, 20, 300, app_txt, "APP_TITLE", TextStyles.APPLICATION_TITLE, TextFieldAutoSize.LEFT)
			//var app_title:TextField = TextFieldHelper.createTextField(280, 20, 300, app_txt, "APP_TITLE", style, TextFieldAutoSize.LEFT)
			var page_title:TextField = TextFieldHelper.createTextField(50, 50, 110, title_txt, "TITLE", TextStyles.APPLICATION_PAGE, TextFieldAutoSize.LEFT, false, true);
			
			addChild(app_title);
			addChild(page_title);
		}		
		
	}
}
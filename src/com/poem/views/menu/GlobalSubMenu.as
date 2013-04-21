package com.poem.views.menu 
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.poem.interfaces.IDisposable;
	import com.poem.interfaces.IInitializable;
	import com.poem.models.PoemModel;
	import com.poem.constants.Screens;
	
	import flash.display.CapsStyle;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class GlobalSubMenu extends Sprite implements IDisposable, IInitializable
	{

		[Inject]
		public var model:PoemModel;		
		
		public var container:Sprite = new Sprite();
		public var background:Sprite;

		public function dispose() : void
		{
			while (numChildren > 0)
				removeChildAt(0);
		}
		
		public function initialize() : void
		{
			createBackground();
			createButtons();
		}

		
		private function createBackground() : void
		{
			var sub_background:Loader = new Loader();
			sub_background.load(new URLRequest(model.config.submenuBackgroundURL));
			container.addChild(sub_background);
			
			addChild(container);
		}	
		
		private function createButtons() : void
		{
			
			var x_val:Number = 4;
			var y_val:Number = 0;
			var y_inc:Number = 28;
			
			var office_label:String = model.labelManager.getLabel("c14");
			var pc_label:String = model.labelManager.getLabel("c7");
			var printer_label:String = model.labelManager.getLabel("c8");
			var plug_label:String = model.labelManager.getLabel("c9");
			
			office_label = office_label.toUpperCase();
			pc_label = pc_label.toUpperCase();
			printer_label = printer_label.toUpperCase();
			plug_label = plug_label.toUpperCase();
			
			//CREATE SUB BUTTONS
			var office:GlobalSubMenuItem = new GlobalSubMenuItem(office_label, Screens.OFFICE);
			office.x = x_val;
			office.y = y_val;
			y_val += y_inc;
	
			var pc:GlobalSubMenuItem = new GlobalSubMenuItem(pc_label, Screens.PCUSAGE);
			pc.x = x_val;
			pc.y = y_val;
			y_val += y_inc;
			
			var printer:GlobalSubMenuItem = new GlobalSubMenuItem(printer_label, Screens.PRINTERUSAGE);
			printer.x = x_val;
			printer.y = y_val;	
			y_val += y_inc;
			
			var plug:GlobalSubMenuItem = new GlobalSubMenuItem(plug_label, Screens.PLUGGABLEUSAGE);
			plug.x = x_val;
			plug.y = y_val;	
			
			

			container.addChild(office);
			container.addChild(pc);
			container.addChild(printer);
			container.addChild(plug);
		}			
		

	}
}
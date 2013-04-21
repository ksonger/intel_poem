package com.poem.helpers 
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.text.AntiAliasType;
	import flash.text.StyleSheet;
	
	import com.poem.constants.TextStyles;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class TextFieldHelper 
	{
		
		public static function createTextField(x:Number = 0, y:Number = 0, width:Number = 0, label:String = "UNDEFINED", name:String = "UNDEFINED", style:Object = null, autoSize:String = TextFieldAutoSize.NONE, selectable:Boolean = false, wordWrap:Boolean = false) : TextField 
		{
			
			var newTextField:TextField = new TextField();
			newTextField.name = name;
			newTextField.autoSize = autoSize;
			newTextField.antiAliasType = AntiAliasType.ADVANCED;
			newTextField.wordWrap = wordWrap;
			newTextField.selectable = selectable;
			newTextField.x = x;
			newTextField.y = y;
			newTextField.width = width;
			newTextField.embedFonts = true;
/*			newTextField.border = true;*/
/*			if(style != null)*/
			var css:StyleSheet = new StyleSheet();
			css.setStyle(".style", style);
			newTextField.styleSheet = css;
			newTextField.htmlText = '<span class="style">' + label + '</span>';
			return newTextField;
		}
	}	
}
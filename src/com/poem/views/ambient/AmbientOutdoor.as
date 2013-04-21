package com.poem.views.ambient 
{
	import com.poem.interfaces.IDisposable;
	import com.poem.interfaces.IInitializable;
	import com.poem.interfaces.IUpdateable;
	import com.poem.helpers.TextFieldHelper;
	import com.poem.constants.TextStyles;	
	
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;	
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class AmbientOutdoor extends Ambient implements IDisposable, IInitializable, IUpdateable
	{		
		
		public override function createAmbientValues() : void
		{	
			
			background.graphics.drawRoundRect(0, 0, 180, 80, 25);
			mask_clip.graphics.drawRect(0, 0, 180, 70);	
			rule_wh.graphics.lineTo(168, 23);
			rule_gry.graphics.lineTo(168, 24);
			
			var header_txt:String = model.labelManager.getLabel("c15");
			header_txt = header_txt.toUpperCase();
			
			var temp_txt:String = model.labelManager.getLabel("c17");
			temp_txt = temp_txt.toUpperCase();	
			
			var rh_txt:String = model.labelManager.getLabel("c18");
			rh_txt = rh_txt.toUpperCase();
			
			var winds_txt:String = model.labelManager.getLabel("c19");
			winds_txt = winds_txt.toUpperCase();			
			
			header = TextFieldHelper.createTextField(8, 6, 150, header_txt, "OUTDOORS", TextStyles.AMBIENT_HEADER, TextFieldAutoSize.LEFT);
			
			label_one = TextFieldHelper.createTextField(8, 28, 50, temp_txt, "TEMP", TextStyles.AMBIENT_LABEL, TextFieldAutoSize.LEFT);
			label_two = TextFieldHelper.createTextField(50, 28, 50, rh_txt, "RH", TextStyles.AMBIENT_LABEL, TextFieldAutoSize.LEFT);
			label_three = TextFieldHelper.createTextField(90, 28, 50, winds_txt, "WINDS", TextStyles.AMBIENT_LABEL, TextFieldAutoSize.LEFT);
			
			value_one = TextFieldHelper.createTextField(8, 45, 50, model.sensorData.outdoorTemp, "outdoor_temp", TextStyles.AMBIENT_VALUE, TextFieldAutoSize.LEFT);	
			value_two = TextFieldHelper.createTextField(50, 45, 50, model.sensorData.outdoorRH, "outdoor_rh", TextStyles.AMBIENT_VALUE, TextFieldAutoSize.LEFT);
			value_three = TextFieldHelper.createTextField(90, 45, 50, model.sensorData.wind, "outdoor_wind", TextStyles.AMBIENT_VALUE, TextFieldAutoSize.LEFT);		
		}
		
	}
}
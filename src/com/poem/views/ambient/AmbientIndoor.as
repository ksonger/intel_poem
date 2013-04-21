package com.poem.views.ambient 
{
	import com.poem.interfaces.IDisposable;
	import com.poem.interfaces.IInitializable;
	import com.poem.interfaces.IUpdateable;
	import com.poem.helpers.TextFieldHelper;
	import com.poem.constants.TextStyles;
	
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class AmbientIndoor extends Ambient implements IDisposable, IInitializable, IUpdateable
	{		
		
		public override function createAmbientValues() : void
		{	
			
			background.graphics.drawRoundRect(0, 0, 150, 80, 25);
			mask_clip.graphics.drawRect(0, 0, 150, 70);	
			rule_wh.graphics.lineTo(140, 23);
			rule_gry.graphics.lineTo(140, 24);
			
			var header_txt:String = model.labelManager.getLabel("c16");
			header_txt = header_txt.toUpperCase();
			
			var temp_txt:String = model.labelManager.getLabel("c17");
			temp_txt = temp_txt.toUpperCase();	
			
			var rh_txt:String = model.labelManager.getLabel("c18");
			rh_txt = rh_txt.toUpperCase();
			
			var light_txt:String = model.labelManager.getLabel("c20");
			light_txt = light_txt.toUpperCase();			
			
			header = TextFieldHelper.createTextField(8, 6, 150, header_txt, "INDOORS", TextStyles.AMBIENT_HEADER, TextFieldAutoSize.LEFT);
			
			label_one = TextFieldHelper.createTextField(8, 30, 50, temp_txt, "TEMP", TextStyles.AMBIENT_LABEL, TextFieldAutoSize.LEFT);
			label_two = TextFieldHelper.createTextField(55, 30, 50, rh_txt, "RH", TextStyles.AMBIENT_LABEL, TextFieldAutoSize.LEFT);
			label_three = TextFieldHelper.createTextField(95, 30, 50, light_txt, "LIGHT", TextStyles.AMBIENT_LABEL, TextFieldAutoSize.LEFT);			
			
			value_one = TextFieldHelper.createTextField(8, 45, 50, model.sensorData.indoorTemp, "indoor_temp", TextStyles.AMBIENT_VALUE, TextFieldAutoSize.LEFT);
			value_two = TextFieldHelper.createTextField(55, 45, 50, model.sensorData.indoorRH, "indoor_rh", TextStyles.AMBIENT_VALUE, TextFieldAutoSize.LEFT);		
			value_three = TextFieldHelper.createTextField(95, 45, 50, model.sensorData.indoorLight, "indoor_light", TextStyles.AMBIENT_VALUE, TextFieldAutoSize.LEFT);
		}
		
	}
}
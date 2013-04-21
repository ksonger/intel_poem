package com.poem.constants
{
	
	import flash.text.Font;
	
	public class TextStyles
	{
		
		public static var APPLICATION_PAGE:Object;
		public static var APPLICATION_TITLE:Object;
		
		public static var ALERT_HEADER:Object;
		public static var ALERT_VALUE:Object;
		
		public static var AMBIENT_HEADER:Object;
		public static var AMBIENT_LABEL:Object;
		public static var AMBIENT_VALUE:Object;
		
		public static var DASH_STATUS_HEADER:Object;
		public static var DASH_STATUS_HEADER_SMALL:Object;
		public static var DASH_STATUS_SUBHEADER:Object;
		public static var DASH_STATUS_SUBHEADER_SMALL:Object;
		
		public static var USAGE_PLUGGABLE:Object;
		public static var USAGE_PLUGGABLE_TOOLTIP_HEADER:Object;
		public static var USAGE_PLUGGABLE_TOOLTIP:Object;
		public static var USAGE_BAR_VALUE:Object;
		public static var USAGE_INSTRUCTIONS:Object;

		public static var LEGEND_HEADER:Object;
		public static var LEGEND:Object;
		public static var CONSUMPTION_LABEL:Object;
		
		public static var SUB_MENU:Object;
		
		public static var COMFORT_SUBMIT:Object;
		public static var COMFORT_TOOLTIP:Object;
		
		public static var TOGGLE_LABEL:Object;
		
		public static var TARGET_ABOVE:Object;
		public static var TARGET_BELOW:Object;
		public static var TARGET_BELOW_BOLD:Object;
		
		public static var HELVETICA:Font = new HelveticaRegular();
		public static var HELVETICA_BOLD:Font = new HelveticaBold();
		public static var EUROSTILE_BOLD:Font = new EurostileBold();

		// USAGE
		USAGE_PLUGGABLE_TOOLTIP_HEADER = new Object();  
		USAGE_PLUGGABLE_TOOLTIP_HEADER.fontFamily = "Helvetica Neue Bold";
		USAGE_PLUGGABLE_TOOLTIP_HEADER.fontSize = 10;
		USAGE_PLUGGABLE_TOOLTIP_HEADER.color = "#F2F2F2"; 
		
		USAGE_PLUGGABLE_TOOLTIP = new Object();  
		USAGE_PLUGGABLE_TOOLTIP.fontFamily = "Helvetica Neue";
		USAGE_PLUGGABLE_TOOLTIP.fontSize = 9;
		USAGE_PLUGGABLE_TOOLTIP.color = "#CCCCCC"; 
		
		USAGE_PLUGGABLE = new Object();  
		USAGE_PLUGGABLE.fontFamily = "Helvetica Neue";
		USAGE_PLUGGABLE.fontSize = 13;
		USAGE_PLUGGABLE.color = "#999999"; 	
		
		TARGET_ABOVE = new Object();  
		TARGET_ABOVE.fontFamily = "Helvetica Neue Bold";
		TARGET_ABOVE.fontSize = 12;
		TARGET_ABOVE.color = "#3e8680";
		
		TARGET_BELOW = new Object();  
		TARGET_BELOW.fontFamily = "Helvetica Neue";
		TARGET_BELOW.fontSize = 12;
		TARGET_BELOW.color = "#999999";
		
		TARGET_BELOW_BOLD = new Object();  
		TARGET_BELOW_BOLD.fontFamily = "Helvetica Neue Bold";
		TARGET_BELOW_BOLD.fontSize = 12;
		TARGET_BELOW_BOLD.color = "#333333";
		
		SUB_MENU = new Object();  
		SUB_MENU.fontFamily = "Helvetica Neue Bold";
		SUB_MENU.fontSize = 11; 
		SUB_MENU.leading = -2; 
		SUB_MENU.color = "#5c7714";
		
		USAGE_BAR_VALUE = new Object();  
		USAGE_BAR_VALUE.fontFamily = "Helvetica Neue Bold";
		USAGE_BAR_VALUE.fontSize = 11; 
		USAGE_BAR_VALUE.color = "#4f553a";
		
		LEGEND_HEADER = new Object();  
		LEGEND_HEADER.fontFamily = "Helvetica Neue";
		LEGEND_HEADER.fontSize = 11;
		LEGEND_HEADER.leading = 2;
		LEGEND_HEADER.textDecoration = 'underline';
		LEGEND_HEADER.color = "#3e8680";

		LEGEND = new Object();  
		LEGEND.fontFamily = "Helvetica Neue";
		LEGEND.fontSize = 11;
		LEGEND.leading = 2;
		LEGEND.color = "#3e8680"; 
		
		CONSUMPTION_LABEL = new Object();  
		CONSUMPTION_LABEL.fontFamily = "Helvetica Neue";
		CONSUMPTION_LABEL.fontSize = 10;
		CONSUMPTION_LABEL.leading = 2;
		CONSUMPTION_LABEL.color = "#3e8680";
		
		// DASHBOARD STATUS
		DASH_STATUS_SUBHEADER = new Object();  
		DASH_STATUS_SUBHEADER.fontFamily = "Helvetica Neue Bold";
		DASH_STATUS_SUBHEADER.fontSize = 13; 
		DASH_STATUS_SUBHEADER.color = "#909492"; 
		
		DASH_STATUS_SUBHEADER_SMALL = new Object();  
		DASH_STATUS_SUBHEADER_SMALL.fontFamily = "Helvetica Neue";
		DASH_STATUS_SUBHEADER_SMALL.fontSize = 11; 
		DASH_STATUS_SUBHEADER_SMALL.color = "#909492"; 		
		
		DASH_STATUS_HEADER = new Object();  
		DASH_STATUS_HEADER.fontFamily = "Helvetica Neue Bold";
		DASH_STATUS_HEADER.fontSize = 13;
		DASH_STATUS_HEADER.leading = -2;
		DASH_STATUS_HEADER.color = "#3e8680"; 	
		
		DASH_STATUS_HEADER_SMALL = new Object();  
		DASH_STATUS_HEADER_SMALL.fontFamily = "Helvetica Neue Bold";
		DASH_STATUS_HEADER_SMALL.fontSize = 11; 
		DASH_STATUS_HEADER_SMALL.leading = -1;
		DASH_STATUS_HEADER_SMALL.color = "#3e8680";			
		
		// FRAMEWORK HEADERS
		APPLICATION_TITLE = new Object();  
		APPLICATION_TITLE.fontFamily = "Eurostile";
		APPLICATION_TITLE.fontWeight = "bold";
/*		APPLICATION_TITLE.fontFamily = "Helvetica Neue Bold", "sans-serif";*/
		APPLICATION_TITLE.fontSize = 15; 
		APPLICATION_TITLE.color = "#FFFFFF";	
		
		APPLICATION_PAGE = new Object();
		APPLICATION_PAGE.fontFamily = "Eurostile";
		APPLICATION_PAGE.fontWeight = "bold";
		/*APPLICATION_PAGE.fontFamily = HELVETICA_BOLD;*/
		APPLICATION_PAGE.fontSize = 18;
		APPLICATION_PAGE.leading = -1;
		APPLICATION_PAGE.color = "#005952";	
		
		
		// COMFORT HEADERS
		COMFORT_SUBMIT = new Object();  
		COMFORT_SUBMIT.fontFamily = "Helvetica Neue Bold";
		COMFORT_SUBMIT.fontSize = 11; 
		COMFORT_SUBMIT.color = "#FFFFFF";	
		
		COMFORT_TOOLTIP = new Object();  
		COMFORT_TOOLTIP.fontFamily = "Helvetica Neue";
		COMFORT_TOOLTIP.fontSize = 10;
		COMFORT_TOOLTIP.textAlign = 'center';
		COMFORT_TOOLTIP.color = "#CCCCCC"; 
		
		USAGE_INSTRUCTIONS = new Object();  
		USAGE_INSTRUCTIONS.fontFamily = "Helvetica Neue";
		USAGE_INSTRUCTIONS.fontSize = 9;
		USAGE_INSTRUCTIONS.textAlign = 'left';
		USAGE_INSTRUCTIONS.color = "#CCCCCC";
		
		// ALERT HEADERS
		ALERT_HEADER = new Object();  
		ALERT_HEADER.fontFamily = "Helvetica Neue Bold";
		ALERT_HEADER.fontSize = 11; 
		ALERT_HEADER.color = "#3e8680"; 
		
		ALERT_VALUE = new Object();  
		ALERT_VALUE.fontFamily = "Helvetica Neue";
		ALERT_VALUE.fontSize = 11;
		ALERT_VALUE.leading = 2;
		ALERT_VALUE.color = "#999999"; 		
		
		// AMBIENT HEADERS
		AMBIENT_HEADER = new Object();  
		AMBIENT_HEADER.fontFamily = "Helvetica Neue Bold";
		AMBIENT_HEADER.fontSize = 11; 
		AMBIENT_HEADER.color = "#3e8680"; 
		
		AMBIENT_LABEL = new Object();  
		AMBIENT_LABEL.fontFamily = "Helvetica Neue";
		AMBIENT_LABEL.fontSize = 10;
		AMBIENT_LABEL.color = "#5c7714"; 
		
		AMBIENT_VALUE = new Object();  
		AMBIENT_VALUE.fontFamily = "Helvetica Neue";
		AMBIENT_VALUE.fontSize = 13;
		AMBIENT_VALUE.color = "#6d6d6d"; 	
		
		// TOGGLE_LABEL
		TOGGLE_LABEL = new Object();  
		TOGGLE_LABEL.fontFamily = "Helvetica Neue Bold";
		TOGGLE_LABEL.fontSize = 11; 
		TOGGLE_LABEL.textDecoration = 'underline';
		TOGGLE_LABEL.color = "#3e8680"; 

	}
}
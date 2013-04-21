package com.poem.signals 
{
	import org.osflash.signals.Signal;
	import com.poem.models.MarkerData;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class AddMarkerToolTipSignal extends Signal
	{
		
		public function AddMarkerToolTipSignal() 
		{
			super(MarkerData);
		}		
	}

}
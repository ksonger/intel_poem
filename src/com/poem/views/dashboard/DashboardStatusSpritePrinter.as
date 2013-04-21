package com.poem.views.dashboard 
{
	import com.poem.interfaces.IDisposable;
	import com.poem.interfaces.IInitializable;
	import com.poem.interfaces.IUpdateable;
	import com.poem.models.PoemModel;
	
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class DashboardStatusSpritePrinter extends DashboardStatusSpriteSmall implements IDisposable, IInitializable, IUpdateable
	{	
		
		public override function setValues() : void
		{
			
			header_label = model.labelManager.getLabel("c8");
			snapshot_label = model.labelManager.getLabel("c43");
			average_label = model.labelManager.getLabel("c11");
						
			snapshotTrend = model.sensorData.printerInstantaneousPowerValue.snapshotTrend;
			snapshotTarget = model.sensorData.printerInstantaneousPowerValue.snapshotTarget;
			status = model.sensorData.printerInstantaneousPowerValue.status;
			
			snapshot = model.sensorData.printerInstantaneousPowerValue.snapshot;
			average = model.sensorData.printerInstantaneousPowerValue.average;	
			unit = model.sensorData.printerInstantaneousPowerValue.unit;	
		}
		
	}
}
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
	public class DashboardStatusSpriteOfficeTotal extends DashboardStatusSpriteSmall implements IDisposable, IInitializable, IUpdateable
	{	
		
		public override function setValues() : void
		{
			header_label = model.labelManager.getLabel("c6");
			snapshot_label = model.labelManager.getLabel("c43");
			average_label = model.labelManager.getLabel("c11");

			snapshotTrend = model.sensorData.officeIntantaneousPowerValue.snapshotTrend;
			snapshotTarget = model.sensorData.officeIntantaneousPowerValue.snapshotTarget;
			status = model.sensorData.officeIntantaneousPowerValue.status;			
			
			snapshot = model.sensorData.officeIntantaneousPowerValue.snapshot;
			average = model.sensorData.officeIntantaneousPowerValue.average;	
			unit = model.sensorData.officeIntantaneousPowerValue.unit
		}


	}
}
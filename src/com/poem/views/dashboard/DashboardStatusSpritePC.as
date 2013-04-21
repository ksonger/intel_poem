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
	public class DashboardStatusSpritePC extends DashboardStatusSpriteSmall implements IDisposable, IInitializable, IUpdateable
	{	
		
		public override function setValues() : void
		{
			header_label = model.labelManager.getLabel("c7");
			snapshot_label = model.labelManager.getLabel("c43");
			average_label = model.labelManager.getLabel("c11");
			
			snapshotTrend = model.sensorData.pcInstantaneousPowerValue.snapshotTrend;
			snapshotTarget = model.sensorData.pcInstantaneousPowerValue.snapshotTarget;
			status = model.sensorData.pcInstantaneousPowerValue.status;			
			
			snapshot = model.sensorData.pcInstantaneousPowerValue.snapshot;
			average = model.sensorData.pcInstantaneousPowerValue.average;
			unit = model.sensorData.pcInstantaneousPowerValue.unit;
		}


	}
}
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
	public class DashboardStatusSpritePluggable extends DashboardStatusSpriteSmall implements IDisposable, IInitializable, IUpdateable
	{	
		
		public override function setValues() : void
		{
			
			header_label = model.labelManager.getLabel("c9");
			snapshot_label = model.labelManager.getLabel("c43");
			average_label = model.labelManager.getLabel("c11");		
			
			snapshotTrend = model.sensorData.plugableInstantaneousPowerValue.snapshotTrend;
			snapshotTarget = model.sensorData.plugableInstantaneousPowerValue.snapshotTarget;
			status = model.sensorData.plugableInstantaneousPowerValue.status;
			
			snapshot = model.sensorData.plugableInstantaneousPowerValue.snapshot;
			average = model.sensorData.plugableInstantaneousPowerValue.average;	
			unit = model.sensorData.plugableInstantaneousPowerValue.unit;
		}
		
	}
}
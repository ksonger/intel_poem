package com.poem.helpers 
{
	/**
	 * ...
	 * @author Ken Songer
	 */
	public class LabelManager 
	{
		private var _labels:Object;
		
		public function LabelManager() 
		{
			_labels = new Object();
		}
		
		public function getLabel(key:String) : String
		{
			return _labels[key] || "Label_Error";
		}
		
		public function loadLabels(data:XML) : void
		{
			for (var i:int = 0; i < data.labels[0].add.length(); i++)
			{
				var node:XML = data.labels.add[i];
				_labels[node.@name] = node.@value;
			}
		}
	}
}
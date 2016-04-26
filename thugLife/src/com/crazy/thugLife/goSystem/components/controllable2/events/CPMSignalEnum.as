/**
 * Created by Anton Nefjodov on 27.04.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable2.events
{
	import com.crazyfm.core.common.Enum;

	public class CPMSignalEnum extends Enum
	{
		public static const COLLISION_BEGIN:CPMSignalEnum = new CPMSignalEnum("COLLISION_BEGIN");
		public static const COLLISION_END:CPMSignalEnum = new CPMSignalEnum("COLLISION_END");
		public static const SENSOR_BEGIN:CPMSignalEnum = new CPMSignalEnum("SENSOR_BEGIN");
		public static const SENSOR_END:CPMSignalEnum = new CPMSignalEnum("SENSOR_END");

		public function CPMSignalEnum(name:String)
		{
			super(name);
		}
	}
}

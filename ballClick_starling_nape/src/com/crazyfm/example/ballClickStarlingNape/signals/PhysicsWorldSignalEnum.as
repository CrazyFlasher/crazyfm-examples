/**
 * Created by Anton Nefjodov on 16.02.2016.
 */
package com.crazyfm.example.ballClickStarlingNape.signals
{
	import com.crazyfm.core.common.Enum;

	/**
	 * Signal types, that PhysicsWorldContext dispatches to children.
	 */
	public class PhysicsWorldSignalEnum extends Enum
	{
		public static const WORLD_STEP:BallViewSignalEnum = new BallViewSignalEnum("WORLD_STEP");

		public function PhysicsWorldSignalEnum(name:String)
		{
			super(name);
		}
	}
}

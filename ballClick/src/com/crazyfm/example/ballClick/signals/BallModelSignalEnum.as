/**
 * Created by Anton Nefjodov on 8.02.2016.
 */
package com.crazyfm.example.ballClick.signals
{
	import com.crazyfm.core.common.Enum;

	public class BallModelSignalEnum extends Enum
	{
		public static const BALL_COORDINATES_CHANGED:BallModelSignalEnum = new BallModelSignalEnum("BALL_COORDINATES_CHANGED");

		public function BallModelSignalEnum(name:String)
		{
			super(name);
		}
	}
}

/**
 * Created by Anton Nefjodov on 8.02.2016.
 */
package com.crazyfm.example.ballClickStarlingNape.signals
{
	import com.crazyfm.core.common.Enum;

	/**
	 * Signal types, that BallViewController dispatches.
	 */
	public class BallViewSignalEnum extends Enum
	{
		public static const BALL_MOVE_TO_NEW_POSITION:BallViewSignalEnum = new BallViewSignalEnum("BALL_MOVE_TO_NEW_POSITION");

		public function BallViewSignalEnum(name:String)
		{
			super(name);
		}
	}
}


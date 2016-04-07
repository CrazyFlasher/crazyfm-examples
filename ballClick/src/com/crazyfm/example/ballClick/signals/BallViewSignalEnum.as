/**
 * Created by Anton Nefjodov on 8.02.2016.
 */
package com.crazyfm.example.ballClick.signals
{
	import com.crazyfm.core.common.Enum;

	public class BallViewSignalEnum extends Enum
	{
		public static const BALL_CLICKED:BallViewSignalEnum = new BallViewSignalEnum("BALL_CLICKED");

		public function BallViewSignalEnum(name:String)
		{
			super(name);
		}
	}
}


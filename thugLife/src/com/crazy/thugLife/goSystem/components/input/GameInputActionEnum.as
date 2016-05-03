/**
 * Created by Anton Nefjodov on 26.04.2016.
 */
package com.crazy.thugLife.goSystem.components.input
{
	import com.crazyfm.core.common.Enum;

	public class GameInputActionEnum extends Enum
	{
		public static const MOVE_LEFT:GameInputActionEnum = new GameInputActionEnum("MOVE_LEFT");
		public static const MOVE_RIGHT:GameInputActionEnum = new GameInputActionEnum("MOVE_RIGHT");
		public static const RUN_LEFT:GameInputActionEnum = new GameInputActionEnum("RUN_LEFT");
		public static const RUN_RIGHT:GameInputActionEnum = new GameInputActionEnum("RUN_RIGHT");
		public static const MOVE_UP:GameInputActionEnum = new GameInputActionEnum("MOVE_UP");
		public static const MOVE_DOWN:GameInputActionEnum = new GameInputActionEnum("MOVE_DOWN");
		public static const STOP_HORIZONTAL:GameInputActionEnum = new GameInputActionEnum("STOP_HORIZONTAL");
		public static const STOP_VERTICAL:GameInputActionEnum = new GameInputActionEnum("STOP_VERTICAL");
		public static const TOGGLE_RUN:GameInputActionEnum = new GameInputActionEnum("TOGGLE_RUN");
		public static const AIM:GameInputActionEnum = new GameInputActionEnum("AIM");

		public function GameInputActionEnum(name:String)
		{
			super(name);
		}
	}
}

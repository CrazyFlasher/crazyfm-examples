/**
 * Created by Anton Nefjodov on 26.04.2016.
 */
package com.crazy.thugLife.goSystem.components.input
{
	import com.crazyfm.devkit.goSystem.components.input.AbstractInputActionEnum;

	public class InputActionEnum extends AbstractInputActionEnum
	{
		public static const MOVE_LEFT:InputActionEnum = new InputActionEnum("MOVE_LEFT");
		public static const MOVE_RIGHT:InputActionEnum = new InputActionEnum("MOVE_RIGHT");
		public static const RUN_LEFT:InputActionEnum = new InputActionEnum("RUN_LEFT");
		public static const RUN_RIGHT:InputActionEnum = new InputActionEnum("RUN_RIGHT");
		public static const MOVE_UP:InputActionEnum = new InputActionEnum("MOVE_UP");
		public static const MOVE_DOWN:InputActionEnum = new InputActionEnum("MOVE_DOWN");
		public static const STOP_HORIZONTAL:InputActionEnum = new InputActionEnum("STOP_HORIZONTAL");
		public static const STOP_VERTICAL:InputActionEnum = new InputActionEnum("STOP_VERTICAL");
		public static const TOGGLE_RUN:InputActionEnum = new InputActionEnum("TOGGLE_RUN");

		public function InputActionEnum(name:String)
		{
			super(name);
		}
	}
}

/**
 * Created by Anton Nefjodov on 26.04.2016.
 */
package com.crazy.thugLife.goSystem.components.input
{
	import com.crazyfm.core.common.Enum;

	public class InputActionEnum extends Enum
	{
		public static const MOVE_LEFT:InputActionEnum = new InputActionEnum("MOVE_LEFT");
		public static const MOVE_RIGHT:InputActionEnum = new InputActionEnum("MOVE_RIGHT");
		public static const STOP_HORIZONTAL:InputActionEnum = new InputActionEnum("STOP_HORIZONTAL");

		public function InputActionEnum(name:String)
		{
			super(name);
		}
	}
}

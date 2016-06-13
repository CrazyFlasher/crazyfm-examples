/**
 * Created by Anton Nefjodov on 13.06.2016.
 */
package com.crazy.thugLife.common.messages
{
	import com.crazyfm.core.common.Enum;

	public class ContextMessageType extends Enum
	{
		public static const EXIT:ContextMessageType = new ContextMessageType("EXIT");

		public function ContextMessageType(name:String)
		{
			super(name);
		}
	}
}

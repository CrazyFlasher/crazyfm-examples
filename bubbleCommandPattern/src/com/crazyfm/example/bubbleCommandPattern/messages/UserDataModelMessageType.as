/**
 * Created by Anton Nefjodov on 9.06.2016.
 */
package com.crazyfm.example.bubbleCommandPattern.messages
{
	import com.crazyfm.core.common.Enum;

	public class UserDataModelMessageType extends Enum
	{
		public static const FIRSTNAME_CHANGED:UserDataModelMessageType = new UserDataModelMessageType("FIRSTNAME_CHANGED");
		public static const LASTNAME_CHANGED:UserDataModelMessageType = new UserDataModelMessageType("LASTNAME_CHANGED");
		public static const AGE_CHANGED:UserDataModelMessageType = new UserDataModelMessageType("AGE_CHANGED");

		public function UserDataModelMessageType(name:String)
		{
			super(name);
		}
	}
}

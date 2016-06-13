/**
 * Created by Anton Nefjodov on 9.06.2016.
 */
package com.crazyfm.example.bubbleCommandPattern.messages
{
	import com.crazyfm.core.common.Enum;

	public class AppViewMessageType extends Enum
	{
		public static const FIRST_NAME_CLICKED:UserDataModelMessageType = new UserDataModelMessageType("FIRST_NAME_CLICKED");
		public static const LAST_NAME_CLICKED:UserDataModelMessageType = new UserDataModelMessageType("LAST_NAME_CLICKED");
		public static const AGE_CLICKED:UserDataModelMessageType = new UserDataModelMessageType("AGE_CLICKED");

		public function AppViewMessageType(name:String)
		{
			super(name);
		}
	}
}

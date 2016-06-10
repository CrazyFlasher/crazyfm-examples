/**
 * Created by Anton Nefjodov on 9.06.2016.
 */
package com.crazyfm.example.bubblePattern.signals
{
	import com.crazyfm.core.common.Enum;

	public class UserDataModelSignalType extends Enum
	{
		public static const FIRSTNAME_CHANGED:UserDataModelSignalType = new UserDataModelSignalType("FIRSTNAME_CHANGED");
		public static const LASTNAME_CHANGED:UserDataModelSignalType = new UserDataModelSignalType("LASTNAME_CHANGED");
		public static const AGE_CHANGED:UserDataModelSignalType = new UserDataModelSignalType("AGE_CHANGED");

		public function UserDataModelSignalType(name:String)
		{
			super(name);
		}
	}
}

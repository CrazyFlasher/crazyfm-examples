/**
 * Created by Anton Nefjodov on 9.06.2016.
 */
package com.crazyfm.example.bubblePattern.signals
{
	import com.crazyfm.core.common.Enum;

	public class AppViewSignalType extends Enum
	{
		public static const FIRST_NAME_CLICKED:UserDataModelSignalType = new UserDataModelSignalType("FIRST_NAME_CLICKED");
		public static const LAST_NAME_CLICKED:UserDataModelSignalType = new UserDataModelSignalType("LAST_NAME_CLICKED");
		public static const AGE_CLICKED:UserDataModelSignalType = new UserDataModelSignalType("AGE_CLICKED");

		public function AppViewSignalType(name:String)
		{
			super(name);
		}
	}
}

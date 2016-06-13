/**
 * Created by Anton Nefjodov on 9.06.2016.
 */
package com.crazyfm.example.bubbleCommandPattern.models
{
	import com.crazyfm.core.mvc.model.AbstractModel;
	import com.crazyfm.example.bubbleCommandPattern.messages.UserDataModelMessageType;

	public class UserDataModel extends AbstractModel implements IUserDataModel
	{
		private var _firstName:String;
		private var _lastName:String;
		private var _age:int;

		public function UserDataModel()
		{
			super();
		}

		public function get firstName():String
		{
			return _firstName;
		}

		public function set firstName(value:String):void
		{
			_firstName = value;

			dispatchMessage(UserDataModelMessageType.FIRSTNAME_CHANGED, _firstName);
		}

		public function get lastName():String
		{
			return _lastName;
		}

		public function set lastName(value:String):void
		{
			_lastName = value;

			dispatchMessage(UserDataModelMessageType.LASTNAME_CHANGED, _lastName);
		}

		public function get age():int
		{
			return _age;
		}

		public function set age(value:int):void
		{
			_age = value;

			dispatchMessage(UserDataModelMessageType.AGE_CHANGED, _age.toString());
		}
	}
}
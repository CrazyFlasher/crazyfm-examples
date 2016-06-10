/**
 * Created by Anton Nefjodov on 9.06.2016.
 */
package com.crazyfm.example.bubblePattern.models
{
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.core.mvc.model.AbstractModel;
	import com.crazyfm.example.bubblePattern.signals.AppViewSignalType;
	import com.crazyfm.example.bubblePattern.signals.UserDataModelSignalType;

	public class UserDataModel extends AbstractModel implements IUserDataModel
	{
		private var _firstName:String;
		private var _lastName:String;
		private var _age:int;

		public function UserDataModel()
		{
			addSignalListener(AppViewSignalType.FIRST_NAME_CLICKED, onFirstNameClicked);
		}

		private function onFirstNameClicked(e:ISignalEvent):void
		{
			firstName = "olo";
		}

		public function get firstName():String
		{
			return _firstName;
		}

		public function set firstName(value:String):void
		{
			_firstName = value;

			dispatchSignal(UserDataModelSignalType.FIRSTNAME_CHANGED);
		}

		public function get lastName():String
		{
			return _lastName;
		}

		public function set lastName(value:String):void
		{
			_lastName = value;

			dispatchSignal(UserDataModelSignalType.LASTNAME_CHANGED);
		}

		public function get age():int
		{
			return _age;
		}

		public function set age(value:int):void
		{
			_age = value;

			dispatchSignal(UserDataModelSignalType.AGE_CHANGED);
		}
	}
}
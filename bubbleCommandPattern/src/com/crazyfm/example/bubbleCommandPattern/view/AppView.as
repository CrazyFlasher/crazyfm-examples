/**
 * Created by Anton Nefjodov on 9.06.2016.
 */
package com.crazyfm.example.bubbleCommandPattern.view
{
	import com.crazyfm.core.mvc.message.IMessage;
	import com.crazyfm.core.mvc.view.AbstractView;
	import com.crazyfm.example.bubbleCommandPattern.messages.AppViewMessageType;
	import com.crazyfm.example.bubbleCommandPattern.messages.UserDataModelMessageType;
	import com.crazyfm.example.bubbleCommandPattern.view.ui.InputForm;

	import flash.display.DisplayObjectContainer;
	import flash.events.Event;

	public class AppView extends AbstractView implements IAppView
	{
		private var firstName:InputForm;
		private var lastName:InputForm;
		private var age:InputForm;

		[Autowired]
		public var container:DisplayObjectContainer;

		public function AppView()
		{
			super();
		}

		[PostConstruct]
		public function init():void
		{
			firstName = new InputForm();
			lastName = new InputForm();
			age = new InputForm();

			firstName.x = 0;
			firstName.y = (container.stage.stageWidth - firstName.width) / 2;

			lastName.x = 130;
			lastName.y = firstName.y;

			age.x = 260;
			age.y = firstName.y;

			container.addChild(firstName);
			container.addChild(lastName);
			container.addChild(age);

			firstName.addEventListener("formButtonClicked", buttonClicked);
			lastName.addEventListener("formButtonClicked", buttonClicked);
			age.addEventListener("formButtonClicked", buttonClicked);

			addMessageListener(UserDataModelMessageType.FIRSTNAME_CHANGED, onFirstNameChanged);
			addMessageListener(UserDataModelMessageType.LASTNAME_CHANGED, onLastNameChanged);
			addMessageListener(UserDataModelMessageType.AGE_CHANGED, onAgeChanged);
		}

		private function onAgeChanged(message:IMessage):void
		{
			age.text = message.data as String;
		}

		private function onLastNameChanged(message:IMessage):void
		{
			lastName.text = message.data as String;
		}

		private function onFirstNameChanged(message:IMessage):void
		{
			firstName.text = message.data as String;
		}

		private function buttonClicked(event:Event):void
		{
			switch (event.currentTarget)
			{
				case firstName:
					dispatchMessage(AppViewMessageType.FIRST_NAME_CLICKED);
					break;
				case lastName:
					dispatchMessage(AppViewMessageType.LAST_NAME_CLICKED);
					break;
				case age:
					dispatchMessage(AppViewMessageType.AGE_CLICKED);
					break;
			}
		}

		override public function dispose():void
		{
			firstName.removeEventListener("formButtonClicked", buttonClicked);
			lastName.removeEventListener("formButtonClicked", buttonClicked);
			age.removeEventListener("formButtonClicked", buttonClicked);

			removeAllMessageListeners();

			super.dispose();
		}
	}
}

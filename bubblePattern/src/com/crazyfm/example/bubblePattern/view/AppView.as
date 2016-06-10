/**
 * Created by Anton Nefjodov on 9.06.2016.
 */
package com.crazyfm.example.bubblePattern.view
{
	import com.crazyfm.core.mvc.view.AbstractView;
	import com.crazyfm.example.bubblePattern.signals.AppViewSignalType;
	import com.crazyfm.example.bubblePattern.signals.UserDataModelSignalType;

	import flash.display.DisplayObjectContainer;

	import flash.events.MouseEvent;

	public class AppView extends AbstractView implements IAppView
	{
		private var firstName:Button;
		private var lastName:Button;
		private var age:Button;

		private var container:DisplayObjectContainer;

		public function AppView(container:DisplayObjectContainer)
		{
			super();

			this.container = container;
		}

		private function init():void
		{
			firstName = new Button();
			lastName = new Button();
			age = new Button();

			firstName.x = 0;
			firstName.y = (container.stage.stageWidth - firstName.width) / 2;

			lastName.x = 25;
			lastName.y = firstName.y;

			age.x = 50;
			age.y = firstName.y;

			container.addChild(firstName);
			container.addChild(lastName);
			container.addChild(age);

			container.addEventListener(MouseEvent.CLICK, buttonClick);

			addSignalListener(UserDataModelSignalType.FIRSTNAME_CHANGED, onFirstNameChanged);
			addSignalListener(UserDataModelSignalType.LASTNAME_CHANGED, onLastNameChanged);
			addSignalListener(UserDataModelSignalType.AGE_CHANGED, onAgeChanged);
		}

		public function onAgeChanged():void
		{
			age.alpha = age.alpha == 0.5 ? 1 : 0.5;
		}

		public function onLastNameChanged():void
		{
			lastName.alpha = lastName.alpha == 0.5 ? 1 : 0.5;
		}

		public function onFirstNameChanged():void
		{
			firstName.alpha = firstName.alpha == 0.5 ? 1 : 0.5;
		}

		private function buttonClick(event:MouseEvent):void
		{
			switch (event.target)
			{
				case firstName:
					dispatchSignal(AppViewSignalType.FIRST_NAME_CLICKED);
					break;
				case lastName:
					dispatchSignal(AppViewSignalType.LAST_NAME_CLICKED);
					break;
				case age:
					dispatchSignal(AppViewSignalType.AGE_CLICKED);
					break;
			}
		}

		override public function dispose():void
		{
			container.removeEventListener(MouseEvent.CLICK, buttonClick);
			removeAllSignalListeners();

			super.dispose();
		}
	}
}

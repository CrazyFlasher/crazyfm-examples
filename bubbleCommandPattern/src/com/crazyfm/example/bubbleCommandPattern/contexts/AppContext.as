/**
 * Created by Anton Nefjodov on 9.06.2016.
 */
package com.crazyfm.example.bubbleCommandPattern.contexts
{
	import com.crazyfm.core.factory.AppFactory;
	import com.crazyfm.core.mvc.context.AbstractContext;
	import com.crazyfm.example.bubbleCommandPattern.commands.ChangeAgeCommand;
	import com.crazyfm.example.bubbleCommandPattern.commands.ChangeFirstNameCommand;
	import com.crazyfm.example.bubbleCommandPattern.commands.ChangeLastNameCommand;
	import com.crazyfm.example.bubbleCommandPattern.models.IUserDataModel;
	import com.crazyfm.example.bubbleCommandPattern.models.UserDataModel;
	import com.crazyfm.example.bubbleCommandPattern.messages.AppViewMessageType;
	import com.crazyfm.example.bubbleCommandPattern.view.AppView;
	import com.crazyfm.example.bubbleCommandPattern.view.IAppView;

	import flash.display.DisplayObjectContainer;

	public class AppContext extends AbstractContext
	{
		private var userModel:IUserDataModel;
		private var appView:IAppView;

		[Autowired]
		public var displayObjectContainer:DisplayObjectContainer;

		public function AppContext()
		{
			super();
		}

		[PostConstruct]
		override public function init():void
		{
			super.init();

			factory.mapToType(IUserDataModel, UserDataModel)
				   .mapToType(IAppView, AppView)
				   .mapToValue(DisplayObjectContainer, displayObjectContainer);

			userModel = factory.getInstance(IUserDataModel);
			factory.mapToValue(IUserDataModel, userModel);
			addModel(userModel);

			appView = factory.getInstance(IAppView);
			addView(appView);

			map(AppViewMessageType.FIRST_NAME_CLICKED, ChangeFirstNameCommand);
			map(AppViewMessageType.LAST_NAME_CLICKED, ChangeLastNameCommand);
			map(AppViewMessageType.AGE_CLICKED, ChangeAgeCommand);
		}
	}
}

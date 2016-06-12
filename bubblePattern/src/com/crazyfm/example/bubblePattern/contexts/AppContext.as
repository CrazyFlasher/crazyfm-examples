/**
 * Created by Anton Nefjodov on 9.06.2016.
 */
package com.crazyfm.example.bubblePattern.contexts
{
	import com.crazyfm.core.factory.AppFactory;
	import com.crazyfm.core.factory.ns_app_factory;
	import com.crazyfm.core.mvc.context.AbstractContext;
	import com.crazyfm.example.bubblePattern.commands.ChangeAgeCommand;
	import com.crazyfm.example.bubblePattern.commands.ChangeFirstNameCommand;
	import com.crazyfm.example.bubblePattern.commands.ChangeLastNameCommand;
	import com.crazyfm.example.bubblePattern.models.IUserDataModel;
	import com.crazyfm.example.bubblePattern.models.UserDataModel;
	import com.crazyfm.example.bubblePattern.signals.AppViewSignalType;
	import com.crazyfm.example.bubblePattern.view.AppView;
	import com.crazyfm.example.bubblePattern.view.IAppView;

	import flash.display.DisplayObjectContainer;

	use namespace ns_app_factory;

	public class AppContext extends AbstractContext
	{
		private var userModel:IUserDataModel;
		private var appView:IAppView;

		private var displayObjectContainer:DisplayObjectContainer;

		public function AppContext(factory:AppFactory, displayObjectContainer:DisplayObjectContainer)
		{
			super(factory);

			this.displayObjectContainer = displayObjectContainer;

			init();
		}

		private function init():void
		{
			factory.map(IUserDataModel, UserDataModel);
			factory.map(IAppView, AppView);

			userModel = factory.getSingleton(IUserDataModel) as IUserDataModel;
			addModel(userModel);

			appView = factory.getInstance(IAppView, displayObjectContainer) as IAppView;
			addView(appView);

			/*map(AppViewSignalType.FIRST_NAME_CLICKED, ChangeFirstNameCommand);
			map(AppViewSignalType.LAST_NAME_CLICKED, ChangeLastNameCommand);
			map(AppViewSignalType.AGE_CLICKED, ChangeAgeCommand);*/
		}
	}
}

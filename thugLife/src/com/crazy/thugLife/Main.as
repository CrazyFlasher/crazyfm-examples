/**
 * Created by Anton Nefjodov on 13.06.2016.
 */
package com.crazy.thugLife
{
	import com.crazy.thugLife.main.contexts.IMainContext;
	import com.crazy.thugLife.main.contexts.MainContext;
	import com.crazyfm.core.factory.AppFactory;
	import com.crazyfm.core.factory.IAppFactory;

	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.Event;

	public class Main extends Sprite
	{
		private var mainContext:IMainContext;

		public function Main()
		{
			super();

			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init():void
		{
			var factory:IAppFactory = new AppFactory();
			factory.mapToType(IMainContext, MainContext)
				   .mapToValue(IAppFactory, factory)
				   .mapToValue(DisplayObjectContainer, this)
		           .mapToValue(Stage, stage);

			mainContext = factory.getInstance(IMainContext) as IMainContext;
		}
	}
}

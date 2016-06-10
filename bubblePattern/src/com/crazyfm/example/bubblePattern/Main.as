/**
 * Created by Anton Nefjodov on 9.06.2016.
 */
package com.crazyfm.example.bubblePattern
{
	import com.crazyfm.core.factory.AppFactory;
	import com.crazyfm.core.factory.ns_app_factory;
	import com.crazyfm.core.mvc.context.IContext;
	import com.crazyfm.example.bubblePattern.contexts.AppContext;

	import flash.display.Sprite;
	import flash.events.Event;

	use namespace ns_app_factory;

	public class Main extends Sprite
	{
		public function Main()
		{
			super();

			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event):void
		{
			var factory:AppFactory = new AppFactory();
			factory.map(IContext, AppContext);

			var context:IContext = factory.getInstance(IContext, factory, this) as IContext;
		}
	}
}

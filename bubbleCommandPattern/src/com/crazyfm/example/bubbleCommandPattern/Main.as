/**
 * Created by Anton Nefjodov on 9.06.2016.
 */
package com.crazyfm.example.bubbleCommandPattern
{
	import com.crazyfm.core.factory.AppFactory;
	import com.crazyfm.core.factory.IAppFactory;
	import com.crazyfm.core.mvc.context.IContext;
	import com.crazyfm.example.bubbleCommandPattern.contexts.AppContext;

	import flash.display.DisplayObjectContainer;

	import flash.display.Sprite;
	import flash.events.Event;

	public class Main extends Sprite
	{
		public function Main()
		{
			super();

			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event):void
		{
			var factory:IAppFactory = new AppFactory();
			factory.map(IContext, AppContext)
				   .map(DisplayObjectContainer, this);

			var context:IContext = factory.getInstance(IContext) as IContext;
		}
	}
}

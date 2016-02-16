/**
 * Created by Anton Nefjodov on 7.02.2016.
 */
package com.crazyfm.core.example.ballClick
{
	import com.crazyfm.core.example.ballClick.model.ApplicationContext;
	import com.crazyfm.core.example.ballClick.view.BallViewController;

	import flash.display.Sprite;

	/**
	 * Simple main application class, that creates parent IContext and adds IViewController to it.
	 */
	public class Main extends Sprite
	{
		public function Main()
		{
			//Creates new IContext
			var context:IContext = new ApplicationContext();

			//Creates new IViewController and passes this as visual DisplayObjectContainer
			var viewController:IViewController = new BallViewController(this);

			//Adds IViewController to IContext view controllers' list
			context.addViewController(viewController);
		}
	}
}

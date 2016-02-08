/**
 * Created by Anton Nefjodov on 7.02.2016.
 */
package com.crazyfm.example.ballClick
{
	import com.crazyfm.core.mvc.model.IContext;
	import com.crazyfm.core.mvc.view.IViewController;
	import com.crazyfm.example.ballClick.models.ApplicationContext;
	import com.crazyfm.example.ballClick.views.BallViewController;

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

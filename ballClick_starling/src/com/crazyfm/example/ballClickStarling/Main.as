/**
 * Created by Anton Nefjodov on 7.02.2016.
 */
package com.crazyfm.example.ballClickStarling
{
	import com.crazyfm.core.mvc.context.IContext;
	import com.crazyfm.core.mvc.view.IView;
	import com.crazyfm.example.ballClickStarling.models.ApplicationContext;
	import com.crazyfm.example.ballClickStarling.views.BallViewController;

	import starling.display.Sprite;

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
			var viewController:IView = new BallViewController(this);

			//Adds IViewController to IContext view controllers' list
			context.addView(viewController);
		}
	}
}

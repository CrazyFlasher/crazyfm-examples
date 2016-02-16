/**
 * Created by Anton Nefjodov on 7.02.2016.
 */
package com.crazyfm.example.ballClickStarlingNape
{
	import com.crazyfm.example.ballClickStarlingNape.models.PhysicsWorldContext;
	import com.crazyfm.example.ballClickStarlingNape.views.BallViewController;

	import starling.display.Sprite;
	import starling.events.Event;

	/**
	 * Simple main application class, that creates parent IContext and adds IViewController to it.
	 */
	public class Main extends Sprite
	{
		private var physicsModel:PhysicsWorldContext;

		public function Main()
		{
			physicsModel = new PhysicsWorldContext(new BallViewController(this));

			addEventListener(Event.ENTER_FRAME, enterFrame);
		}

		private function enterFrame(event:Event, passedTime:Number):void
		{
			physicsModel.step(passedTime * 4);
		}
	}
}

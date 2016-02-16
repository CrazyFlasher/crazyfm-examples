/**
 * Created by Anton Nefjodov on 7.02.2016.
 */
package com.crazyfm.core.example.ballClick.model
{
	import com.crazyfm.core.example.ballClick.events.BallViewEventEnum;

	/**
	 * Simple application context, that creates and work with ball model.
	 * Listens BallViewEventEnum.BALL_CLICKED signal.
	 */
	public class ApplicationContext extends Context
	{
		private var _ball:BallModel;

		public function ApplicationContext()
		{
			super();

			init();
		}

		private function init():void
		{
			//Creates BallModel
			_ball = new BallModel();

			//Adds model to model list
			addModel(_ball);

			//Listens BallViewEventEnum.BALL_CLICKED signal
			addSignalListener(BallViewEventEnum.BALL_CLICKED, ballClicked);
		}

		//BallViewEventEnum.BALL_CLICKED handler
		private function ballClicked(event:ISignalEvent):void
		{
			//Asks BallModel to generate new coordinates
			_ball.generateRandomCoordinates();
		}
	}
}

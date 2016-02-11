/**
 * Created by Anton Nefjodov on 7.02.2016.
 */
package com.crazyfm.example.ballClickStarlingNape.models
{
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.core.mvc.model.Context;
	import com.crazyfm.example.ballClickStarlingNape.signals.BallViewSignalEnum;

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
			addSignalListener(BallViewSignalEnum.BALL_CLICKED, ballClicked);
		}

		//BallViewEventEnum.BALL_CLICKED handler
		private function ballClicked(event:ISignalEvent):void
		{
			//Asks BallModel to generate new coordinates
			_ball.generateRandomCoordinates();
		}
	}
}

/**
 * Created by Anton Nefjodov on 7.02.2016.
 */
package com.crazyfm.example.model
{
	import com.crazyfm.mvc.event.ISignalEvent;
	import com.crazyfm.mvc.model.Context;

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
			_ball = new BallModel();
			addModel(_ball);

			addSignalListener("ballClicked", ballClicked);
		}

		private function ballClicked(event:ISignalEvent):void
		{
			_ball.generateRandomCoords();
		}
	}
}

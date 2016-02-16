/**
 * Created by Anton Nefjodov on 7.02.2016.
 */
package com.crazyfm.core.example.ballClick.view
{
	import com.crazyfm.core.example.ballClick.events.BallModelEventEnum;
	import com.crazyfm.core.example.ballClick.events.BallViewEventEnum;

	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	/**
	 * Simple ball view controllers, that creates BallView,
	 * listens user input events, and dispatches signal to IContext.
	 */
	public class BallViewController extends ViewController
	{
		private var _ball:BallView;

		public function BallViewController(container:DisplayObjectContainer)
		{
			super(container);

			init();
		}

		private function init():void
		{
			//Creates ball view object
			_ball = new BallView();

			//Adds to display list
			_container.addChild(_ball);

			//Ask ball to listen MouseEvent.CLICK event
			_ball.addEventListener(MouseEvent.CLICK, ballClicked);

			//Listens BallModelEventEnum.BALL_COORDINATES_CHANGED signal
			addSignalListener(BallModelEventEnum.BALL_COORDINATES_CHANGED, updateBallPosition);
		}

		private function ballClicked(event:MouseEvent):void
		{
			//Dispatches BallViewEventEnum.BALL_CLICKED signal to IContext
			dispatchSignal(BallViewEventEnum.BALL_CLICKED);
		}

		//Handles received BallModelEventEnum.BALL_COORDINATES_CHANGED signal from IContext
		private function updateBallPosition(event:ISignalEvent):void
		{
			//Data received from IContext model hierarchy
			var position:Point = event.data as Point;

			//Updates position of visual ball
			_ball.x = position.x;
			_ball.y = position.y;
		}
	}
}

/**
 * Created by Anton Nefjodov on 7.02.2016.
 */
package com.crazyfm.example.ballClickStarlingNape.views
{
	import com.crazyfm.core.extension.starlingApp.mvc.view.StarlingViewController;
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.example.ballClickStarlingNape.signals.BallModelSignalEnum;
	import com.crazyfm.example.ballClickStarlingNape.signals.BallViewSignalEnum;

	import flash.geom.Point;

	import starling.display.DisplayObjectContainer;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	/**
	 * Simple ball view controllers, that creates BallView,
	 * listens user input events, and dispatches signal to IContext.
	 */
	public class BallViewController extends StarlingViewController
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
			_ball.addEventListener(TouchEvent.TOUCH, ballClicked);

			//Listens BallModelSignalEnum.BALL_COORDINATES_CHANGED signal
			addSignalListener(BallModelSignalEnum.BALL_COORDINATES_CHANGED, updateBallPosition);
		}

		private function ballClicked(event:TouchEvent):void
		{
			if (event.getTouch(_ball, TouchPhase.ENDED))
			{
				//Dispatches BallViewSignalEnum.BALL_CLICKED signal to IContext
				dispatchSignal(BallViewSignalEnum.BALL_CLICKED);
			}
		}

		//Handles received BallModelSignalEnum.BALL_COORDINATES_CHANGED signal from IContext
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

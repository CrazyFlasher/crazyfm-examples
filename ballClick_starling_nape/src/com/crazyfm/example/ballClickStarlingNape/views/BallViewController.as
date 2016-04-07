/**
 * Created by Anton Nefjodov on 7.02.2016.
 */
package com.crazyfm.example.ballClickStarlingNape.views
{
	import com.crazyfm.example.ballClickStarlingNape.signals.BallViewSignalEnum;
	import com.crazyfm.extension.starlingApp.mvc.view.StarlingView;

	import nape.geom.Vec2;

	import starling.display.DisplayObjectContainer;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	/**
	 * Simple ball view controllers, that creates BallView,
	 * listens user input events, and dispatches signal to IContext.
	 */
	public class BallViewController extends StarlingView
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
			container.addChild(_ball);

			//Ask ball to listen TouchEvent.TOUCH event
			_ball.addEventListener(TouchEvent.TOUCH, ballClicked);
		}

		private function ballClicked(event:TouchEvent):void
		{
			if (event.getTouch(_ball, TouchPhase.ENDED))
			{
				//Dispatches BallViewSignalEnum.BALL_MOVE_TO_NEW_POSITION signal to IContext
				dispatchSignal(BallViewSignalEnum.BALL_MOVE_TO_NEW_POSITION);
			}
		}

		public function updateTransform(position:Vec2):void
		{
			_ball.x = position.x;
			_ball.y = position.y;
		}
	}
}

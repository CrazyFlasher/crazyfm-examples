/**
 * Created by Anton Nefjodov on 7.02.2016.
 */
package com.crazyfm.example.ballClick.views
{
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.core.mvc.view.ViewController;
	import com.crazyfm.example.ballClick.signals.BallModelSignalEnum;
	import com.crazyfm.example.ballClick.signals.BallViewSignalEnum;

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
			container.addChild(_ball);

			//Ask ball to listen MouseEvent.CLICK event
			_ball.addEventListener(MouseEvent.CLICK, ballClicked);

			//Listens BallModelSignalEnum.BALL_COORDINATES_CHANGED signal
			addSignalListener(BallModelSignalEnum.BALL_COORDINATES_CHANGED, updateBallPosition);
		}

		private function ballClicked(event:MouseEvent):void
		{
			//Dispatches BallViewSignalEnum.BALL_CLICKED signal to IContext
			dispatchSignal(BallViewSignalEnum.BALL_CLICKED);
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

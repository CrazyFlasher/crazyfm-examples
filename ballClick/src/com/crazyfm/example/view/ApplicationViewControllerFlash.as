/**
 * Created by Anton Nefjodov on 7.02.2016.
 */
package com.crazyfm.example.view
{
	import com.crazyfm.mvc.event.ISignalEvent;
	import com.crazyfm.mvc.view.ViewController;

	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	public class ApplicationViewControllerFlash extends ViewController
	{
		private var _ball:BallView;

		public function ApplicationViewControllerFlash(container:DisplayObjectContainer)
		{
			super(container);

			init();
		}

		private function init():void
		{
			_ball = new BallView();
			_container.addChild(_ball);

			_ball.addEventListener(MouseEvent.CLICK, ballClicked);

			addSignalListener("ballCoordsChanged", updateBallPosition);
		}

		private function ballClicked(event:MouseEvent):void
		{
			dispatchSignal("ballClicked");
		}

		private function updateBallPosition(event:ISignalEvent):void
		{
			var position:Point = event.data as Point;
			_ball.x = position.x;
			_ball.y = position.y;
		}
	}
}

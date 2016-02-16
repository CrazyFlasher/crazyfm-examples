/**
 * Created by Anton Nefjodov on 7.02.2016.
 */
package com.crazyfm.core.example.ballClick.view
{
	import flash.display.Sprite;

	/**
	 * Simple ball visual class.
	 */
	public class BallView extends Sprite
	{
		public function BallView()
		{
			super();

			init();
		}

		private function init():void
		{
			//Draws red ball
			graphics.beginFill(0xFF0000);
			graphics.drawCircle(0, 0, 50);
			graphics.endFill();
		}
	}
}

/**
 * Created by Anton Nefjodov on 7.02.2016.
 */
package com.crazyfm.example.ballClickStarling.views
{
	import starling.display.Shape;
	import starling.display.Sprite;

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
			var shape:Shape = new Shape();
			//Draws red ball
			shape.graphics.beginFill(0xFF0000);
			shape.graphics.drawCircle(0, 0, 50);
			shape.graphics.endFill();

			addChild(shape);
		}
	}
}

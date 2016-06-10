/**
 * Created by Anton Nefjodov on 9.06.2016.
 */
package com.crazyfm.example.bubblePattern.view
{
	import flash.display.Shape;
	import flash.display.Sprite;

	public class Button extends Sprite
	{
		public function Button()
		{
			super();

			init();
		}

		private function init():void
		{
			var shape:Shape = new Shape();
			shape.graphics.beginFill(0xFF0000);
			shape.graphics.drawRect(0, 0, 20, 10);
			shape.graphics.endFill();
			addChild(shape);
		}
	}
}

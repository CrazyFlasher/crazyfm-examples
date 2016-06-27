/**
 * Created by Anton Nefjodov on 27.06.2016.
 */
package
{
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;

	/**
	 * Main class that will be initialized after Starling successful initialization.
	 */
	public class Main extends Sprite
	{
		public function Main()
		{
			super();

			addEventListener(Event.ADDED_TO_STAGE, added);
		}

		private function added():void
		{
			//Lets draw circle to test, that everything is OK
			drawCircle();
		}

		private function drawCircle():void
		{
			var shape:Shape = new Shape();
			var radius:int = 50;

			shape.graphics.beginFill(0xFFCC00);
			shape.graphics.drawCircle(stage.stageWidth / 2, stage.stageHeight / 2, radius);
			shape.graphics.endFill();

			addChild(shape);
		}
	}
}

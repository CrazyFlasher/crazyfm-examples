/**
 * Created by Anton Nefjodov on 21.03.2016.
 */
package components
{
	import com.crazyfm.extension.goSystem.IGameComponent;

	import starling.display.DisplayObjectContainer;
	import starling.display.Shape;
	import starling.display.Sprite;

	public class BallViewComponent extends ViewComponent
	{
		private var physComponent:PhysObjectComponent;

		private var ball:Sprite;

		public function BallViewComponent()
		{
			super();
		}

		override public function setViewContainer(value:DisplayObjectContainer):IGameComponent
		{
			if (ball)
			{
				if (ball.parent)
				{
					ball.removeFromParent(true);
				}
				ball = null;
			}

			ball = new Sprite();
			value.addChild(ball);

			var shape:Shape = new Shape();
			//Draws red ball
			shape.graphics.beginFill(0xFF0000);
			shape.graphics.drawCircle(0, 0, 50);
			shape.graphics.endFill();

			ball.addChild(shape);

			return super.setViewContainer(value);
		}

		override public function dispose():void
		{
			physComponent = null;
			if (ball)
			{
				if (ball.parent)
				{
					ball.removeFromParent(true);
				}
				ball = null;
			}

			super.dispose();
		}

		override public function advanceTime(time:Number):void
		{
			super.advanceTime(time);

			if (!physComponent)
			{
				physComponent = gameObject.getComponentByType(PhysObjectComponent) as PhysObjectComponent;
			}

			ball.x = physComponent.body.position.x;
			ball.y = physComponent.body.position.y;
		}
	}
}

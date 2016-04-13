/**
 * Created by Anton Nefjodov on 13.04.2016.
 */
package com.crazy.thugLife.goSystem.components.view
{
	import com.crazyfm.devkit.goSystem.components.physyics.view.starling.PhysBodyObjectView;

	import nape.geom.Vec2;

	import starling.display.DisplayObjectContainer;
	import starling.display.Shape;
	import starling.display.Sprite;

	public class UserSkin extends PhysBodyObjectView
	{
		public function UserSkin(viewContainer:DisplayObjectContainer)
		{
			super(viewContainer);
		}

		private function drawSkin():void
		{
			_skin = new Sprite();

			var skin:Sprite = _skin as Sprite;
			var shape:Shape = new Shape();
			skin.addChild(shape);

			shape.graphics.beginFill(0x00CC00);
			var pos:Vec2 = model.body.worldPointToLocal(model.body.bounds.min);
			var width:Number = Math.abs(model.body.bounds.max.x - model.body.bounds.min.x);
			var height:Number = Math.abs(model.body.bounds.max.y - model.body.bounds.min.y);
			shape.graphics.drawRoundRect(pos.x, pos.y, width, height, 10);
			shape.graphics.endFill();

			viewContainer.addChild(skin);
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			if (!skin)
			{
				drawSkin();
			}

			skin.x = model.body.position.x;
			skin.y = model.body.position.y;
			skin.rotation = model.body.rotation;
		}
	}
}

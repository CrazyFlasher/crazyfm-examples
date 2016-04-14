/**
 * Created by Anton Nefjodov on 13.04.2016.
 */
package com.crazy.thugLife.goSystem.components.view
{
	import com.crazyfm.devkit.goSystem.components.physyics.view.starling.PhysBodyObjectView;

	import nape.geom.Vec2;
	import nape.geom.Vec2List;
	import nape.shape.Shape;

	import starling.display.DisplayObjectContainer;
	import starling.display.Shape;
	import starling.display.Sprite;

	public class FloorSkin extends PhysBodyObjectView
	{
		public function FloorSkin(viewContainer:DisplayObjectContainer)
		{
			super(viewContainer);
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			if (!skin)
			{
				drawSkin();
			}
		}

		private function drawSkin():void
		{
			_skin = new Sprite();

			var skin:Sprite = _skin as Sprite;
			var shape:starling.display.Shape = new starling.display.Shape();
			skin.addChild(shape);

			shape.graphics.lineStyle(3, 0xFFCC00);

			for (var i:int = 0; i < model.body.shapes.length; i++)
			{
				var napeShape:nape.shape.Shape = model.body.shapes.at(i);
				var vertices:Vec2List = napeShape.castPolygon.localVerts;
				for (var i2:int = 0; i2 < vertices.length; i2++)
				{
					var vertex:Vec2 = vertices.at(i2);
					if (i2 == 0)
					{
						shape.graphics.moveTo(vertex.x, vertex.y);
					}else
					{
						shape.graphics.lineTo(vertex.x, vertex.y);

						if (i2 == vertices.length - 1)
						{
							shape.graphics.lineTo(vertices.at(0).x, vertices.at(0).y);
						}
					}
				}
			}

			viewContainer.addChild(skin);
		}
	}
}

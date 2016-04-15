/**
 * Created by Anton Nefjodov on 13.04.2016.
 */
package com.crazy.thugLife.goSystem.components.view
{
	import com.crazyfm.devkit.goSystem.components.physyics.view.starling.PhysBodyObjectView;
	import com.crazyfm.extensions.physics.vo.ShapeDataVo;
	import com.crazyfm.extensions.physics.vo.VertexDataVo;

	import flash.geom.Matrix;
	import flash.geom.Point;

	import nape.geom.Mat23;

	import starling.display.DisplayObjectContainer;
	import starling.display.Shape;
	import starling.display.Sprite;

	public class FloorView extends PhysBodyObjectView
	{
		private var shapesDataList:Vector.<ShapeDataVo>;

		public function FloorView(viewContainer:DisplayObjectContainer, shapesDataList:Vector.<ShapeDataVo>)
		{
			super(viewContainer);

			this.shapesDataList = shapesDataList;
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
			var shape:Shape = new Shape();
			skin.addChild(shape);

			shape.graphics.lineStyle(3, 0xFFCC00);

			var p:Point;
			var m:Matrix;

			var shapeData:ShapeDataVo;
			var vertexData:VertexDataVo;

			for each (shapeData in shapesDataList)
			{
				m = Mat23.rotation(shapeData.angle).concat(Mat23.translation(shapeData.x, shapeData.y)).toMatrix();

				p = m.transformPoint(new Point(shapeData.vertexDataList[0].x, shapeData.vertexDataList[0].y));

				shape.graphics.moveTo(p.x, p.y);

				for (var i:int = 1; i < shapeData.vertexDataList.length; i++)
				{
					vertexData = shapeData.vertexDataList[i];
					p = m.transformPoint(new Point(vertexData.x, vertexData.y));
					shape.graphics.lineTo(p.x, p.y);
				}

				p = m.transformPoint(new Point(shapeData.vertexDataList[0].x, shapeData.vertexDataList[0].y));

				shape.graphics.lineTo(p.x, p.y);
			}

			/*for (var i:int = 0; i < model.body.shapes.length; i++)
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
			}*/

			viewContainer.addChild(skin);
		}
	}
}

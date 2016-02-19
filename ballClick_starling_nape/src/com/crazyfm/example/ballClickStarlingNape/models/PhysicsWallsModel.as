/**
 * Created by Anton Nefjodov on 16.02.2016.
 */
package com.crazyfm.example.ballClickStarlingNape.models
{

	import nape.phys.BodyType;
	import nape.shape.Polygon;

	/**
	 * Physics walls model class.
	 */
	public class PhysicsWallsModel extends PhysicsObjectModel
	{
		public function PhysicsWallsModel()
		{
			super(BodyType.STATIC);
		}

		override protected function addBodyShapes():void
		{
			_body.shapes.add(new Polygon(Polygon.rect(0, 0, 500, 20)));
			_body.shapes.add(new Polygon(Polygon.rect(500, 0, 20, 500)));
			_body.shapes.add(new Polygon(Polygon.rect(0, 500, 500, 20)));
			_body.shapes.add(new Polygon(Polygon.rect(0, 0, 20, 500)));
		}
	}
}

/**
 * Created by Anton Nefjodov on 16.02.2016.
 */
package com.crazyfm.example.ballClickStarlingNape.models
{
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Circle;

	/**
	 * Physics ball model class.
	 */
	public class PhysicsBallContext extends PhysicsObjectContext
	{
		public function PhysicsBallContext()
		{
			super(BodyType.DYNAMIC);
		}

		override protected function addBodyShapes():void
		{
			_body.shapes.add(new Circle(20));

			_body.setShapeMaterials(new Material(1.5));
		}
	}
}

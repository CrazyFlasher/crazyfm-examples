/**
 * Created by Anton Nefjodov on 13.02.2016.
 */
package com.crazyfm.example.ballClickStarlingNape.models
{
	import com.crazyfm.core.mvc.model.Context;

	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.shape.Circle;

	public class PhysicsBallModel extends Context
	{
		private var _body:Body;

		public function PhysicsBallModel()
		{
			super();

			init();
		}

		private function init():void
		{
			_body = new Body();
			_body.shapes.add(new Circle(50));
		}

		public function get body():Body
		{
			return _body;
		}

		override public function dispose():void
		{
			_body = null;

			super.dispose();
		}

		public function set position(position:Vec2):void
		{
			_body.position = position;
		}

		public function get position():Vec2
		{
			return _body.position;
		}
	}
}

/**
 * Created by Anton Nefjodov on 13.02.2016.
 */
package com.crazyfm.example.ballClickStarlingNape.models
{
	import com.crazyfm.core.mvc.model.IContext;
	import com.crazyfm.core.mvc.model.IModel;
	import com.crazyfm.core.mvc.model.ModelContainer;

	import nape.geom.Vec2;
	import nape.space.Space;

	public class PhysicsWorldContainer extends ModelContainer
	{
		private var _space:Space;
		private var _ball:PhysicsBallModel;

		public function PhysicsWorldContainer()
		{
			init();
		}

		private function init():void
		{
			_space = new Space(new Vec2(0, 0));
		}

		public function createBall():IContext
		{
			_ball = new PhysicsBallModel();
			_ball.position = new Vec2(50, 50);

			addModel(_ball);

			return _ball;
		}

		public function step(deltaTime:uint):void
		{
			_space.step(deltaTime);
		}

		override public function addModel(model:IModel):void
		{
			super.addModel(model);

			_space.bodies.add((model as PhysicsBallModel).body);
		}

		override public function disposeWithAllChildren():void
		{
			_space.clear();
			_space = null;
			_ball = null;

			super.disposeWithAllChildren();
		}
	}
}

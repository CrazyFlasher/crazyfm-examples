/**
 * Created by Anton Nefjodov on 13.02.2016.
 */
package com.crazyfm.example.ballClickStarlingNape.models
{
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.core.mvc.model.Context;
	import com.crazyfm.core.mvc.model.IModel;
	import com.crazyfm.core.mvc.view.IViewController;
	import com.crazyfm.example.ballClickStarlingNape.signals.BallViewSignalEnum;
	import com.crazyfm.example.ballClickStarlingNape.signals.PhysicsWorldSignalEnum;

	import nape.geom.Vec2;
	import nape.space.Space;

	public class PhysicsWorldContext extends Context
	{
		private var _space:Space;

		private var _walls:PhysicsWallsModel;
		private var _ball:PhysicsObjectModel

		private var _mainViewController:IViewController;


		public function PhysicsWorldContext(mainViewController:IViewController)
		{
			_mainViewController = mainViewController;

			init();
		}

		private function init():void
		{
			_space = new Space(new Vec2(0, 10));

			createWalls();
			createBall();
		}

		private function createWalls():void
		{
			_walls = new PhysicsWallsModel();
			addModel(_walls);
		}

		private function createBall():void
		{
			_ball = new PhysicsBallModel();
			_ball.position = new Vec2(70, 70);
			_ball.velocity = new Vec2(50, 0);
			addModel(_ball);

			_ball.addViewController(_mainViewController);

			addSignalListener(BallViewSignalEnum.BALL_MOVE_TO_NEW_POSITION, ballNewPosition);
		}

		private function ballNewPosition(event:ISignalEvent):void
		{
			_ball.position = new Vec2(10 + Math.floor(Math.random() * 450), 10 + Math.floor(Math.random() * 450));
		}

		public function step(deltaTime:Number):void
		{
			_space.step(deltaTime);

			dispatchSignalToChildren(PhysicsWorldSignalEnum.WORLD_STEP);
		}

		override public function addModel(model:IModel):void
		{
			super.addModel(model);

			_space.bodies.add((model as PhysicsObjectModel).body);
		}

		override public function disposeWithAllChildren():void
		{
			_space.clear();
			_space = null;
			_walls = null;

			super.disposeWithAllChildren();
		}
	}
}

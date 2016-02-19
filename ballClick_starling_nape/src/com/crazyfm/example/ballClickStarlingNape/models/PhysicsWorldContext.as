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
		//Physics space
		private var _space:Space;

		//Walls physics model
		private var _walls:PhysicsObjectModel;

		//Ball physics model
		private var _ball:PhysicsObjectModel;

		//View controller, that is used as ball model view
		private var _mainViewController:IViewController;

		public function PhysicsWorldContext(mainViewController:IViewController)
		{
			_mainViewController = mainViewController;

			init();
		}

		private function init():void
		{
			//Create new physics space
			_space = new Space(new Vec2(0, 10));

			//Create physics walls
			createWalls();

			//Create physics ball
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

			//Adding view controller to ball physics model
			_ball.addViewController(_mainViewController);

			//Listening view controller event
			addSignalListener(BallViewSignalEnum.BALL_MOVE_TO_NEW_POSITION, ballNewPosition);
		}

		private function ballNewPosition(event:ISignalEvent):void
		{
			//Updating ball position to random one
			_ball.position = new Vec2(10 + Math.floor(Math.random() * 450), 10 + Math.floor(Math.random() * 450));
		}

		/**
		 * Physics step
		 * @param deltaTime
		 */
		public function step(deltaTime:Number):void
		{
			//Updating space
			_space.step(deltaTime);

			//Dispatching signal to child models (e.q. _ball, walls)
			dispatchSignalToChildren(PhysicsWorldSignalEnum.WORLD_STEP);
		}

		/**
		 * Adding phys model to context and to space
		 * @param model
		 */
		override public function addModel(model:IModel):void
		{
			super.addModel(model);

			_space.bodies.add((model as PhysicsObjectModel).body);
		}

		/**
		 * Removing space and other models.
		 */
		override public function disposeWithAllChildren():void
		{
			_space.clear();
			_space = null;
			_walls = null;

			super.disposeWithAllChildren();
		}
	}
}

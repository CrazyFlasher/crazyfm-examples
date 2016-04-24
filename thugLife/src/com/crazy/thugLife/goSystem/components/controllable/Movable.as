/**
 * Created by Anton Nefjodov on 24.04.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable
{
	import com.crazyfm.devkit.goSystem.components.physyics.event.PhysObjectSignalData;

	import nape.callbacks.InteractionCallback;
	import nape.hacks.ForcedSleep;

	public class Movable extends AbstractControllable implements IControllable
	{
		protected var walkSpeed:Number;
		protected var rotateToPath:Boolean;

		private var _isMoving:Boolean;
		private var _isOnLegs:Boolean;

		//need to prevent nape lib bug, after putting object manually to sleep.
		private var _collisionJustEnded:Boolean;

		public function Movable(walkSpeed:Number, rotateToPath:Boolean = true)
		{
			super();

			this.walkSpeed = walkSpeed;
			this.rotateToPath = rotateToPath;
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			_collisionJustEnded = false;
		}

		override protected function initializePhysObject():void
		{
			super.initializePhysObject();

			body.allowRotation = false;
		}

		public function moveLeft():void
		{
			_isMoving = true;

			body.velocity.x = -walkSpeed;
		}

		public function moveRight():void
		{
			_isMoving = true;

			body.velocity.x = walkSpeed;
		}

		public function moveUp():void
		{

		}

		public function moveDown():void
		{

		}

		public function stop():void
		{
			_isMoving = false;

			body.velocity.x = 0;
		}

		private function computeIsOnLegs(collision:InteractionCallback):Boolean
		{
			if (collision.arbiters.length == 0) return false;

			for (var i:int = 0; i < collision.arbiters.length; i++)
			{
				if (body.worldVectorToLocal(collision.arbiters.at(i).collisionArbiter.normal).y < 0.3)
				{
					return false;
				}
			}

			return true;
		}

		override protected function handleCollisionEnd(collisionData:PhysObjectSignalData):void
		{
			super.handleCollisionEnd(collisionData);

			_collisionJustEnded = true;
		}

		override protected function handleCollisionBegin(collisionData:PhysObjectSignalData):void
		{
			super.handleCollisionBegin(collisionData);

			_isOnLegs = computeIsOnLegs(collisionData.collision);

			if (!isOnLegs) return;

			rotateBodyToNormal(collisionData.collision);

			if (!_isMoving)
			{
				body.velocity.setxy(0, 0);

				if (!body.isSleeping && !_collisionJustEnded)
				{
					ForcedSleep.sleepBody(body);
				}
			}
		}

		protected function get isOnLegs():Boolean
		{
			return _isOnLegs;
		}
	}
}

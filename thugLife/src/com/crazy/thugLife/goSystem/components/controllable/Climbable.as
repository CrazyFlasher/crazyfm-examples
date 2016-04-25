/**
 * Created by Anton Nefjodov on 24.04.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable
{
	import com.crazyfm.devkit.goSystem.components.physyics.event.PhysObjectSignalData;

	import nape.phys.GravMassMode;

	import nape.shape.Shape;

	public class Climbable extends Jumpable implements IControllable
	{
		protected var climbSpeed:Number;

		private var _isClimbing:Boolean;
		private var _canClimb:Boolean;

		private var gravityMass:Number;

		public function Climbable(walkSpeed:Number, jumpSpeed:Number, climbSpeed:Number, rotateToPath:Boolean = true)
		{
			super(walkSpeed, jumpSpeed, rotateToPath);

			this.climbSpeed = climbSpeed;
		}

		override public function interact(timePassed:Number):void
		{
			if (!_isClimbing)
			{
				super.interact(timePassed);
			}else
			{
				if (body.gravMass != 0)
				{
					body.gravMass = 0;
				}
			}
		}

		override public function moveUp():void
		{
			if (_canClimb)
			{
				startClimbing();
			}else
			if (_isClimbing)
			{
				body.velocity.y = -climbSpeed;
			}else
			{
				super.moveUp();
			}
		}
		override public function moveDown():void
		{
			if (_canClimb)
			{
				startClimbing();
			}
			if (_isClimbing)
			{
				body.velocity.y = climbSpeed;
			}else
			{
				super.moveDown();
			}
		}

		override protected function handleCollisionBegin(collisionData:PhysObjectSignalData):void
		{
			super.handleCollisionBegin(collisionData);

			if (!isOnLegs) return;

			if (_isClimbing)
			{
				stopClimbing();
			}
		}

		override protected function handleSensorBegin(collisionData:PhysObjectSignalData):void
		{
			super.handleSensorBegin(collisionData);

			if (!isLadder(collisionData.otherShape)) return;

			_canClimb = true;
		}

		override protected function handleSensorEnd(collisionData:PhysObjectSignalData):void
		{
			super.handleSensorEnd(collisionData);

			if (!isLadder(collisionData.otherShape)) return;

			stopClimbing();
		}

		private function startClimbing():void
		{
			_canClimb = false;
			_isClimbing = true;

			body.velocity.setxy(0, 0);
			rotate(0);

			/*var posX:Number = ladder.bounds.min.x + (ladder.bounds.max.x - ladder.bounds.min.x) / 2;
			 body.position.x = posX;*/
		}

		private function stopClimbing():void
		{
			_canClimb = false;
			_isClimbing = false;
			body.gravMass = gravityMass;
			body.gravMassMode = GravMassMode.DEFAULT;
		}

		private function isLadder(shape:Shape):Boolean
		{
			return shape.userData.id.search("ladder") != -1;
		}

		override public function stopVertical():void
		{
			super.stopVertical();

			if (_isClimbing)
			{
				body.velocity.y = 0;
			}
		}

		override protected function initializePhysObject():void
		{
			super.initializePhysObject();

			gravityMass = body.gravMass;
		}


		override protected function tryToSleep():void
		{
			if (!_isClimbing)
			{
				super.tryToSleep();
			}
		}
	}
}

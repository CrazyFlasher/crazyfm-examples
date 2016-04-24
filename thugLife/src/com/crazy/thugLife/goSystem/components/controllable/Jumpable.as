/**
 * Created by Anton Nefjodov on 24.04.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable
{
	import com.crazyfm.devkit.goSystem.components.physyics.event.PhysObjectSignalData;

	public class Jumpable extends Movable implements IControllable
	{
		protected var jumpSpeed:Number;

		private var _isJumping:Boolean;
		private var _isInAir:Boolean = true;

		public function Jumpable(walkSpeed:Number, jumpSpeed:Number, rotateToPath:Boolean = true)
		{
			super(walkSpeed, rotateToPath);

			this.jumpSpeed = jumpSpeed;
		}

		override public function moveUp():void
		{
			super.moveUp();

			if (!_isJumping)
			{
				setJumpState();

				body.velocity.y = -jumpSpeed;
			}
		}

		override protected function handleCollisionEnd(collisionData:PhysObjectSignalData):void
		{
			super.handleCollisionEnd(collisionData);

			_isInAir = true;
		}

		override protected function handleCollisionBegin(collisionData:PhysObjectSignalData):void
		{
			super.handleCollisionBegin(collisionData);

			if (!isOnLegs) return;

			_isInAir = false;
			_isJumping = false;
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			if (!_isJumping && _isInAir)
			{
				if (Math.abs(body.velocity.y) > jumpSpeed / 6)
				{
					setJumpState();
				}
			}
		}

		private function setJumpState():void
		{
			_isJumping = true;

			rotate(0);
		}
	}
}

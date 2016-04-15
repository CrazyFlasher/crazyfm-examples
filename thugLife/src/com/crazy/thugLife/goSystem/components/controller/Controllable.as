/**
 * Created by Anton Nefjodov on 24.03.2016.
 */
package com.crazy.thugLife.goSystem.components.controller
{
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.devkit.goSystem.components.physyics.event.PhysObjectSignalEnum;
	import com.crazyfm.devkit.goSystem.components.physyics.model.IPhysBodyObjectModel;
	import com.crazyfm.extension.goSystem.GameComponent;

	import nape.callbacks.InteractionCallback;
	import nape.hacks.ForcedSleep;

	public class Controllable extends GameComponent implements IControllable
	{
		private var physModel:IPhysBodyObjectModel;

		private var _isJumping:Boolean;
		private var _isInAir:Boolean = true;
		private var _isWalking:Boolean;

		private var walkSpeed:Number = 0;
		private var jumpSpeed:Number = 0;
		private var rotateToPath:Boolean;

		public function Controllable(walkSpeed:Number, jumpSpeed:Number, rotateToPath:Boolean = true)
		{
			this.walkSpeed = walkSpeed;
			this.jumpSpeed = jumpSpeed;
			this.rotateToPath = rotateToPath;
		}

		public function moveLeft():void
		{
			_isWalking = true;

			physModel.setVelocityX(-walkSpeed);
		}

		public function moveRight():void
		{
			_isWalking = true;

			physModel.setVelocityX(walkSpeed);
		}

		public function jump():void
		{
			if (!_isJumping)
			{
				_isJumping = true;

				rotate(0);

				physModel.setVelocityY(-jumpSpeed);
			}
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			if (!physModel)
			{
				physModel = gameObject.getComponentByType(IPhysBodyObjectModel) as IPhysBodyObjectModel;

				physModel.addSignalListener(PhysObjectSignalEnum.COLLISION_BEGIN, collisionBegin);
				physModel.addSignalListener(PhysObjectSignalEnum.COLLISION_ONGOING, collisionOnGoing);
				physModel.addSignalListener(PhysObjectSignalEnum.COLLISION_END, collisionEnd);

				physModel.setAllowRotation(false);

				stop();
			}

			if (!_isJumping && _isInAir)
			{
				if (Math.abs(physModel.velocityY) > walkSpeed / 3)
				{
					_isJumping = true;

					rotate(0);
				}
			}
		}

		private function collisionEnd(e:ISignalEvent):void
		{
			handleCollisionEnd(e.data as InteractionCallback);
		}

		private function collisionOnGoing(e:ISignalEvent):void
		{
			handleCollisionOnGoing(e.data as InteractionCallback);
		}

		private function collisionBegin(e:ISignalEvent):void
		{
			handleCollisionBegin(e.data as InteractionCallback);
		}

		private function handleCollisionEnd(collision:InteractionCallback):void
		{
			_isInAir = true;
		}

		private function handleCollisionOnGoing(collision:InteractionCallback):void
		{
			handleCollisionBegin(collision);
		}

		private function handleCollisionBegin(collision:InteractionCallback):void
		{
			if (!isOnLegs(collision)) return;

			rotateBodyToNormal(collision);

			if (!_isWalking && !_isJumping)
			{
				physModel.putToSleep();

				body.velocity.setxy(0, 0);

				//trace("sleep");
				ForcedSleep.sleepBody(body);
			}

			_isInAir = false;
			_isJumping = false;
		}

		private function isOnLegs(collision:InteractionCallback):Boolean
		{
			if (collision.arbiters.length == 0) return false;

			for (var i:int = 0; i < collision.arbiters.length; i++)
			{
//				trace("normal:", body.worldVectorToLocal(collision.arbiters.at(i).collisionArbiter.normal).y);

				if (physModel.worldVectorToLocal(collision.arbiters.at(i).collisionArbiter.normal).y < 0.3)
				{
					return false;
				}
			}

			return true;
		}

		override public function dispose():void
		{
			physModel.removeAllSignalListeners();

			physModel = null;

			super.dispose();
		}

		public function stop():void
		{
			if (body && _isWalking)
			{
				_isWalking = false;

				physModel.setVelocityX(0);
			}
		}

		private function rotate(angle:Number):void
		{
			if (!rotateToPath) return;

			physModel.setRotation(angle);
		}

		private function rotateBodyToNormal(collision:InteractionCallback):void
		{
			if (!rotateToPath) return;

			if (collision.arbiters.length > 0)
			{
				var angle:Number = collision.arbiters.at(0).collisionArbiter.normal.angle - Math.PI / 2;
				//trace("angle: ", angle, rad2deg(angle), rad2deg(Math.PI / 3));
				if ((angle < Math.PI / 3.5 && angle > 0) || (angle > -Math.PI / 3.5 && angle < 0))
				{
					rotate(angle);
				}else
				{
					rotate(0);
				}
			}
		}
	}
}

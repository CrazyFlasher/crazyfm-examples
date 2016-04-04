/**
 * Created by Anton Nefjodov on 24.03.2016.
 */
package com.crazy.thugLife.goSystem.components.controller
{
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.devkit.goSystem.components.physyics.PhysBodyObject;
	import com.crazyfm.devkit.goSystem.components.physyics.PhysObjectSignalEnum;
	import com.crazyfm.extension.goSystem.GameComponent;

	import nape.callbacks.InteractionCallback;
	import nape.hacks.ForcedSleep;
	import nape.phys.Body;

	public class Controllable extends GameComponent implements IControllable
	{
		private var body:Body;
		private var physObj:PhysBodyObject;

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

			body.velocity.setxy(-walkSpeed, body.velocity.y);
		}

		public function moveRight():void
		{
			_isWalking = true;

			body.velocity.setxy(walkSpeed, body.velocity.y);
		}

		public function jump():void
		{
			if (!_isJumping)
			{
				body.velocity.setxy(body.velocity.x, -jumpSpeed);
			}
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			if (!physObj)
			{
				physObj = gameObject.getComponentByType(PhysBodyObject) as PhysBodyObject;

				physObj.addSignalListener(PhysObjectSignalEnum.COLLISION_BEGIN, collisionBegin);
				physObj.addSignalListener(PhysObjectSignalEnum.COLLISION_ONGOING, collisionOnGoing);
				physObj.addSignalListener(PhysObjectSignalEnum.COLLISION_END, collisionEnd);

				body = physObj.body;
				body.allowRotation = false;

				stop();
			}

			if (!_isJumping && _isInAir)
			{
				if (Math.abs(body.velocity.y) > walkSpeed / 3)
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

			if (!_isWalking)
			{
				body.velocity.setxy(0, 0);

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

				if (body.worldVectorToLocal(collision.arbiters.at(i).collisionArbiter.normal).y < 0.3)
				{
					return false;
				}
			}

			return true;
		}

		override public function dispose():void
		{
			physObj.removeAllSignalListeners();

			physObj = null;
			body = null;

			super.dispose();
		}

		public function stop():void
		{
			if (body && _isWalking)
			{
				_isWalking = false;

				body.velocity.setxy(0, body.velocity.y);
			}
		}

		private function rotate(angle:Number):void
		{
			if (!rotateToPath) return;

			body.rotation = angle;
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

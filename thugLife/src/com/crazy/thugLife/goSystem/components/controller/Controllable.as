/**
 * Created by Anton Nefjodov on 24.03.2016.
 */
package com.crazy.thugLife.goSystem.components.controller
{
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.devkit.goSystem.components.physyics.event.PhysObjectSignalData;
	import com.crazyfm.devkit.goSystem.components.physyics.event.PhysObjectSignalEnum;
	import com.crazyfm.devkit.goSystem.components.physyics.model.IPhysBodyObjectModel;
	import com.crazyfm.extension.goSystem.GameComponent;

	import nape.callbacks.InteractionCallback;
	import nape.dynamics.Arbiter;
	import nape.geom.Vec2;
	import nape.hacks.ForcedSleep;
	import nape.phys.Body;
	import nape.phys.GravMassMode;
	import nape.shape.Shape;

	public class Controllable extends GameComponent implements IControllable
	{
		private var body:Body;
		private var physObj:IPhysBodyObjectModel;

		private var _isJumping:Boolean;
		private var _isInAir:Boolean = true;
		private var _isWalking:Boolean;
		private var _isClimbing:Boolean;
		private var _canClimb:Boolean;

		private var _gravityMass:Number;

		private var walkSpeed:Number;
		private var jumpSpeed:Number;
		private var climbSpeed:Number;
		private var rotateToPath:Boolean;

		public function Controllable(walkSpeed:Number, jumpSpeed:Number, climbSpeed:Number, rotateToPath:Boolean = true)
		{
			this.walkSpeed = walkSpeed;
			this.jumpSpeed = jumpSpeed;
			this.climbSpeed = climbSpeed;
			this.rotateToPath = rotateToPath;
		}

		public function moveLeft():void
		{
			//if (!_isClimbing)
			//{
				_isWalking = true;

				body.velocity.x = -walkSpeed;
			//}
		}

		public function moveRight():void
		{
//			if (!_isClimbing)
//			{
				_isWalking = true;

				body.velocity.x = walkSpeed;
//			}
		}

		public function moveUp():void
		{
			if (_canClimb)
			{
				startClimbing();
			}
			if (_isClimbing)
			{
				body.velocity.y = -climbSpeed;
			}else
			{
				if (!_isJumping)
				{
					_isJumping = true;

					rotate(0);

					body.velocity.y = -jumpSpeed;
				}
			}
		}

		public function moveDown():void
		{
			if (_isClimbing)
			{
				body.velocity.y = jumpSpeed;
			}
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			if (!physObj)
			{
				physObj = gameObject.getComponentByType(IPhysBodyObjectModel) as IPhysBodyObjectModel;

				physObj.addSignalListener(PhysObjectSignalEnum.COLLISION_BEGIN, collisionBegin);
				physObj.addSignalListener(PhysObjectSignalEnum.COLLISION_END, collisionEnd);

				body = physObj.body;
				body.allowRotation = false;
				_gravityMass = body.gravMass;

				stop();
			}

			if (!_isClimbing)
			{
				if (!_isJumping && _isInAir)
				{
					if (Math.abs(body.velocity.y) > walkSpeed / 3)
					{
						_isJumping = true;

						rotate(0);
					}
				}
			}else
			{
				if (body.gravMass != 0)
				{
					body.gravMass = 0;
				}
			}
		}

		private function handleSensorEnd(collisionData:PhysObjectSignalData):void
		{
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
			body.gravMass = _gravityMass;
			body.gravMassMode = GravMassMode.DEFAULT;
		}

		private function handleSensorBegin(collisionData:PhysObjectSignalData):void
		{
			if (!isLadder(collisionData.otherShape)) return;

			_canClimb = true;
		}

		private function collisionEnd(e:ISignalEvent):void
		{
			var collisionData:PhysObjectSignalData =  e.data as PhysObjectSignalData;

			if (!collisionData.otherShape.sensorEnabled)
			{
				handleCollisionEnd(collisionData);
			}else
			{
				handleSensorEnd(collisionData);
			}
		}

		private function collisionBegin(e:ISignalEvent):void
		{
			var collisionData:PhysObjectSignalData =  e.data as PhysObjectSignalData;

			if (!collisionData.otherShape.sensorEnabled)
			{
				handleCollisionBegin(collisionData);
			}else
			{
				handleSensorBegin(collisionData);
			}
		}

		private function handleCollisionEnd(collisionData:PhysObjectSignalData):void
		{
			_isInAir = true;
		}

		private function handleCollisionBegin(collisionData:PhysObjectSignalData):void
		{
			if (!isOnLegs(collisionData.collision)) return;

			if (_isClimbing)
			{
				stopClimbing();
			}

			rotateBodyToNormal(collisionData.collision);

			if (!_isWalking && !_isJumping)
			{
				body.velocity.setxy(0, 0);

				if (!body.isSleeping)
				{
					//trace("sleep");
					ForcedSleep.sleepBody(body);
				}
			}

			_isInAir = false;
			_isJumping = false;
		}

		private function isOnLegs(collision:InteractionCallback):Boolean
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

		override public function dispose():void
		{
			physObj.removeAllSignalListeners();

			physObj = null;
			body = null;

			super.dispose();
		}

		public function stop():void
		{
			if (body)
			{
				//if (_isWalking)
				//{
					_isWalking = false;

					body.velocity.x = 0;
				//}
				if (_isClimbing)
				{
					body.velocity.y = 0;
				}
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

				if ((angle < Math.PI / 3.5 && angle > 0) || (angle > -Math.PI / 3.5 && angle < 0))
				{
					rotate(angle);
				}else
				{
					rotate(0);
				}
			}
		}

		private function isLadder(shape:Shape):Boolean
		{
			return shape.userData.id.search("ladder") != -1;
		}
	}
}
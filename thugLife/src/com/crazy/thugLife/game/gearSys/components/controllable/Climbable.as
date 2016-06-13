/**
 * Created by Anton Nefjodov on 28.04.2016.
 */
package com.crazy.thugLife.game.gearSys.components.controllable
{
	import com.crazy.thugLife.game.enums.GameInputActionEnum;
	import com.crazyfm.core.mvc.message.IMessage;
	import com.crazyfm.devkit.gearSys.components.controllable.AbstractPhysControllable;
	import com.crazyfm.devkit.gearSys.components.input.AbstractInputActionVo;
	import com.crazyfm.devkit.gearSys.components.physyics.event.InteractivePhysObjectSignalEnum;
	import com.crazyfm.devkit.gearSys.components.physyics.model.vo.LatestCollisionDataVo;
	import com.crazyfm.devkit.gearSys.components.physyics.utils.PhysObjectModelUtils;
	import com.crazyfm.devkit.physics.ICFShapeObject;

	import nape.shape.Shape;

	public class Climbable extends AbstractPhysControllable implements IClimbable
	{
		private const MAX_TO_ALLOW_CLIMB_X:Number = 10;

		private var climbSpeed:Number;

		private var _isClimbing:Boolean;
		private var _inLadderArea:Boolean;
		private var _totalSensors:int;

		private var currentLadderShape:Shape;
		private var _isLeavingLadder:Boolean;

		private var _disabledUntilStoppedVerticalOrOnLegs:Boolean;
		private var _isTryingToMoveVertical:Boolean;

		public function Climbable(climbSpeed:Number)
		{
			super();

			this.climbSpeed = climbSpeed;
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			if (_isClimbing)
			{
				if (Math.abs(intPhysObject.velocity.x) > MAX_TO_ALLOW_CLIMB_X)
				{
					stopClimbing();

					_disabledUntilStoppedVerticalOrOnLegs = true;
				}
			}
		}

		override protected function initialize():void
		{
			super.initialize();

			intPhysObject.addMessageListener(InteractivePhysObjectSignalEnum.TELEPORT_COMPLETE, onTeleportComplete)
		}

		private function onTeleportComplete(e:IMessage):void
		{
			_isLeavingLadder = false;
		}

		override public function dispose():void
		{
			intPhysObject.removeMessageListener(InteractivePhysObjectSignalEnum.TELEPORT_COMPLETE, onTeleportComplete);

			super.dispose();
		}

		override protected function handleInputAction(actionVo:AbstractInputActionVo):void
		{
			super.handleInputAction(actionVo);

			if (actionVo.action == GameInputActionEnum.MOVE_UP)
			{
				_isTryingToMoveVertical = true;

				moveUp();
			}else
			if (actionVo.action == GameInputActionEnum.MOVE_DOWN)
			{
				moveDown();

				_isTryingToMoveVertical = true;
			}else
			if (actionVo.action == GameInputActionEnum.STOP_VERTICAL)
			{
				_isTryingToMoveVertical = false;

				if (_disabledUntilStoppedVerticalOrOnLegs)
				{
					_disabledUntilStoppedVerticalOrOnLegs = false;
				}

				stopVertical();
			}
		}

		private function moveUp():void
		{
			if (canClimb)
			{
				startClimbing();
			}else
			if (_isClimbing)
			{
				intPhysObject.velocity.y = -climbSpeed;
			}
		}

		private function moveDown():void
		{
			if (canClimb)
			{
				startClimbing();
			}
			if (_isClimbing)
			{
				intPhysObject.velocity.y = climbSpeed;
			}
		}

		private function stopVertical():void
		{
			if (_isClimbing)
			{
				intPhysObject.velocity.y = 0;
			}
		}

		private function startClimbing():void
		{
			if (!_isClimbing)
			{
				_isClimbing = true;

				intPhysObject.velocity.setxy(0, 0);

				PhysObjectModelUtils.rotate(intPhysObject, 0);

				intPhysObject.setZeroGravity(true);

				intPhysObject.position.x = currentLadderShape.bounds.min.x;
			}
		}

		private function stopClimbing():void
		{
			if (_isClimbing)
			{
				_isClimbing = false;

				intPhysObject.setZeroGravity(false);
			}
		}

		private function get canClimb():Boolean
		{
			return !_disabledUntilStoppedVerticalOrOnLegs && _inLadderArea &&
					!_isClimbing && intPhysObject.velocity.x <= MAX_TO_ALLOW_CLIMB_X;
		}

		override protected function handleCollisionBegin(e:IMessage):void
		{
			super.handleCollisionBegin(e);

			if (!intPhysObject.isOnLegs) return;

			if (_isClimbing)
			{
				stopClimbing();
			}
		}

		override protected function handleSensorBegin(e:IMessage):void
		{
			super.handleSensorBegin(e);

			var shape:Shape = (e.data as LatestCollisionDataVo).otherShape;
			var shapeObject:ICFShapeObject = shape.userData.dataObject as ICFShapeObject;

			if (shapeObject.isLadder)
			{
				_inLadderArea = true;

				_totalSensors++;

				currentLadderShape = shape;

				if (!intPhysObject.isOnLegs && _isTryingToMoveVertical)
				{
					_disabledUntilStoppedVerticalOrOnLegs = true;
				}
			}else
			if (_isClimbing && shapeObject.isTeleportEntrance)
			{
				_isLeavingLadder = true;

				intPhysObject.teleportTo(shapeObject.relatedTeleportExit.shapes[0].bounds.min.x,
											 shapeObject.relatedTeleportExit.shapes[0].bounds.min.y, 0.3);
			}
		}

		override protected function handleSensorEnd(e:IMessage):void
		{
			super.handleSensorEnd(e);

			var shape:Shape = (e.data as LatestCollisionDataVo).otherShape;
			var shapeObject:ICFShapeObject = shape.userData.dataObject as ICFShapeObject;

			if (!shapeObject.isLadder) return;

			_totalSensors--;

			if (_totalSensors == 0)
			{
				_disabledUntilStoppedVerticalOrOnLegs = false;
				currentLadderShape = null;
				_inLadderArea = false;

				stopClimbing();
			}
		}

		public function get isClimbing():Boolean
		{
			return _isClimbing;
		}

		public function get isLeavingLadder():Boolean
		{
			return _isLeavingLadder;
		}
	}
}

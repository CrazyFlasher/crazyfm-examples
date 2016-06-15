/**
 * Created by Anton Nefjodov on 27.04.2016.
 */
package com.crazy.thugLife.game.gearSys.components.controllable
{
	import com.crazy.thugLife.game.enums.GameInputActionEnum;
	import com.crazyfm.core.mvc.message.IMessage;
	import com.crazyfm.devkit.gearSys.components.controllable.AbstractPhysControllable;
	import com.crazyfm.devkit.gearSys.components.input.AbstractInputActionVo;
	import com.crazyfm.devkit.gearSys.components.physyics.model.vo.LatestCollisionDataVo;
	import com.crazyfm.devkit.gearSys.components.physyics.utils.PhysObjectModelUtils;

	import nape.callbacks.InteractionCallback;

	public class Movable extends AbstractPhysControllable implements IMovable
	{
		private var walkSpeed:Number;
		private var runSpeed:Number;

		private var rotateToPath:Boolean;

		private var _isMoving:Boolean;
		private var _toggleRun:Boolean;

		public function Movable(walkSpeed:Number, rotateToPath:Boolean = true)
		{
			super();

			this.walkSpeed = walkSpeed;
			this.rotateToPath = rotateToPath;

			runSpeed = walkSpeed * 2;
		}

		override protected function handleInputAction(actionVo:AbstractInputActionVo):void
		{
			super.handleInputAction(actionVo);

			if (!canMoveHorizontally) return;

			if (actionVo.action == GameInputActionEnum.MOVE_LEFT)
			{
				moveLeft();
			}else
			if (actionVo.action == GameInputActionEnum.MOVE_RIGHT)
			{
				moveRight();
			}else
			if (actionVo.action == GameInputActionEnum.RUN_LEFT)
			{
				runLeft();
			}else
			if (actionVo.action == GameInputActionEnum.RUN_RIGHT)
			{
				runRight();
			}else
			if (actionVo.action == GameInputActionEnum.STOP_HORIZONTAL)
			{
				stopHorizontal();
			}else
			if (actionVo.action == GameInputActionEnum.TOGGLE_RUN)
			{
				toggleRun();
			}
		}

		private function get canMoveHorizontally():Boolean
		{
//			return !intPhysObject.zeroGravity;
			return true;
		}

		private function toggleRun():void
		{
			_toggleRun = !_toggleRun;
		}

		private function runRight():void
		{
			cancelZeroGravity();

			_isMoving = true;

			intPhysObject.velocity.x = !_toggleRun ? runSpeed : walkSpeed;
		}

		private function runLeft():void
		{
			cancelZeroGravity();

			_isMoving = true;

			intPhysObject.velocity.x = !_toggleRun ? -runSpeed : -walkSpeed;
		}

		private function moveLeft():void
		{
			cancelZeroGravity();

			_isMoving = true;

			intPhysObject.velocity.x = !_toggleRun ? -walkSpeed : -runSpeed;
		}

		private function moveRight():void
		{
			cancelZeroGravity();

			_isMoving = true;

			intPhysObject.velocity.x = !_toggleRun ? walkSpeed : runSpeed;
		}

		private function stopHorizontal():void
		{
			_isMoving = false;

			intPhysObject.velocity.x = 0;
		}

		override protected function handleCollisionBegin(e:IMessage):void
		{
			super.handleCollisionBegin(e);

			if (intPhysObject.isOnLegs && !_isMoving)
			{
				intPhysObject.velocity.setxy(0, 0);
			}

			rotateBodyToPath((e.data as LatestCollisionDataVo).collision);
		}

		override protected function handleCollisionOngoing(e:IMessage):void
		{
			super.handleCollisionOngoing(e);

			rotateBodyToPath((e.data as LatestCollisionDataVo).collision);
		}

		private function rotateBodyToPath(collision:InteractionCallback):void
		{
			if (!rotateToPath) return;
			if (!intPhysObject.isOnLegs) return;
			if (intPhysObject.zeroGravity) return;

			PhysObjectModelUtils.rotateBodyToInteractionCallbackNormal(intPhysObject, collision);
		}

		private function cancelZeroGravity():void
		{
//			if (intPhysObject.zeroGravity)
//			{
//				intPhysObject.setZeroGravity(false);
//			}
		}

		public function get isMoving():Boolean
		{
			return Math.abs(intPhysObject.velocity.x) >= walkSpeed;
		}

		public function get isRunning():Boolean
		{
			return Math.abs(intPhysObject.velocity.x) >= runSpeed;
		}

		public function get isLeftDirection():Boolean
		{
			return isMoving && intPhysObject.velocity.x < 0;
		}
	}
}
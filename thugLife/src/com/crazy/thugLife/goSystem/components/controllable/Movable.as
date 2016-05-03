/**
 * Created by Anton Nefjodov on 27.04.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable
{
	import com.crazy.thugLife.goSystem.components.input.GameInputActionEnum;
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.devkit.goSystem.components.controllable.AbstractPhysControllable;
	import com.crazyfm.devkit.goSystem.components.controllable.IControllable;
	import com.crazyfm.devkit.goSystem.components.input.AbstractInputActionVo;
	import com.crazyfm.devkit.goSystem.components.physyics.model.vo.LatestCollisionDataVo;
	import com.crazyfm.devkit.goSystem.components.physyics.utils.PhysObjectModelUtils;

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

		override public function inputAction(actionVo:AbstractInputActionVo):IControllable
		{
			super.inputAction(actionVo);

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

			return this;
		}

		private function toggleRun():void
		{
			_toggleRun = !_toggleRun;
		}

		private function runRight():void
		{
			_isMoving = true;

			intPhysObject.velocity.x = !_toggleRun ? runSpeed : walkSpeed;
		}

		private function runLeft():void
		{
			_isMoving = true;

			intPhysObject.velocity.x = !_toggleRun ? -runSpeed : -walkSpeed;
		}

		private function moveLeft():void
		{
			_isMoving = true;

			intPhysObject.velocity.x = !_toggleRun ? -walkSpeed : -runSpeed;
		}

		private function moveRight():void
		{
			_isMoving = true;

			intPhysObject.velocity.x = !_toggleRun ? walkSpeed : runSpeed;
		}

		private function stopHorizontal():void
		{
			_isMoving = false;

			intPhysObject.velocity.x = 0;
		}

		override protected function handleCollisionBegin(e:ISignalEvent):void
		{
			super.handleCollisionBegin(e);

			if (intPhysObject.isOnLegs && !_isMoving)
			{
				intPhysObject.velocity.setxy(0, 0);
			}

			rotateBodyToPath((e.data as LatestCollisionDataVo).collision);
		}

		override protected function handleCollisionOngoing(e:ISignalEvent):void
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

		public function get isMoving():Boolean
		{
			return Math.abs(intPhysObject.velocity.x) >= walkSpeed;
		}

		public function get isRunning():Boolean
		{
			return Math.abs(intPhysObject.velocity.x) >= runSpeed;
		}
	}
}

/**
 * Created by Anton Nefjodov on 27.04.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable.plugins
{
	import com.crazy.thugLife.goSystem.components.input.InputActionEnum;
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.devkit.goSystem.components.controllable.AbstractPhysControllable;
	import com.crazyfm.devkit.goSystem.components.controllable.IControllable;
	import com.crazyfm.devkit.goSystem.components.input.AbstractInputActionEnum;
	import com.crazyfm.devkit.goSystem.components.physyics.model.vo.LatestCollisionDataVo;
	import com.crazyfm.devkit.goSystem.components.physyics.utils.BodyUtils;

	import nape.callbacks.InteractionCallback;

	public class Moveable extends AbstractPhysControllable
	{
		private var walkSpeed:Number;
		private var runSpeed:Number;

		private var rotateToPath:Boolean;

		private var _isMoving:Boolean;

		public function Moveable(walkSpeed:Number, rotateToPath:Boolean = true)
		{
			super();

			this.walkSpeed = walkSpeed;
			this.rotateToPath = rotateToPath;

			runSpeed = walkSpeed * 1.5;
		}

		override public function inputAction(action:AbstractInputActionEnum):IControllable
		{
			super.inputAction(action);

			if (action == InputActionEnum.MOVE_LEFT)
			{
				moveLeft();
			}else
			if (action == InputActionEnum.MOVE_RIGHT)
			{
				moveRight();
			}else
			if (action == InputActionEnum.RUN_LEFT)
			{
				runLeft();
			}else
			if (action == InputActionEnum.RUN_RIGHT)
			{
				runRight();
			}else
			if (action == InputActionEnum.STOP_HORIZONTAL)
			{
				stopHorizontal();
			}

			return this;
		}

		private function runRight():void
		{
			_isMoving = true;

			body.velocity.x = runSpeed;
		}

		private function runLeft():void
		{
			_isMoving = true;

			body.velocity.x = -runSpeed;
		}

		private function moveLeft():void
		{
			_isMoving = true;

			body.velocity.x = -walkSpeed;
		}

		private function moveRight():void
		{
			_isMoving = true;

			body.velocity.x = walkSpeed;
		}

		private function stopHorizontal():void
		{
			_isMoving = false;

			body.velocity.x = 0;
		}

		override protected function handleCollisionBegin(e:ISignalEvent):void
		{
			super.handleCollisionBegin(e);

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

			BodyUtils.rotateBodyToInteractionCallbackNormal(body, collision);
		}
	}
}

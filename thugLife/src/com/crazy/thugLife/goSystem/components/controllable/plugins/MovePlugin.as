/**
 * Created by Anton Nefjodov on 27.04.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable.plugins
{
	import com.crazy.thugLife.goSystem.components.input.InputActionEnum;
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.devkit.goSystem.components.physyics.model.vo.LatestCollisionDataVo;
	import com.crazyfm.devkit.goSystem.components.physyics.utils.BodyUtils;

	public class MovePlugin extends AbstractControllablePlugin
	{
		private var walkSpeed:Number;
		private var rotateToPath:Boolean;

		private var _isMoving:Boolean;

		public function MovePlugin(walkSpeed:Number, rotateToPath:Boolean = true)
		{
			super();

			this.walkSpeed = walkSpeed;
			this.rotateToPath = rotateToPath;
		}

		override public function inputAction(action:InputActionEnum):IControllablePlugin
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
			if (action == InputActionEnum.STOP_HORIZONTAL)
			{
				stopHorizontal();
			}

			return this;
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

			intPhysObject.tryToSleep();
		}

		override protected function handleCollisionBegin(e:ISignalEvent):void
		{
			super.handleCollisionBegin(e);

			if (!intPhysObject.isOnLegs) return;

			BodyUtils.rotateBodyToInteractionCallbackNormal(body, (e.data as LatestCollisionDataVo).collision);

			if (!_isMoving)
			{
				body.velocity.setxy(0, 0);

				intPhysObject.tryToSleep();
			}
		}
	}
}

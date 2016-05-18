/**
 * Created by Anton Nefjodov on 28.04.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable
{
	import com.crazy.thugLife.enums.GameInputActionEnum;
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.devkit.goSystem.components.controllable.AbstractPhysControllable;
	import com.crazyfm.devkit.goSystem.components.input.AbstractInputActionVo;
	import com.crazyfm.devkit.goSystem.components.physyics.utils.PhysObjectModelUtils;

	public class Jumpable extends AbstractPhysControllable implements IJumpable
	{
		private var jumpSpeed:Number;

		private var _isJumping:Boolean;

		private var _disabledUntilStopped:Boolean;

		public function Jumpable(jumpSpeed:Number)
		{
			super();

			this.jumpSpeed = jumpSpeed;
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			if (!intPhysObject.isEnabledForInteraction && !_disabledUntilStopped)
			{
				_disabledUntilStopped = true;
			}

			if (!_isJumping && !intPhysObject.isOnLegs && !intPhysObject.zeroGravity)
			{
				if (Math.abs(intPhysObject.velocity.y) > jumpSpeed / 4)
				{
					setJumpState();
				}
			}
		}

		override protected function handleCollisionBegin(e:ISignalEvent):void
		{
			super.handleCollisionBegin(e);

			if (!intPhysObject.isOnLegs) return;

			_isJumping = false;
		}

		override protected function handleInputAction(actionVo:AbstractInputActionVo):void
		{
			super.handleInputAction(actionVo);

			if (_disabledUntilStopped)
			{
				if (actionVo.action == GameInputActionEnum.STOP_VERTICAL ||
					actionVo.action == GameInputActionEnum.STOP_HORIZONTAL)
				{
					_disabledUntilStopped = false;
				}
			}

			if (_disabledUntilStopped) return;

			if (actionVo.action == GameInputActionEnum.MOVE_UP)
			{
				moveUp();
			}
		}

		private function moveUp():void
		{
			if (!_isJumping && !intPhysObject.zeroGravity)
			{
				intPhysObject.velocity.y = -jumpSpeed;
			}
		}

		private function setJumpState():void
		{
			_isJumping = true;

			PhysObjectModelUtils.rotate(intPhysObject, 0);
		}

		public function get isJumping():Boolean
		{
			return _isJumping;
		}
	}
}

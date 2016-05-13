/**
 * Created by Anton Nefjodov on 28.04.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable
{
	import com.crazy.thugLife.goSystem.components.input.GameInputActionEnum;
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.devkit.goSystem.components.controllable.AbstractPhysControllable;
	import com.crazyfm.devkit.goSystem.components.controllable.IControllable;
	import com.crazyfm.devkit.goSystem.components.input.AbstractInputActionVo;
	import com.crazyfm.devkit.goSystem.components.physyics.utils.PhysObjectModelUtils;

	public class Jumpable extends AbstractPhysControllable implements IJumpable
	{
		private var jumpSpeed:Number;

		private var _isJumping:Boolean;

		public function Jumpable(jumpSpeed:Number)
		{
			super();

			this.jumpSpeed = jumpSpeed;
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

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

			trace(intPhysObject.velocity.y);
		}

		override public function inputAction(actionVo:AbstractInputActionVo):IControllable
		{
			super.inputAction(actionVo);

			if (actionVo.action == GameInputActionEnum.MOVE_UP)
			{
				moveUp();
			}

			return this;
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

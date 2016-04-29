/**
 * Created by Anton Nefjodov on 28.04.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable
{
	import com.crazy.thugLife.goSystem.components.input.InputActionEnum;
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.devkit.goSystem.components.controllable.AbstractPhysControllable;
	import com.crazyfm.devkit.goSystem.components.controllable.IControllable;
	import com.crazyfm.devkit.goSystem.components.input.AbstractInputActionEnum;
	import com.crazyfm.devkit.goSystem.components.physyics.utils.PhysObjectModelUtils;

	public class Jumpable extends AbstractPhysControllable
	{
		private var jumpSpeed:Number;

		private var _isJumping:Boolean;
//		private var _isTouchingLadder:Boolean;

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
				if (Math.abs(intPhysObject.velocity.y) > jumpSpeed / 6)
				{
					setJumpState();
				}
			}
		}

		/*override protected function handleSensorBegin(e:ISignalEvent):void
		{
			super.handleSensorBegin(e);

			if (!isLadder((e.data as LatestCollisionDataVo).otherShape)) return;

			_isTouchingLadder = true;
		}

		override protected function handleSensorEnd(e:ISignalEvent):void
		{
			super.handleSensorEnd(e);

			if (!isLadder((e.data as LatestCollisionDataVo).otherShape)) return;

			_isTouchingLadder = false;
		}*/

		override protected function handleCollisionBegin(e:ISignalEvent):void
		{
			super.handleCollisionBegin(e);

			if (!intPhysObject.isOnLegs) return;

			_isJumping = false;
		}

		override public function inputAction(action:AbstractInputActionEnum):IControllable
		{
			super.inputAction(action);

			if (action == InputActionEnum.MOVE_UP)
			{
				moveUp();
			}

			return this;
		}

		private function moveUp():void
		{
			if (!_isJumping && /*!_isTouchingLadder && */!intPhysObject.zeroGravity)
			{
				intPhysObject.velocity.y = -jumpSpeed;
			}
		}

		private function setJumpState():void
		{
			trace("setJumpState")
			_isJumping = true;

			PhysObjectModelUtils.rotate(intPhysObject, 0);
		}
	}
}

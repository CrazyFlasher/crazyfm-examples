/**
 * Created by Anton Nefjodov on 28.04.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable.plugins
{
	import com.crazy.thugLife.goSystem.components.input.InputActionEnum;
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.devkit.goSystem.components.physyics.model.vo.LatestCollisionDataVo;
	import com.crazyfm.devkit.goSystem.components.physyics.utils.BodyUtils;

	public class JumpPlugin extends AbstractControllablePlugin
	{
		private var jumpSpeed:Number;

		private var _isJumping:Boolean;
//		private var _isTouchingLadder:Boolean;

		public function JumpPlugin(jumpSpeed:Number)
		{
			super();

			this.jumpSpeed = jumpSpeed;
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			if (!_isJumping && !intPhysObject.isOnLegs && !intPhysObject.zeroGravity)
			{
				if (Math.abs(body.velocity.y) > jumpSpeed / 6)
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

		override public function inputAction(action:InputActionEnum):IControllablePlugin
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
				body.velocity.y = -jumpSpeed;
			}
		}

		private function setJumpState():void
		{
			trace("setJumpState")
			_isJumping = true;

			BodyUtils.rotate(body, 0);
		}
	}
}

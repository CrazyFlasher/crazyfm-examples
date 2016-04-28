/**
 * Created by Anton Nefjodov on 28.04.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable.plugins
{
	import com.crazy.thugLife.goSystem.components.input.InputActionEnum;
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.devkit.goSystem.components.physyics.utils.BodyUtils;

	public class JumpPlugin extends AbstractControllablePlugin
	{
		private var jumpSpeed:Number;

		private var _isJumping:Boolean;

		public function JumpPlugin(jumpSpeed:Number)
		{
			super();

			this.jumpSpeed = jumpSpeed;
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			if (!_isJumping && !intPhysObject.isOnLegs)
			{
				if (Math.abs(body.velocity.y) > jumpSpeed / 6)
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
			if (!_isJumping)
			{
				setJumpState();

				body.velocity.y = -jumpSpeed;
			}
		}

		private function setJumpState():void
		{
			_isJumping = true;

			BodyUtils.rotate(body, 0);
		}
	}
}

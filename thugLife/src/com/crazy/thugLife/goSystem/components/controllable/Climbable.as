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
	import com.crazyfm.devkit.goSystem.components.physyics.model.vo.LatestCollisionDataVo;
	import com.crazyfm.devkit.goSystem.components.physyics.utils.PhysObjectModelUtils;

	public class Climbable extends AbstractPhysControllable implements IClimbable
	{
		private var climbSpeed:Number;

		private var _isClimbing:Boolean;
		private var _canClimb:Boolean;

		public function Climbable(climbSpeed:Number)
		{
			super();

			this.climbSpeed = climbSpeed;
		}

		override public function inputAction(actionVo:AbstractInputActionVo):IControllable
		{
			super.inputAction(actionVo);

			if (actionVo.action == GameInputActionEnum.MOVE_UP)
			{
				moveUp();
			}else
			if (actionVo.action == GameInputActionEnum.MOVE_DOWN)
			{
				moveDown();
			}else
			if (actionVo.action == GameInputActionEnum.STOP_VERTICAL)
			{
				stopVertical();
			}

			return this;
		}

		private function moveUp():void
		{
			if (_canClimb)
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
			if (_canClimb)
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
				_canClimb = false;
				_isClimbing = true;

				intPhysObject.velocity.setxy(0, 0);

				PhysObjectModelUtils.rotate(intPhysObject, 0);

				intPhysObject.setZeroGravity(true);
			}
		}

		private function stopClimbing():void
		{
			if (_isClimbing)
			{
				_canClimb = false;
				_isClimbing = false;

				intPhysObject.setZeroGravity(false);
			}
		}

		override protected function handleCollisionBegin(e:ISignalEvent):void
		{
			super.handleCollisionBegin(e);

			if (!intPhysObject.isOnLegs) return;

			if (_isClimbing)
			{
				stopClimbing();
			}
		}

		override protected function handleSensorBegin(e:ISignalEvent):void
		{
			super.handleSensorBegin(e);

			if (!isLadder((e.data as LatestCollisionDataVo).otherShape)) return;

			_canClimb = true;
		}

		override protected function handleSensorEnd(e:ISignalEvent):void
		{
			super.handleSensorEnd(e);

			if (!isLadder((e.data as LatestCollisionDataVo).otherShape)) return;

			_canClimb = false;

			stopClimbing();
		}

		public function get isClimbing():Boolean
		{
			return _isClimbing;
		}
	}
}

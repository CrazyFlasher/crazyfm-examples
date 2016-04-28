/**
 * Created by Anton Nefjodov on 28.04.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable.plugins
{
	import com.crazy.thugLife.goSystem.components.input.InputActionEnum;
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.devkit.goSystem.components.physyics.model.vo.LatestCollisionDataVo;
	import com.crazyfm.devkit.goSystem.components.physyics.utils.BodyUtils;

	import nape.phys.GravMassMode;
	import nape.shape.Shape;

	public class ClimbPlugin extends AbstractControllablePlugin
	{
		private var climbSpeed:Number;

		private var _isClimbing:Boolean;
		private var _canClimb:Boolean;

		public function ClimbPlugin(climbSpeed:Number)
		{
			super();

			this.climbSpeed = climbSpeed;
		}

		override public function inputAction(action:InputActionEnum):IControllablePlugin
		{
			super.inputAction(action);

			if (action == InputActionEnum.MOVE_UP)
			{
				moveUp();
			}else
			if (action == InputActionEnum.MOVE_DOWN)
			{
				moveDown();
			}else
			if (action == InputActionEnum.STOP_VERTICAL)
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
				body.velocity.y = -climbSpeed;
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
				body.velocity.y = climbSpeed;
			}
		}

		private function stopVertical():void
		{
			if (_isClimbing)
			{
				body.velocity.y = 0;
			}
		}

		private function startClimbing():void
		{
			if (!_isClimbing)
			{
				trace("startClimbing")

				_canClimb = false;
				_isClimbing = true;

				body.velocity.setxy(0, 0);

				BodyUtils.rotate(body, 0);

				intPhysObject.setZeroGravity(true);
			}
		}

		private function stopClimbing():void
		{
			if (_isClimbing)
			{
				trace("stopClimbing")

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

	}
}

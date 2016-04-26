/**
 * Created by Anton Nefjodov on 27.04.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable2.plugins
{
	import com.crazy.thugLife.goSystem.components.controllable2.IControllablePlugin;
	import com.crazy.thugLife.goSystem.components.input.InputActionEnum;

	public class MovePlugin extends AbstractPlugin implements IControllablePlugin
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

			tryToSleep();
		}
	}
}

/**
 * Created by Anton Nefjodov on 24.03.2016.
 */
package com.crazy.thugLife.goSystem.components.controller
{
	import com.crazyfm.extension.goSystem.GameComponent;

	import flash.ui.Keyboard;

	import starling.display.Stage;
	import starling.events.KeyboardEvent;

	public class KeyboardInput extends GameComponent implements IInput
	{
		private var stage:Stage;
		private var controllableObject:IControllable;

		private var _moveLeft:Boolean;
		private var _moveRight:Boolean;

		public function KeyboardInput(stage:Stage)
		{
			super();

			this.stage = stage;

			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		}

		private function keyUp(event:KeyboardEvent, keyCode:uint):void
		{
			if (keyCode == Keyboard.RIGHT)
			{
				outputRight();
			}
			if (keyCode == Keyboard.LEFT)
			{
				outputLeft();
			}
		}

		private function keyDown(event:KeyboardEvent, keyCode:uint):void
		{
			if (keyCode == Keyboard.RIGHT)
			{
				inputRight();
			}else
			if (keyCode == Keyboard.LEFT)
			{
				inputLeft();
			}
			else
			if (keyCode == Keyboard.UP)
			{
				inputJump();
			}
		}

		override public function dispose():void
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, keyUp);

			stage = null;
			controllableObject = null;

			super.dispose();
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			if (!controllableObject)
			{
				controllableObject = gameObject.getComponentByType(IControllable) as IControllable;
			}

			if (_moveLeft)
			{
				controllableObject.moveLeft();
			}else
			if (_moveRight)
			{
				controllableObject.moveRight();
			}else
			{
				controllableObject.stop();
			}
		}

		public function inputRight():IInput
		{
			_moveRight = true;

			return this;
		}

		public function inputLeft():IInput
		{
			_moveLeft = true;

			return this;
		}

		public function inputJump():IInput
		{
			controllableObject.jump();

			return this;
		}

		public function outputRight():IInput
		{
			_moveRight = false;

			return this;
		}

		public function outputLeft():IInput
		{
			_moveLeft = false;

			return this;
		}

		public function outputJump():IInput
		{
			//do nothing

			return this;
		}
	}
}

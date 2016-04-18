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

		private var _inputLeft:Boolean;
		private var _inputRight:Boolean;
		private var _inputUp:Boolean;
		private var _inputDown:Boolean;

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
			if (keyCode == Keyboard.UP)
			{
				outputUp();
			}
			if (keyCode == Keyboard.DOWN)
			{
				outputDown();
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

			if (keyCode == Keyboard.UP)
			{
				inputUp();
			}else
			if (keyCode == Keyboard.DOWN)
			{
				inputDown();
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

			var moving:Boolean;

			if (_inputLeft)
			{
				moving = true;

				controllableObject.moveLeft();
			}else
			if (_inputRight)
			{
				moving = true;

				controllableObject.moveRight();
			}

			if (_inputUp)
			{
				moving = true;

				controllableObject.moveUp();
			}else
			if (_inputDown)
			{
				moving = true;

				controllableObject.moveDown();
			}

			if (!moving)
			{
				controllableObject.stop();
			}
		}

		public function inputRight():IInput
		{
			_inputRight = true;

			return this;
		}

		public function inputLeft():IInput
		{
			_inputLeft = true;

			return this;
		}

		public function inputUp():IInput
		{
			_inputUp = true;

			return this;
		}

		public function inputDown():IInput
		{
			_inputDown = true;

			return this;
		}

		public function outputRight():IInput
		{
			_inputRight = false;

			return this;
		}

		public function outputLeft():IInput
		{
			_inputLeft = false;

			return this;
		}

		public function outputUp():IInput
		{
			_inputUp = false;

			return this;
		}

		public function outputDown():IInput
		{
			_inputDown = false;

			return this;
		}
	}
}

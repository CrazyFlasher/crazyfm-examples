/**
 * Created by Anton Nefjodov on 24.03.2016.
 */
package com.crazy.thugLife.goSystem.components.input
{
	import com.crazy.thugLife.goSystem.components.controllable.IControllable;
	import com.crazy.thugLife.goSystem.components.controllable.MovementType;
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

		private var shiftIsDown:Boolean;
		private var toggleShift:Boolean;

		public function KeyboardInput(stage:Stage)
		{
			super();

			this.stage = stage;

			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		}

		private function keyUp(event:KeyboardEvent, keyCode:uint):void
		{
			if (keyCode == Keyboard.CAPS_LOCK)
			{
				toggleShift = !toggleShift;
			}
			if (keyCode == Keyboard.SHIFT)
			{
				shiftIsDown = false;
			}
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
			if (keyCode == Keyboard.SHIFT)
			{
				shiftIsDown = true;
			}

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

			var movingHorizontal:Boolean;
			var movingVertical:Boolean;

			if (_inputLeft)
			{
				movingHorizontal = true;

				controllableObject.moveLeft((shiftIsDown && !toggleShift || !shiftIsDown && toggleShift) ? MovementType.RUN : MovementType.WALK);
			}else
			if (_inputRight)
			{
				movingHorizontal = true;

				controllableObject.moveRight((shiftIsDown && !toggleShift || !shiftIsDown && toggleShift) ? MovementType.RUN : MovementType.WALK);
			}

			if (_inputUp)
			{
				movingVertical = true;

				controllableObject.moveUp();
			}else
			if (_inputDown)
			{
				movingVertical = true;

				controllableObject.moveDown();
			}

			if (!movingHorizontal)
			{
				controllableObject.stopHorizontal();
			}
			if (!movingVertical)
			{
				controllableObject.stopVertical();
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
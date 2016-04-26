/**
 * Created by Anton Nefjodov on 24.03.2016.
 */
package com.crazy.thugLife.goSystem.components.input
{
	import com.crazy.thugLife.goSystem.components.controllable.MovementType;
	import com.crazy.thugLife.goSystem.components.controllable2.IControllablePluginManager;
	import com.crazyfm.extension.goSystem.GameObject;

	import flash.ui.Keyboard;

	import starling.display.Stage;
	import starling.events.KeyboardEvent;

	public class KeyboardInput2 extends GameObject implements IInput2
	{
		private var stage:Stage;
		private var controllableObject:IControllablePluginManager;

		private var _inputLeft:Boolean;
		private var _inputRight:Boolean;
		private var _inputUp:Boolean;
		private var _inputDown:Boolean;

		private var shiftIsDown:Boolean;
		private var toggleShift:Boolean;

		public function KeyboardInput2(stage:Stage, controllableObject:IControllablePluginManager)
		{
			super();

			this.stage = stage;
			this.controllableObject = controllableObject;

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

			var movingHorizontal:Boolean;
			var movingVertical:Boolean;

			if (_inputLeft)
			{
				movingHorizontal = true;

				controllableObject.inputAction((shiftIsDown && !toggleShift || !shiftIsDown && toggleShift) ? InputActionEnum.MOVE_LEFT : InputActionEnum.MOVE_LEFT);
			}else
			if (_inputRight)
			{
				movingHorizontal = true;

				controllableObject.inputAction((shiftIsDown && !toggleShift || !shiftIsDown && toggleShift) ? InputActionEnum.MOVE_RIGHT : InputActionEnum.MOVE_RIGHT);
			}

			if (_inputUp)
			{
				movingVertical = true;

//				controllableObject.moveUp();
			}else
			if (_inputDown)
			{
				movingVertical = true;

//				controllableObject.moveDown();
			}

			if (!movingHorizontal)
			{
				controllableObject.inputAction(InputActionEnum.STOP_HORIZONTAL);
			}
			if (!movingVertical)
			{
//				controllableObject.stopVertical();
			}
		}

		public function inputRight():IInput2
		{
			_inputRight = true;

			return this;
		}

		public function inputLeft():IInput2
		{
			_inputLeft = true;

			return this;
		}

		public function inputUp():IInput2
		{
			_inputUp = true;

			return this;
		}

		public function inputDown():IInput2
		{
			_inputDown = true;

			return this;
		}

		public function outputRight():IInput2
		{
			_inputRight = false;

			return this;
		}

		public function outputLeft():IInput2
		{
			_inputLeft = false;

			return this;
		}

		public function outputUp():IInput2
		{
			_inputUp = false;

			return this;
		}

		public function outputDown():IInput2
		{
			_inputDown = false;

			return this;
		}
	}
}

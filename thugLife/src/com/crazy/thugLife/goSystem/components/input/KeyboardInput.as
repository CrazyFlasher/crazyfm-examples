/**
 * Created by Anton Nefjodov on 24.03.2016.
 */
package com.crazy.thugLife.goSystem.components.input
{
	import com.crazyfm.devkit.goSystem.components.controllable.IControllable;
	import com.crazyfm.devkit.goSystem.components.input.AbstractInputActionEnum;
	import com.crazyfm.extension.goSystem.GameComponent;

	import flash.ui.Keyboard;

	import starling.display.Stage;
	import starling.events.KeyboardEvent;

	public class KeyboardInput extends GameComponent implements IInput
	{
		private var stage:Stage;
		private var controllableComponents:Array/*IControllable*/

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
				_inputRight = false;
			}
			if (keyCode == Keyboard.LEFT)
			{
				_inputLeft = false;
			}
			if (keyCode == Keyboard.UP)
			{
				_inputUp = false;
			}
			if (keyCode == Keyboard.DOWN)
			{
				_inputDown = false;
			}
		}

		private function keyDown(event:KeyboardEvent, keyCode:uint):void
		{
			var inputAction:InputActionEnum;

			if (keyCode == Keyboard.SHIFT)
			{
				shiftIsDown = true;
			}

			if (keyCode == Keyboard.RIGHT)
			{
				_inputRight = true;
			}else
			if (keyCode == Keyboard.LEFT)
			{
				_inputLeft = true;
			}

			if (keyCode == Keyboard.UP)
			{
				_inputUp = true;
			}else
			if (keyCode == Keyboard.DOWN)
			{
				_inputDown = true;
			}
		}

		override public function dispose():void
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, keyUp);

			stage = null;
			controllableComponents = null;

			super.dispose();
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			if (!controllableComponents)
			{
				controllableComponents = gameObject.getComponentsByType(IControllable);
			}

			var movingHorizontal:Boolean;
			var movingVertical:Boolean;

			if (_inputLeft)
			{
				movingHorizontal = true;

				sendActionToControllables((shiftIsDown && !toggleShift || !shiftIsDown && toggleShift) ? InputActionEnum.RUN_LEFT : InputActionEnum.MOVE_LEFT);
			}else
			if (_inputRight)
			{
				movingHorizontal = true;

				sendActionToControllables((shiftIsDown && !toggleShift || !shiftIsDown && toggleShift) ? InputActionEnum.RUN_RIGHT : InputActionEnum.MOVE_RIGHT);
			}

			if (_inputUp)
			{
				movingVertical = true;

				sendActionToControllables(InputActionEnum.MOVE_UP);
			}else
			if (_inputDown)
			{
				movingVertical = true;

				sendActionToControllables(InputActionEnum.MOVE_DOWN);
			}

			if (!movingHorizontal)
			{
				sendActionToControllables(InputActionEnum.STOP_HORIZONTAL);
			}
			if (!movingVertical)
			{
				sendActionToControllables(InputActionEnum.STOP_VERTICAL);
			}
		}

		public function sendActionToControllables(action:AbstractInputActionEnum):IInput
		{
			for each (var controllable:IControllable in arguments)
			{
				controllable.inputAction(action);
			}

			return this;
		}
	}
}

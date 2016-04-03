/**
 * Created by Anton Nefjodov on 24.03.2016.
 */
package com.crazy.thugLife.goSystem.components.controller
{
	import com.crazyfm.extension.goSystem.GameComponent;

	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	public class KeyboardController extends GameComponent
	{
		private var stage:Stage;
		private var controllableObject:IControllable;

		private var _moveLeft:Boolean;
		private var _moveRight:Boolean;

		public function KeyboardController(stage:Stage)
		{
			super();

			this.stage = stage;

			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		}

		private function keyUp(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.RIGHT)
			{
				_moveRight = false;
			}
			if (event.keyCode == Keyboard.LEFT)
			{
				_moveLeft = false;
			}
		}

		private function keyDown(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.RIGHT)
			{
				_moveRight = true;
			}else
			if (event.keyCode == Keyboard.LEFT)
			{
				_moveLeft = true;
			}
			else
			if (event.keyCode == Keyboard.UP)
			{
				controllableObject.jump();
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
	}
}

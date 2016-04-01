/**
 * Created by Anton Nefjodov on 24.03.2016.
 */
package com.crazy.thugLife.controller
{
	import com.crazyfm.extension.goSystem.GameComponent;

	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	public class KeyBoardController extends GameComponent
	{
		private var stage:Stage;
		private var controllableObject:IControllableComponent;

		private var _moveLeft:Boolean;
		private var _moveRight:Boolean;

		public function KeyBoardController()
		{
			super();
		}

		public function setNativeStage(value:Stage):KeyBoardController
		{
			stage = value;

			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);

			return this;
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
			}
			if (event.keyCode == Keyboard.LEFT)
			{
				_moveLeft = true;
			}
			if (event.keyCode == Keyboard.UP)
			{
				controllableObject.jump();
			}
			if (event.keyCode == Keyboard.DOWN)
			{
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
				controllableObject = gameObject.getComponentByType(IControllableComponent) as IControllableComponent;
				controllableObject.stop();
			}

			if (_moveLeft)
			{
				controllableObject.moveLeft();
			}
			if (_moveRight)
			{
				controllableObject.moveRight();
			}
			if (!_moveLeft && !_moveRight)
			{
				controllableObject.stop();
			}
		}
	}
}

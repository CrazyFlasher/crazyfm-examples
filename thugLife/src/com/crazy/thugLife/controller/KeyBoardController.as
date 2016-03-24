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

		}

		private function keyDown(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.RIGHT)
			{
				controllableObject.moveRight();
			}
			if (event.keyCode == Keyboard.LEFT)
			{
				controllableObject.moveLeft();
			}
			if (event.keyCode == Keyboard.UP)
			{
				controllableObject.moveUp();
			}
			if (event.keyCode == Keyboard.DOWN)
			{
				controllableObject.moveDown();
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
			if (!controllableObject)
			{
				controllableObject = gameObject.getComponentByType(IControllableComponent) as IControllableComponent;
			}

			super.interact(timePassed);
		}
	}
}

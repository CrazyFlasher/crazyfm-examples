/**
 * Created by Anton Nefjodov on 28.04.2016.
 */
package com.crazy.thugLife.goSystem.components.input
{
	import com.crazyfm.devkit.goSystem.components.input.AbstractInputActionEnum;
	import com.crazyfm.extension.goSystem.GameComponent;

	import flash.utils.Dictionary;

	import starling.display.Stage;
	import starling.events.KeyboardEvent;

	public class KInput extends GameComponent implements IInput
	{
		public function KInput(stage:Stage, keyToActionMapping:Dictionary)
		{
			super();

			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		}

		private function keyUp(event:KeyboardEvent, keyCode:uint):void
		{

		}

		private function keyDown(event:KeyboardEvent, keyCode:uint):void
		{

		}

		public function sendActionToControllables(action:AbstractInputActionEnum):IInput
		{
			return this;
		}
	}
}

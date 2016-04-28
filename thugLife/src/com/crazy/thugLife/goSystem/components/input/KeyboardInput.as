/**
 * Created by Anton Nefjodov on 28.04.2016.
 */
package com.crazy.thugLife.goSystem.components.input
{
	import flash.utils.Dictionary;

	import starling.display.Stage;
	import starling.events.KeyboardEvent;

	public class KeyboardInput extends AbstractInput
	{
		private var keyDownList:Vector.<uint> = new <uint>[];
		private var stage:Stage;
		private var keyToActionMapping:Dictionary/*uint, AbstractInputActionEnum*/;

		public function KeyboardInput(stage:Stage, keyToActionMapping:Dictionary/*uint, AbstractInputActionEnum*/)
		{
			super();

			this.stage = stage;
			this.keyToActionMapping = keyToActionMapping;

			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		}

		private function keyUp(event:KeyboardEvent, keyCode:uint):void
		{
			var keyIndex:int = keyDownList.indexOf(keyCode);

			if (keyIndex != -1)
			{
				keyDownList.removeAt(keyIndex);
			}
		}

		private function keyDown(event:KeyboardEvent, keyCode:uint):void
		{
			if (keyDownList.indexOf(keyCode) == -1)
			{
				keyDownList.push(keyCode);
			}
		}

		protected final function isDown(keyCode:uint):Boolean
		{
			return keyDownList.indexOf(keyCode) != -1;
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			var keyCode:uint;
			for (var i:int = 0; i < keyDownList.length; i++)
			{
				keyCode = keyDownList[i];

				if (keyToActionMapping[i])
				{
					sendActionToControllables(keyToActionMapping[i]);
				}
			}
		}

		override public function dispose():void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);

			stage = null;
			keyDownList = null;

			super.dispose();
		}
	}
}

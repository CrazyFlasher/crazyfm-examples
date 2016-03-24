/**
 * Created by Anton Nefjodov on 24.03.2016.
 */
package com.crazy.thugLife.view
{
	import flash.display.DisplayObjectContainer;

	import nape.space.Space;
	import nape.util.BitmapDebug;

	public class PhysDebugViewComponent extends FlashViewComponent
	{
		private var debug:BitmapDebug;
		private var space:Space;

		public function PhysDebugViewComponent()
		{
			super();
		}

		public function setSpace(space:Space):PhysDebugViewComponent
		{
			this.space = space;

			return this;
		}

		override public function setViewContainer(value:DisplayObjectContainer):FlashViewComponent
		{
			super.setViewContainer(value);

			removeDebugDraw();

			debug = new BitmapDebug(value.stage.stageWidth, value.stage.stageHeight, 0x000000, false);
			debug.drawCollisionArbiters = true;
			debug.drawConstraints = true;
			viewContainer.addChild(debug.display);

			return this;
		}

		override public function dispose():void
		{
			removeDebugDraw();

			space = null;

			super.dispose();
		}

		private function removeDebugDraw():void
		{
			if (viewContainer)
			{
				if (debug)
				{
					viewContainer.removeChild(debug.display);
					debug = null;
				}
			}
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			if (debug)
			{
				debug.clear();
				debug.draw(space);
				debug.flush();
			}
		}
	}
}

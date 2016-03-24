/**
 * Created by Anton Nefjodov on 21.03.2016.
 */
package com.crazy.thugLife.view
{
	import com.crazyfm.extension.goSystem.GameComponent;

	import flash.display.DisplayObjectContainer;

	public class FlashViewComponent extends GameComponent
	{
		protected var viewContainer:DisplayObjectContainer;

		public function FlashViewComponent()
		{
		}

		public function setViewContainer(value:DisplayObjectContainer):FlashViewComponent
		{
			viewContainer = value;

			return this;
		}

		override public function dispose():void
		{
			viewContainer = null;

			super.dispose();
		}
	}
}

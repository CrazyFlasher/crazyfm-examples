/**
 * Created by Anton Nefjodov on 4.04.2016.
 */
package com.crazy.thugLife.goSystem.components.camera
{
	import com.crazyfm.extension.goSystem.GameComponent;

	import flash.geom.Rectangle;

	import starling.display.DisplayObject;

	public class Camera extends GameComponent implements ICamera
	{
		private var focusObject:DisplayObject;

		private var viewPort:Rectangle;

		private var viewContainer:DisplayObject;

		public function Camera(viewContainer:DisplayObject)
		{
			super();

			this.viewContainer = viewContainer;
		}

		public function setFocusObject(value:DisplayObject):ICamera
		{
			focusObject = value;

			return this;
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			if (!viewPort) return;
			if (!focusObject) return;
			if (viewPort.width >= viewContainer.width) return;

			viewContainer.x = -focusObject.x + viewPort.width / 2;
		}

		public function setViewport(value:Rectangle):ICamera
		{
			viewPort = value;

			return this;
		}
	}
}

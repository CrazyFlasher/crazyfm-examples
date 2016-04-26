/**
 * Created by Anton Nefjodov on 26.04.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable2.plugins
{
	import com.crazy.thugLife.goSystem.components.controllable2.ControllablePluginManager;
	import com.crazy.thugLife.goSystem.components.controllable2.IControllablePlugin;
	import com.crazy.thugLife.goSystem.components.controllable2.ns_controllable;
	import com.crazy.thugLife.goSystem.components.input.InputActionEnum;
	import com.crazyfm.extension.goSystem.GameComponent;

	import nape.callbacks.InteractionCallback;
	import nape.phys.Body;

	use namespace ns_controllable;

	public class AbstractPlugin extends GameComponent implements IControllablePlugin
	{
		protected var manager:ControllablePluginManager;

		public function AbstractPlugin()
		{
			super();
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			if (!manager)
			{
				manager = parent as ControllablePluginManager;
			}
		}

		protected final function rotate(angle:Number):void
		{
			manager.body.rotation = angle;
		}

		protected final function rotateBodyToNormal(collision:InteractionCallback):void
		{
			if (collision.arbiters.length > 0)
			{
				var angle:Number = collision.arbiters.at(0).collisionArbiter.normal.angle - Math.PI / 2;

				if ((angle < Math.PI / 3.5 && angle > 0) || (angle > -Math.PI / 3.5 && angle < 0))
				{
					rotate(angle);
				}else
				{
					rotate(0);
				}
			}
		}

		public function inputAction(action:InputActionEnum):IControllablePlugin
		{
			return this;
		}

		protected function get body():Body
		{
			return manager.body;
		}

		protected function tryToSleep():void
		{
			manager.tryToSleep();
		}

		protected function get isOnLegs():Boolean
		{
			return manager.isOnLegs;
		}
	}
}

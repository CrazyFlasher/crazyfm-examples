/**
 * Created by Anton Nefjodov on 26.04.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable.plugins
{
	import com.crazy.thugLife.goSystem.components.controllable2.IControllablePlugin;
	import com.crazy.thugLife.goSystem.components.controllable2.ns_controllable;
	import com.crazy.thugLife.goSystem.components.input.InputActionEnum;
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.devkit.goSystem.components.physyics.event.PhysObjectSignalEnum;
	import com.crazyfm.devkit.goSystem.components.physyics.model.IInteractivePhysObjectModel;
	import com.crazyfm.extension.goSystem.GameComponent;

	import nape.phys.Body;

	use namespace ns_controllable;

	public class AbstractControllablePlugin extends GameComponent implements IControllablePlugin
	{
		protected var intPhysObject:IInteractivePhysObjectModel;
		protected var body:Body;

		public function AbstractControllablePlugin()
		{
			super();
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			if (!intPhysObject)
			{
				intPhysObject = gameObject.getComponentByType(IInteractivePhysObjectModel) as IInteractivePhysObjectModel;

				intPhysObject.addSignalListener(PhysObjectSignalEnum.COLLISION_BEGIN, handleCollisionBegin);
				intPhysObject.addSignalListener(PhysObjectSignalEnum.COLLISION_END, handleCollisionEnd);
				intPhysObject.addSignalListener(PhysObjectSignalEnum.SENSOR_BEGIN, handleSensorBegin);
				intPhysObject.addSignalListener(PhysObjectSignalEnum.SENSOR_END, handleSensorEnd);

				body = intPhysObject.body;
			}
		}

		protected function handleCollisionBegin(e:ISignalEvent):void
		{

		}

		protected function handleCollisionEnd(e:ISignalEvent):void
		{

		}

		protected function handleSensorBegin(e:ISignalEvent):void
		{

		}

		protected function handleSensorEnd(e:ISignalEvent):void
		{

		}

		public function inputAction(action:InputActionEnum):IControllablePlugin
		{
			return this;
		}

		override public function dispose():void
		{
			intPhysObject.removeSignalListener(PhysObjectSignalEnum.COLLISION_BEGIN, handleCollisionBegin);
			intPhysObject.removeSignalListener(PhysObjectSignalEnum.COLLISION_END, handleCollisionEnd);
			intPhysObject.removeSignalListener(PhysObjectSignalEnum.SENSOR_BEGIN, handleSensorBegin);
			intPhysObject.removeSignalListener(PhysObjectSignalEnum.SENSOR_END, handleSensorEnd);

			intPhysObject = null;
			body = null;

			super.dispose();
		}
	}
}

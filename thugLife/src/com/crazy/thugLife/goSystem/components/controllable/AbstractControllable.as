/**
 * Created by Anton Nefjodov on 24.04.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable
{
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.devkit.goSystem.components.physyics.event.PhysObjectSignalData;
	import com.crazyfm.devkit.goSystem.components.physyics.event.PhysObjectSignalEnum;
	import com.crazyfm.devkit.goSystem.components.physyics.model.IPhysBodyObjectModel;
	import com.crazyfm.extension.goSystem.GameComponent;

	import nape.callbacks.InteractionCallback;
	import nape.phys.Body;

	public class AbstractControllable extends GameComponent
	{
		protected var body:Body;
		protected var physObj:IPhysBodyObjectModel;

		public function AbstractControllable()
		{
			super();
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			if (!physObj)
			{
				initializePhysObject();
			}
		}

		protected function initializePhysObject():void
		{
			physObj = gameObject.getComponentByType(IPhysBodyObjectModel) as IPhysBodyObjectModel;

			physObj.addSignalListener(PhysObjectSignalEnum.COLLISION_BEGIN, collisionBegin);
			physObj.addSignalListener(PhysObjectSignalEnum.COLLISION_END, collisionEnd);

			body = physObj.body;
		}

		private function collisionEnd(e:ISignalEvent):void
		{
			var collisionData:PhysObjectSignalData =  e.data as PhysObjectSignalData;

			if (!collisionData.otherShape.sensorEnabled)
			{
				handleCollisionEnd(collisionData);
			}else
			{
				handleSensorEnd(collisionData);
			}
		}

		private function collisionBegin(e:ISignalEvent):void
		{
			var collisionData:PhysObjectSignalData =  e.data as PhysObjectSignalData;

			if (!collisionData.otherShape.sensorEnabled)
			{
				handleCollisionBegin(collisionData);
			}else
			{
				handleSensorBegin(collisionData);
			}
		}

		protected function handleCollisionEnd(collisionData:PhysObjectSignalData):void
		{
		}

		protected function handleCollisionBegin(collisionData:PhysObjectSignalData):void
		{
		}

		protected function handleSensorBegin(collisionData:PhysObjectSignalData):void
		{
		}

		protected function handleSensorEnd(collisionData:PhysObjectSignalData):void
		{
		}

		override public function dispose():void
		{
			if (physObj)
			{
				physObj.removeAllSignalListeners();

				body = null;
				physObj = null;
			}

			super.dispose();
		}

		protected function rotate(angle:Number):void
		{
			body.rotation = angle;
		}

		protected function rotateBodyToNormal(collision:InteractionCallback):void
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
	}
}

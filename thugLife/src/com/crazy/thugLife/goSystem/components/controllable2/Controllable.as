/**
 * Created by Anton Nefjodov on 25.04.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable2
{
	import com.crazy.thugLife.goSystem.components.controllable.MovementType;
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.devkit.goSystem.components.physyics.event.PhysObjectSignalData;
	import com.crazyfm.devkit.goSystem.components.physyics.event.PhysObjectSignalEnum;
	import com.crazyfm.devkit.goSystem.components.physyics.model.IPhysBodyObjectModel;
	import com.crazyfm.extension.goSystem.GameObject;

	import nape.callbacks.InteractionCallback;
	import nape.phys.Body;

	public class Controllable extends GameObject implements IControllable, IControllablePluginContainer
	{
		protected var body:Body;
		protected var physObj:IPhysBodyObjectModel;

		public function Controllable(physObj:IPhysBodyObjectModel)
		{
			super();

			this.physObj = physObj;

			initializePhysObject();
		}

		private function initializePhysObject():void
		{
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

		public function moveLeft(type:MovementType):void
		{
		}

		public function moveRight(type:MovementType):void
		{
		}

		public function moveUp():void
		{
		}

		public function moveDown():void
		{
		}

		public function stopHorizontal():void
		{
		}

		public function stopVertical():void
		{
		}

		public function addPlugin(plugin:IControllable):IControllablePluginContainer
		{
			add()

			return this;
		}

		public function removePlugin(component:IControllable, dispose:Boolean = false):IControllablePluginContainer
		{
			return this;
		}
	}
}

/**
 * Created by Anton Nefjodov on 26.04.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable2
{
	import com.crazy.thugLife.goSystem.components.input.InputActionEnum;
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.devkit.goSystem.components.physyics.event.PhysObjectSignalData;
	import com.crazyfm.devkit.goSystem.components.physyics.event.PhysObjectSignalEnum;
	import com.crazyfm.devkit.goSystem.components.physyics.model.IPhysBodyObjectModel;
	import com.crazyfm.extension.goSystem.GameObject;

	import nape.callbacks.InteractionCallback;
	import nape.hacks.ForcedSleep;

	import nape.phys.Body;

	public class ControllablePluginManager extends GameObject implements IControllablePluginManager
	{
		private var _body:Body;
		private var physObj:IPhysBodyObjectModel;

		private var _isOnLegs:Boolean;

		//need to prevent nape lib bug, after putting object manually to sleep.
		private var collisionJustEnded:Boolean;

		public function ControllablePluginManager(physObj:IPhysBodyObjectModel)
		{
			super();

			this.physObj = physObj;

			physObj.addSignalListener(PhysObjectSignalEnum.COLLISION_BEGIN, collisionBegin);
			physObj.addSignalListener(PhysObjectSignalEnum.COLLISION_END, collisionEnd);

			_body = physObj.body;
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			collisionJustEnded = true;
		}

		public function addPlugin(plugin:IControllablePlugin):IControllablePluginManager
		{
			add(plugin);

			return this;
		}

		public function inputAction(action:InputActionEnum):IControllablePluginManager
		{
			for each (var plugin:IControllablePlugin in _childrenList)
			{
				plugin.inputAction(action);
			}

			return this;
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

			dispatchSignalToChildren(e.type, e.data);

			collisionJustEnded = true;
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

			dispatchSignalToChildren(e.type, e.data);
		}

		private function handleCollisionEnd(collisionData:PhysObjectSignalData):void
		{

		}

		private function handleCollisionBegin(collisionData:PhysObjectSignalData):void
		{
			_isOnLegs = computeIsOnLegs(collisionData.collision);
		}

		private function handleSensorBegin(collisionData:PhysObjectSignalData):void
		{

		}

		private function handleSensorEnd(collisionData:PhysObjectSignalData):void
		{

		}

		override public function dispose():void
		{
			if (physObj)
			{
				physObj.removeAllSignalListeners();

				_body = null;
				physObj = null;
			}

			super.dispose();
		}

		private function computeIsOnLegs(collision:InteractionCallback):Boolean
		{
			if (collision.arbiters.length == 0) return false;

			for (var i:int = 0; i < collision.arbiters.length; i++)
			{
				if (_body.worldVectorToLocal(collision.arbiters.at(i).collisionArbiter.normal).y < 0.3)
				{
					return false;
				}
			}

			return true;
		}

		ns_controllable function get body():Body
		{
			return _body;
		}

		ns_controllable function tryToSleep():void
		{
			if (!_body.isSleeping && !collisionJustEnded)
			{
				ForcedSleep.sleepBody(_body);
			}
		}

		ns_controllable function get isOnLegs():Boolean
		{
			return _isOnLegs;
		}
	}
}

/**
 * Created by Anton Nefjodov on 21.03.2016.
 */
package com.crazy.thugLife.physics
{
	import com.crazyfm.extension.goSystem.GameComponent;

	import nape.callbacks.InteractionCallback;
	import nape.phys.Body;

	public class PhysObjectComponent extends GameComponent
	{
		private var _body:Body;

		public function PhysObjectComponent()
		{
			super();
		}

		public function setBody(value:Body):PhysObjectComponent
		{
			_body = value;

			_body.userData.clazz = this;

			return this;
		}

		override public function dispose():void
		{
			_body = null;

			super.dispose();
		}

		public function get body():Body
		{
			return _body;
		}

		public function onBodyBeginCollision(collison:InteractionCallback):void
		{
			if (!_body.isStatic())
			{
				dispatchSignal("groundHit");
			}
		}

		public function onBodyEndCollision(collison:InteractionCallback):void
		{
			if (!_body.isStatic())
			{
				_body.rotation = 0;
				dispatchSignal("groundLeft");
			}
		}

		public function onBodyOnGoingCollision(collison:InteractionCallback):void
		{
			if (!_body.isStatic())
			{
				_body.rotation = collison.arbiters.at(0).collisionArbiter.normal.angle + Math.PI / 2;
			}
		}
	}
}

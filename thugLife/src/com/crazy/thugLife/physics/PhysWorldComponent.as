/**
 * Created by Anton Nefjodov on 21.03.2016.
 */
package com.crazy.thugLife.physics
{
	import com.crazyfm.extension.goSystem.GameComponent;

	import nape.callbacks.CbEvent;
	import nape.callbacks.CbType;
	import nape.callbacks.InteractionCallback;
	import nape.callbacks.InteractionListener;
	import nape.callbacks.InteractionType;
	import nape.callbacks.PreCallback;
	import nape.callbacks.PreFlag;
	import nape.callbacks.PreListener;
	import nape.phys.Body;
	import nape.space.Space;

	public class PhysWorldComponent extends GameComponent
	{
		private var _space:Space;

		public function PhysWorldComponent()
		{
			super();
		}

		override public function dispose():void
		{
			_space.listeners.clear();
			_space.clear();

			_space = null;

			super.dispose();
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			if (_space)
			{
				_space.step(timePassed);
			}
		}

		public function setSpace(value:Space):PhysWorldComponent
		{
			if (!_space)
			{
				_space = value;

				createPhysicsListeners();

				return this;
			}

			throw new Error("Space already created!");
		}

		protected function createPhysicsListeners():void
		{
			var bodyBeginCollisionListener:InteractionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, CbType.ANY_BODY, CbType.ANY_BODY, bodyCollisionBeginHandler);
			var bodyOnGoingCollisionListener:InteractionListener = new InteractionListener(CbEvent.ONGOING, InteractionType.COLLISION, CbType.ANY_BODY, CbType.ANY_BODY, bodyCollisionOnGoingHandler);
			var bodyEndCollisionListener:InteractionListener = new InteractionListener(CbEvent.END, InteractionType.COLLISION, CbType.ANY_BODY, CbType.ANY_BODY, bodyCollisionEndHandler);
			var bodyPreCollisionListener:PreListener = new PreListener(InteractionType.COLLISION, CbType.ANY_BODY, CbType.ANY_BODY, bodyPreCollisionHandler);

			_space.listeners.add(bodyBeginCollisionListener);
			_space.listeners.add(bodyOnGoingCollisionListener);
			_space.listeners.add(bodyEndCollisionListener);
			_space.listeners.add(bodyPreCollisionListener);
		}

		private function bodyPreCollisionHandler(preCollision:PreCallback):PreFlag
		{
			//TODO

			return PreFlag.ACCEPT;
		}

		private function bodyCollisionBeginHandler(collision:InteractionCallback):void
		{
			var po_1:PhysObjectComponent = (collision.int1 as Body).userData.clazz as PhysObjectComponent;
			var po_2:PhysObjectComponent = (collision.int2 as Body).userData.clazz as PhysObjectComponent;

			po_1.onBodyBeginCollision(collision);
			po_2.onBodyBeginCollision(collision);
		}

		private function bodyCollisionOnGoingHandler(collision:InteractionCallback):void
		{
			var po_1:PhysObjectComponent = (collision.int1 as Body).userData.clazz as PhysObjectComponent;
			var po_2:PhysObjectComponent = (collision.int2 as Body).userData.clazz as PhysObjectComponent;

			po_1.onBodyOnGoingCollision(collision);
			po_2.onBodyOnGoingCollision(collision);
		}

		private function bodyCollisionEndHandler(collision:InteractionCallback):void
		{
			var po_1:PhysObjectComponent = (collision.int1 as Body).userData.clazz as PhysObjectComponent;
			var po_2:PhysObjectComponent = (collision.int2 as Body).userData.clazz as PhysObjectComponent;

			po_1.onBodyEndCollision(collision);
			po_2.onBodyEndCollision(collision);
		}
	}
}

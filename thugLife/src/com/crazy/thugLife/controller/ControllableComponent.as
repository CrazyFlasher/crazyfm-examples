/**
 * Created by Anton Nefjodov on 24.03.2016.
 */
package com.crazy.thugLife.controller
{
	import com.crazy.thugLife.physics.PhysObjectComponent;
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.extension.goSystem.GameComponent;

	import nape.phys.Material;

	public class ControllableComponent extends GameComponent implements IControllableComponent
	{
		private var physObj:PhysObjectComponent;

		private var _isJumping:Boolean = true;

		public function ControllableComponent()
		{

		}

		public function moveLeft():void
		{
			if (physObj.body.velocity.x == 0 && physObj.body.velocity.y == 0)
			{
				physObj.body.setShapeMaterials(new Material(1, 0, 0, 1, 0));
			}
			physObj.body.velocity.setxy(-100, physObj.body.velocity.y);
		}

		public function moveRight():void
		{
			if (physObj.body.velocity.x == 0 && physObj.body.velocity.y == 0)
			{
				physObj.body.setShapeMaterials(new Material(1, 0, 0, 1, 0));
			}
			physObj.body.velocity.setxy(100, physObj.body.velocity.y);
		}

		public function jump():void
		{
			if (_isJumping)return;

			physObj.body.velocity.setxy(physObj.body.velocity.x, -100);

			_isJumping = true;
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			if (!physObj)
			{
				physObj = gameObject.getComponentByType(PhysObjectComponent) as PhysObjectComponent;

				physObj.addSignalListener("groundHit", groundHit);
				physObj.addSignalListener("groundLeft", groundLeft);
			}
		}

		private function groundLeft(e:ISignalEvent):void
		{
			_isJumping = true;
		}

		private function groundHit(e:ISignalEvent):void
		{
			_isJumping = false;
		}

		override public function dispose():void
		{
			physObj.removeSignalListener("groundHit");
			physObj.removeSignalListener("groundLeft");

			physObj = null;

			super.dispose();
		}

		public function stop():void
		{
			if (physObj)
			{
				if (!_isJumping)
				{
					physObj.body.setShapeMaterials(new Material());
					physObj.body.velocity.setxy(0, 0);
				}else
				{
					physObj.body.velocity.setxy(0, physObj.body.velocity.y);
				}
			}
		}
	}
}

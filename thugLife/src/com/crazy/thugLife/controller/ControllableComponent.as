/**
 * Created by Anton Nefjodov on 24.03.2016.
 */
package com.crazy.thugLife.controller
{
	import com.crazy.thugLife.physics.PhysObjectComponent;
	import com.crazyfm.extension.goSystem.GameComponent;

	import nape.phys.Body;

	public class ControllableComponent extends GameComponent implements IControllableComponent
	{
		private var physBody:Body;

		public function ControllableComponent()
		{
		}

		public function moveLeft():void
		{
			physBody.velocity.setxy(-50, physBody.velocity.y);
		}

		public function moveRight():void
		{
			physBody.velocity.setxy(50, physBody.velocity.y);
		}

		public function moveUp():void
		{
			physBody.velocity.setxy(physBody.velocity.x, -50);
		}

		public function moveDown():void
		{
		}

		override public function interact(timePassed:Number):void
		{
			if (!physBody)
			{
				physBody = (gameObject.getComponentByType(PhysObjectComponent) as PhysObjectComponent).body;
			}

			super.interact(timePassed);
		}

		override public function dispose():void
		{
			physBody = null;

			super.dispose();
		}
	}
}

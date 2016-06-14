/**
 * Created by Anton Nefjodov on 6.05.2016.
 */
package com.crazy.thugLife.game.gearSys.components.view
{
	import com.crazy.thugLife.game.gearSys.components.controllable.IAimable;
	import com.crazyfm.devkit.gearSys.components.view.starling.StarlingView;

	import nape.geom.Vec2;

	import starling.display.Shape;

	public class RayView extends StarlingView
	{
		private var aimable:IAimable;

		private var rayGfx:Shape;

		public function RayView()
		{
			super();
		}

		[PostConstruct]
		public function init():void
		{
			rayGfx = new Shape();
			viewContainer.addChild(rayGfx);
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			if (!aimable)
			{
				aimable = gameObject.getComponentByType(IAimable) as IAimable;
			}

			//TODO:
			var pt:Vec2 = aimable.aimRay.at(Math.min(aimable.aimRay.maxDistance, 1000));

			rayGfx.graphics.clear();
			rayGfx.graphics.lineStyle(1, 0xFF0000);
			rayGfx.graphics.moveTo(aimable.aimRay.origin.x, aimable.aimRay.origin.y);
			rayGfx.graphics.lineTo(pt.x, pt.y);
		}
	}
}

/**
 * Created by Anton Nefjodov on 3.05.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable
{
	import com.crazy.thugLife.goSystem.components.input.GameInputActionEnum;
	import com.crazyfm.devkit.goSystem.components.controllable.AbstractPhysControllable;
	import com.crazyfm.devkit.goSystem.components.controllable.IControllable;
	import com.crazyfm.devkit.goSystem.components.input.AbstractInputActionVo;
	import com.crazyfm.devkit.goSystem.components.input.mouse.MouseActionVo;

	import flash.geom.Point;

	import nape.geom.Ray;
	import nape.geom.Vec2;

	public class Aimable extends AbstractPhysControllable implements IAimable
	{
		private var _aimPosition:Vec2 = new Vec2();
		private var _aimRay:Ray;

		private var rayOrigin:Vec2 = new Vec2();

		private var aimRayOriginOffset:Point = new Point();
		private var rayOffset:Number;

		public function Aimable(aimRayOriginOffset:Point = null, rayOffset:Number = 0)
		{
			super();

			this.rayOffset = rayOffset;

			if (aimRayOriginOffset)
			{
				this.aimRayOriginOffset = aimRayOriginOffset;
			}
		}

		private function getAngle(p1:Vec2, p2:Vec2):Number
		{
			var dx:Number = p1.x - p2.x;
			var dy:Number = p1.y - p2.y;
			return Math.atan2(dy, dx) + Math.PI - intPhysObject.rotation;
		}

		override public function inputAction(actionVo:AbstractInputActionVo):IControllable
		{
			if (actionVo.action == GameInputActionEnum.AIM)
			{
				_aimPosition.x = (actionVo as MouseActionVo).position.x;
				_aimPosition.y = (actionVo as MouseActionVo).position.y;

				updateRay();
			}

			return this;
		}

		private function updateRay():void
		{
			rayOrigin.x = intPhysObject.worldCenterOfMass.x + aimRayOriginOffset.x;
			rayOrigin.y = intPhysObject.worldCenterOfMass.y + aimRayOriginOffset.y;

			if (!_aimRay)
			{
				_aimRay = new Ray(rayOrigin, Vec2.fromPolar(1, getAngle(rayOrigin, _aimPosition)));
				_aimRay.maxDistance = 300;
			}else
			{
				_aimRay.origin = rayOrigin;
				_aimRay.direction = Vec2.fromPolar(1, getAngle(rayOrigin, _aimPosition));
			}

			_aimRay.origin = _aimRay.at(rayOffset);
		}

		public function get aimPosition():Vec2
		{
			return _aimPosition;
		}

		public function get aimRay():Ray
		{
			return _aimRay;
		}
	}
}

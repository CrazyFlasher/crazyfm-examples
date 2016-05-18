/**
 * Created by Anton Nefjodov on 3.05.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable
{
	import com.crazy.thugLife.enums.GameInputActionEnum;
	import com.crazyfm.devkit.goSystem.components.controllable.AbstractPhysControllable;
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

		private var _aimRayOriginOffset:Point = new Point();
		private var _rayOffset:Number = 0;

		public function Aimable()
		{
			super();
		}

		private function getAngle(p1:Vec2, p2:Vec2):Number
		{
			var dx:Number = p1.x - p2.x;
			var dy:Number = p1.y - p2.y;
			return Math.atan2(dy, dx) + Math.PI;
		}

		override protected function handleInputAction(actionVo:AbstractInputActionVo):void
		{
			super.handleInputAction(actionVo);

			if (actionVo.action == GameInputActionEnum.AIM)
			{
				_aimPosition.x = (actionVo as MouseActionVo).position.x;
				_aimPosition.y = (actionVo as MouseActionVo).position.y;

				updateRay();
			}
		}

		private function updateRay():void
		{
			rayOrigin.x = intPhysObject.worldCenterOfMass.x + _aimRayOriginOffset.x;
			rayOrigin.y = intPhysObject.worldCenterOfMass.y + _aimRayOriginOffset.y;

			if (!_aimRay)
			{
				_aimRay = new Ray(Vec2.get(), Vec2.get(1, 1));
			}
			_aimRay.origin = rayOrigin;
			_aimRay.direction = Vec2.fromPolar(1, getAngle(rayOrigin, _aimPosition));

			_aimRay.origin = _aimRay.at(_rayOffset);
		}

		public function get aimPosition():Vec2
		{
			return _aimPosition;
		}

		public function get aimRay():Ray
		{
			return _aimRay;
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			if (!_aimRay)
			{
				_aimPosition.x = intPhysObject.worldCenterOfMass.x + 1;
				_aimPosition.y = intPhysObject.worldCenterOfMass.y;

				updateRay();
			}
		}

		public function get isAimingLeft():Boolean
		{
			return _aimPosition.x < intPhysObject.worldCenterOfMass.x;
		}

		public function setAimBeginPosition(aimRayOriginOffset:Point, rayOffset:Number):IAimable
		{
			_rayOffset = rayOffset;
			_aimRayOriginOffset = aimRayOriginOffset;

			return this;
		}
	}
}

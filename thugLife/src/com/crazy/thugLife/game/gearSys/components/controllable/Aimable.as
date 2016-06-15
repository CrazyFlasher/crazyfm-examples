/**
 * Created by Anton Nefjodov on 3.05.2016.
 */
package com.crazy.thugLife.game.gearSys.components.controllable
{
	import com.crazy.thugLife.game.enums.GameInputActionEnum;
	import com.crazyfm.devkit.gearSys.components.controllable.AbstractPhysControllable;
	import com.crazyfm.devkit.gearSys.components.input.AbstractInputActionVo;
	import com.crazyfm.devkit.gearSys.components.input.mouse.MouseActionVo;

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

			_aimPosition.angle = getAngle(rayOrigin, _aimPosition);

//			var distance:Number = Vec2.distance(rayOrigin, _aimPosition);
//			var diffX:Number = rayOrigin.x - _aimPosition.x;
//			var diffY:Number = rayOrigin.y - _aimPosition.y;

//			rayOrigin.x -= diffX / distance * _rayOffset;
//			rayOrigin.y -= diffY / distance * _rayOffset;

			if (!_aimRay)
			{
				_aimRay = new Ray(Vec2.get(), Vec2.get(1, 1));
			}
			_aimRay.origin = rayOrigin;
//			_aimRay.direction = Vec2.fromPolar(1, getAngle(rayOrigin, _aimPosition), true);
			_aimRay.direction = _aimPosition;

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

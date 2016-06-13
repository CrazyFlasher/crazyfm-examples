/**
 * Created by Anton Nefjodov on 18.05.2016.
 */
package com.crazy.thugLife.common.enums
{
	import com.crazyfm.core.common.Enum;

	import flash.geom.Point;

	public class WeaponEnum extends Enum
	{
		public static const HOLSTER:WeaponEnum = new WeaponEnum("holster", 0, new Point(0, -18), 10);
		public static const PISTOL:WeaponEnum = new WeaponEnum("pistol", 1, new Point(0, -18), 30);
		public static const RIFLE:WeaponEnum = new WeaponEnum("rifle", 2, new Point(0, -18), 50);
		public static const SHOTGUN:WeaponEnum = new WeaponEnum("shotgun", 3, new Point(0, -18), 50);
		public static const BAZOOKA:WeaponEnum = new WeaponEnum("bazooka", 4, new Point(0, -18), 40);

		private var _id:int;
		private var _aimRayOriginOffset:Point;
		private var _rayOffset:Number;

		public function WeaponEnum(name:String, id:int, aimRayOriginOffset:Point, rayOffset:Number)
		{
			super(name);

			_id = id;
			_aimRayOriginOffset = aimRayOriginOffset;
			_rayOffset = rayOffset;
		}

		public function get id():int
		{
			return _id;
		}

		public function get aimRayOriginOffset():Point
		{
			return _aimRayOriginOffset;
		}

		public function get rayOffset():Number
		{
			return _rayOffset;
		}
	}
}

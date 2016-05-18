/**
 * Created by Anton Nefjodov on 18.05.2016.
 */
package com.crazy.thugLife.enums
{
	import com.crazyfm.core.common.Enum;

	public class WeaponEnum extends Enum
	{
		public static const PISTOL:WeaponEnum = new WeaponEnum("PISTOL", 1);
		public static const RIFLE:WeaponEnum = new WeaponEnum("RIFLE", 2);
		public static const SHOTGUN:WeaponEnum = new WeaponEnum("SHOTGUN", 3);
		public static const BAZOOKA:WeaponEnum = new WeaponEnum("BAZOOKA", 4);

		private var _id:int;

		public function WeaponEnum(name:String, id:int)
		{
			super(name);

			_id = id;
		}
	}
}

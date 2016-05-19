/**
 * Created by Anton Nefjodov on 18.05.2016.
 */
package com.crazy.thugLife.enums
{
	import com.crazyfm.core.common.Enum;

	public class WeaponEnum extends Enum
	{
		public static const HOLSTER:WeaponEnum = new WeaponEnum("holster", 0);
		public static const PISTOL:WeaponEnum = new WeaponEnum("pistol", 1);
		public static const RIFLE:WeaponEnum = new WeaponEnum("rifle", 2);
		public static const SHOTGUN:WeaponEnum = new WeaponEnum("shotgun", 3);
		public static const BAZOOKA:WeaponEnum = new WeaponEnum("bazooka", 4);

		private var _id:int;

		public function WeaponEnum(name:String, id:int)
		{
			super(name);

			_id = id;
		}
	}
}

/**
 * Created by Anton Nefjodov on 18.05.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable
{
	import com.crazy.thugLife.enums.WeaponEnum;
	import com.crazyfm.devkit.goSystem.components.controllable.AbstractPhysControllable;

	public class Armed extends AbstractPhysControllable implements IArmed
	{
		private var _currentWeapon:WeaponEnum;

		public function Armed()
		{
			super();
		}

		public function get currentWeapon():WeaponEnum
		{
			return _currentWeapon;
		}

		public function setCurrentWeapon(value:WeaponEnum):IArmed
		{
			_currentWeapon = value;

			return this;
		}

		public function removeWeapon():IArmed
		{
			_currentWeapon = null;

			return this;
		}
	}
}

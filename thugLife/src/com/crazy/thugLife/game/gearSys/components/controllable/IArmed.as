/**
 * Created by Anton Nefjodov on 18.05.2016.
 */
package com.crazy.thugLife.game.gearSys.components.controllable
{
	import com.crazy.thugLife.common.enums.WeaponEnum;

	public interface IArmed extends IAimable
	{
		function get currentWeapon():WeaponEnum;
		function setCurrentWeapon(value:WeaponEnum):IArmed;
		function removeWeapon():IArmed;
		function get isChangingWeapon():Boolean;
	}
}

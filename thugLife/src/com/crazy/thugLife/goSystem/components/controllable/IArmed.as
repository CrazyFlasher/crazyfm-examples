/**
 * Created by Anton Nefjodov on 18.05.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable
{
	import com.crazy.thugLife.enums.WeaponEnum;
	import com.crazyfm.extension.goSystem.IGOSystemComponent;

	public interface IArmed extends IGOSystemComponent
	{
		function get currentWeapon():WeaponEnum;
		function setCurrentWeapon(value:WeaponEnum):IArmed;
		function removeWeapon():IArmed;
	}
}

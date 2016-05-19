/**
 * Created by Anton Nefjodov on 18.05.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable
{
	import com.crazy.thugLife.enums.GameInputActionEnum;
	import com.crazy.thugLife.enums.WeaponEnum;
	import com.crazyfm.devkit.goSystem.components.input.AbstractInputActionVo;

	import flash.geom.Point;

	public class Armed extends Aimable implements IArmed
	{
		private var _currentWeapon:WeaponEnum;

		private var _isChangingWeapon:Boolean;

		public function Armed()
		{
			super();
		}

		override protected function handleInputAction(actionVo:AbstractInputActionVo):void
		{
			super.handleInputAction(actionVo);

			if (actionVo.action == GameInputActionEnum.CHANGE_WEAPON)
			{
				if (_currentWeapon == WeaponEnum.PISTOL)
				{
					setCurrentWeapon(WeaponEnum.HOLSTER);
				}else
				{
					setCurrentWeapon(WeaponEnum.PISTOL);
				}
			}
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			_isChangingWeapon = false;
		}

		public function get currentWeapon():WeaponEnum
		{
			return _currentWeapon;
		}

		public function setCurrentWeapon(value:WeaponEnum):IArmed
		{
			if (_currentWeapon == value)
			{
				return this;
			}

			_currentWeapon = value;

			switch (_currentWeapon)
			{
				case WeaponEnum.PISTOL:
					setAimBeginPosition(new Point(0, -18), 30);
					break;
				default:
					setAimBeginPosition(new Point(0, 0), 0);
			}

			_isChangingWeapon = true;

			return this;
		}

		public function removeWeapon():IArmed
		{
			_currentWeapon = null;

			return this;
		}

		public function get isChangingWeapon():Boolean
		{
			return _isChangingWeapon;
		}
	}
}

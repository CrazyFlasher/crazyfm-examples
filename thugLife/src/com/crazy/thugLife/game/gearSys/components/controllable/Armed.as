/**
 * Created by Anton Nefjodov on 18.05.2016.
 */
package com.crazy.thugLife.game.gearSys.components.controllable
{
	import com.crazy.thugLife.game.enums.GameInputActionEnum;
	import com.crazy.thugLife.common.enums.WeaponEnum;
	import com.crazyfm.devkit.gearSys.components.input.AbstractInputActionVo;

	public class Armed extends Aimable implements IArmed
	{
		private var _currentWeapon:WeaponEnum;

		private var _isChangingWeapon:Boolean;

		public function Armed()
		{
			super();
		}

		override public function interact(timePassed:Number):void
		{
			if (_isChangingWeapon)
			{
				_isChangingWeapon = false;
			}

			super.interact(timePassed);
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

			setAimBeginPosition(_currentWeapon.aimRayOriginOffset, _currentWeapon.rayOffset);

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

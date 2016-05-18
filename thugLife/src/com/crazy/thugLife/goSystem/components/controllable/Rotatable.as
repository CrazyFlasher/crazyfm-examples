/**
 * Created by Anton Nefjodov on 9.05.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable
{
	import com.crazy.thugLife.enums.GameInputActionEnum;
	import com.crazyfm.devkit.goSystem.components.controllable.AbstractPhysControllable;
	import com.crazyfm.devkit.goSystem.components.input.AbstractInputActionVo;
	import com.crazyfm.devkit.goSystem.components.input.mouse.MouseActionVo;

	public class Rotatable extends AbstractPhysControllable implements IRotatable
	{
		private var _isRotatedLeft:Boolean;

		public function Rotatable()
		{
			super();
		}

		public function get isRotatedLeft():Boolean
		{
			return _isRotatedLeft;
		}

		override protected function handleInputAction(actionVo:AbstractInputActionVo):void
		{
			super.handleInputAction(actionVo);

			if (actionVo.action == GameInputActionEnum.AIM)
			{
				_isRotatedLeft = (actionVo as MouseActionVo).position.x < intPhysObject.position.x && !intPhysObject.zeroGravity;
			}
		}
	}
}

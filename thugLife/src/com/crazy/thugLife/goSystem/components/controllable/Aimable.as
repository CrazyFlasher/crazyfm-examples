/**
 * Created by Anton Nefjodov on 3.05.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable
{
	import com.crazy.thugLife.goSystem.components.input.GameInputActionEnum;
	import com.crazyfm.devkit.goSystem.components.controllable.AbstractPhysControllable;
	import com.crazyfm.devkit.goSystem.components.controllable.IControllable;
	import com.crazyfm.devkit.goSystem.components.input.AbstractInputActionVo;
	import com.crazyfm.devkit.goSystem.components.input.mouse.MouseActionVo;

	import flash.geom.Point;

	public class Aimable extends AbstractPhysControllable implements IAimable
	{
		private var _aimPosition:Point = new Point();

		public function Aimable()
		{
			super();
		}

		override public function inputAction(actionVo:AbstractInputActionVo):IControllable
		{
			if (actionVo.action == GameInputActionEnum.AIM)
			{
				_aimPosition.x = (actionVo as MouseActionVo).position.x;
				_aimPosition.y = (actionVo as MouseActionVo).position.y;
			}

			return this;
		}

		public function get aimPosition():Point
		{
			return _aimPosition;
		}
	}
}

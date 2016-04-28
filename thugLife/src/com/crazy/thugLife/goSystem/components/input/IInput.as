/**
 * Created by Anton Nefjodov on 13.04.2016.
 */
package com.crazy.thugLife.goSystem.components.input
{
	import com.crazyfm.devkit.goSystem.components.input.AbstractInputActionEnum;
	import com.crazyfm.extension.goSystem.IGameComponent;

	public interface IInput extends IGameComponent
	{
		function sendActionToControllables(action:AbstractInputActionEnum):IInput;
	}
}

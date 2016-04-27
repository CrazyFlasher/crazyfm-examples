/**
 * Created by Anton Nefjodov on 26.04.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable.plugins
{
	import com.crazy.thugLife.goSystem.components.input.InputActionEnum;
	import com.crazyfm.extension.goSystem.IGameComponent;

	public interface IControllablePlugin extends IGameComponent
	{
		function inputAction(action:InputActionEnum):IControllablePlugin;
	}
}

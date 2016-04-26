/**
 * Created by Anton Nefjodov on 26.04.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable2
{
	import com.crazy.thugLife.goSystem.components.input.InputActionEnum;
	import com.crazyfm.extension.goSystem.IGameObject;

	public interface IControllablePluginManager extends IGameObject
	{
		function inputAction(action:InputActionEnum):IControllablePluginManager;

		function addPlugin(plugin:IControllablePlugin):IControllablePluginManager;
	}
}

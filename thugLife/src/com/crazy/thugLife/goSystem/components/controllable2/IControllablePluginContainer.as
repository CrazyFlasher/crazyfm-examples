/**
 * Created by Anton Nefjodov on 25.04.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable2
{
	import com.crazyfm.extension.goSystem.IGameObject;

	public interface IControllablePluginContainer extends IGameObject
	{
		function addPlugin(plugin:IControllable):IControllablePluginContainer;
		function removePlugin(component:IControllable, dispose:Boolean = false):IControllablePluginContainer;
	}
}

/**
 * Created by Anton Nefjodov on 10.05.2016.
 */
package com.crazy.thugLife.goSystem.gameObjects
{
	import com.crazyfm.devkit.goSystem.components.input.IInput;
	import com.crazyfm.extension.goSystem.IGOSystemObject;

	import starling.display.DisplayObject;

	public interface IHumanGameObject extends IGOSystemObject
	{
		function get skin():DisplayObject;
		function addInput(value:IInput):IHumanGameObject;
	}
}

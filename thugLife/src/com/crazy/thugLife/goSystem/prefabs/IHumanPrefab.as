/**
 * Created by Anton Nefjodov on 10.05.2016.
 */
package com.crazy.thugLife.goSystem.prefabs
{
	import com.crazyfm.devkit.goSystem.components.input.IInput;
	import com.crazyfm.extension.goSystem.IGOSystemObject;

	import nape.geom.Vec2;

	import starling.display.DisplayObject;

	public interface IHumanPrefab extends IGOSystemObject
	{
		function get skin():DisplayObject;
		function addInput(value:IInput):IHumanPrefab;
		function get aimPosition():Vec2;
	}
}

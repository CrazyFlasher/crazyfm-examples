/**
 * Created by Anton Nefjodov on 10.05.2016.
 */
package com.crazy.thugLife.game.gearSys.prefabs
{
	import com.crazyfm.devkit.gearSys.components.input.IInput;
	import com.crazyfm.extension.gearSys.IGearSysObject;

	import nape.geom.Vec2;

	import starling.display.DisplayObject;

	HumanPrefab;
	public interface IHumanPrefab extends IGearSysObject
	{
		function get skin():DisplayObject;
		function addInput(value:IInput):IHumanPrefab;
		function get aimPosition():Vec2;
	}
}

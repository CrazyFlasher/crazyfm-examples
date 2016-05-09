/**
 * Created by Anton Nefjodov on 9.05.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable
{
	import com.crazyfm.extension.goSystem.IGameComponent;

	public interface IRotatable extends IGameComponent
	{
		function get isRotatedLeft():Boolean;
	}
}

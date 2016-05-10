/**
 * Created by Anton Nefjodov on 9.05.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable
{
	import com.crazyfm.extension.goSystem.IGOSystemComponent;

	public interface IRotatable extends IGOSystemComponent
	{
		function get isRotatedLeft():Boolean;
	}
}

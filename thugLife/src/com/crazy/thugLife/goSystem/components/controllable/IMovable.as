/**
 * Created by Anton Nefjodov on 3.05.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable
{
	import com.crazyfm.extension.goSystem.IGOSystemComponent;

	public interface IMovable extends IGOSystemComponent
	{
		function get isMoving():Boolean;
		function get isRunning():Boolean;
		function get isLeftDirection():Boolean;
	}
}

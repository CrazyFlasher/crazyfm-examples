/**
 * Created by Anton Nefjodov on 3.05.2016.
 */
package com.crazy.thugLife.game.gearSys.components.controllable
{
	import com.crazyfm.extension.gearSys.IGearSysComponent;

	Movable;
	public interface IMovable extends IGearSysComponent
	{
		function get isMoving():Boolean;
		function get isRunning():Boolean;
		function get isLeftDirection():Boolean;
	}
}

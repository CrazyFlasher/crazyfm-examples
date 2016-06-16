/**
 * Created by Anton Nefjodov on 3.05.2016.
 */
package com.crazy.thugLife.game.gearSys.components.controllable
{
	import com.crazyfm.extension.gearSys.IGearSysComponent;

	Climbable;
	public interface IClimbable extends IGearSysComponent
	{
		function get isClimbing():Boolean;
		function get isLeavingLadder():Boolean;
	}
}

/**
 * Created by Anton Nefjodov on 3.05.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable
{
	import com.crazyfm.extension.goSystem.IGOSystemComponent;

	public interface IClimbable extends IGOSystemComponent
	{
		function get isClimbing():Boolean;
		function get isLeavingLadder():Boolean;
	}
}

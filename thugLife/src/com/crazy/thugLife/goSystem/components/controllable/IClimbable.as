/**
 * Created by Anton Nefjodov on 3.05.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable
{
	import com.crazyfm.extension.goSystem.IGameComponent;

	public interface IClimbable extends IGameComponent
	{
		function get isClimbing():Boolean;
	}
}
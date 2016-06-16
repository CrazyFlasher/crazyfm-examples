/**
 * Created by Anton Nefjodov on 3.05.2016.
 */
package com.crazy.thugLife.game.gearSys.components.controllable
{
	import com.crazyfm.extension.gearSys.IGearSysComponent;

	Jumpable;
	public interface IJumpable extends IGearSysComponent
	{
		function get isJumping():Boolean;
	}
}

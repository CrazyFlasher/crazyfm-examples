/**
 * Created by Anton Nefjodov on 3.05.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable
{
	import com.crazyfm.extension.goSystem.IGOSystemComponent;

	public interface IJumpable extends IGOSystemComponent
	{
		function get isJumping():Boolean;
	}
}

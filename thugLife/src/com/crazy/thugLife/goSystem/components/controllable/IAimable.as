/**
 * Created by Anton Nefjodov on 3.05.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable
{
	import com.crazyfm.extension.goSystem.IGameComponent;

	import flash.geom.Point;

	public interface IAimable extends IGameComponent
	{
		function get aimPosition():Point;
	}
}

/**
 * Created by Anton Nefjodov on 3.05.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable
{
	import com.crazyfm.extension.goSystem.IGameComponent;

	import nape.geom.Ray;
	import nape.geom.Vec2;

	public interface IAimable extends IGameComponent
	{
		function get aimPosition():Vec2;
		function get aimRay():Ray;
	}
}

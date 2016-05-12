/**
 * Created by Anton Nefjodov on 3.05.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable
{
	import com.crazyfm.extension.goSystem.IGOSystemComponent;

	import nape.geom.Ray;
	import nape.geom.Vec2;

	public interface IAimable extends IGOSystemComponent
	{
		function get aimPosition():Vec2;
		function get aimRay():Ray;
		function get isAimingLeft():Boolean;
	}
}

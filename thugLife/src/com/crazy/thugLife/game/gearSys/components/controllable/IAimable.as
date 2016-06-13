/**
 * Created by Anton Nefjodov on 3.05.2016.
 */
package com.crazy.thugLife.game.gearSys.components.controllable
{
	import com.crazyfm.extension.gearSys.IGearSysComponent;

	import flash.geom.Point;

	import nape.geom.Ray;
	import nape.geom.Vec2;

	public interface IAimable extends IGearSysComponent
	{
		function get aimPosition():Vec2;
		function get aimRay():Ray;
		function get isAimingLeft():Boolean;
		function setAimBeginPosition(aimRayOriginOffset:Point, rayOffset:Number):IAimable;
	}
}

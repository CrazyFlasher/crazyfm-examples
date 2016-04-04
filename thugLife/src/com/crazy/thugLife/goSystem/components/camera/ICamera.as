/**
 * Created by Anton Nefjodov on 4.04.2016.
 */
package com.crazy.thugLife.goSystem.components.camera
{
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;

	public interface ICamera
	{
		function setFocusObject(value:DisplayObject):ICamera;
		function setViewport(value:Rectangle):ICamera;
	}
}

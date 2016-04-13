/**
 * Created by Anton Nefjodov on 24.03.2016.
 */
package com.crazy.thugLife.goSystem.components.controller
{
	import com.crazyfm.extension.goSystem.IGameComponent;

	public interface IControllable extends IGameComponent
	{
		function moveLeft():void;
		function moveRight():void;
		function jump():void;
		function stop():void;
	}
}

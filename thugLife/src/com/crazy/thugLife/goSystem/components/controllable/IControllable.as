/**
 * Created by Anton Nefjodov on 24.03.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable
{
	import com.crazyfm.extension.goSystem.IGameComponent;

	public interface IControllable extends IGameComponent
	{
		function moveLeft(type:MovementType):void;
		function moveRight(type:MovementType):void;
		function moveUp():void;
		function moveDown():void;
		function stopHorizontal():void;
		function stopVertical():void;
	}
}
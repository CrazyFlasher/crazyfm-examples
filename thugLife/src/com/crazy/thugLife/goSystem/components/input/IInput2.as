/**
 * Created by Anton Nefjodov on 13.04.2016.
 */
package com.crazy.thugLife.goSystem.components.input
{
	import com.crazyfm.extension.goSystem.IGameComponent;
	import com.crazyfm.extension.goSystem.IGameObject;

	public interface IInput2 extends IGameObject
	{
		function inputRight():IInput2;
		function inputLeft():IInput2;
		function inputUp():IInput2;
		function inputDown():IInput2;

		function outputRight():IInput2;
		function outputLeft():IInput2;
		function outputUp():IInput2;
		function outputDown():IInput2;
	}
}

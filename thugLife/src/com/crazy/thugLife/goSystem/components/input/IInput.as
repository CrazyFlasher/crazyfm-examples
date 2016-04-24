/**
 * Created by Anton Nefjodov on 13.04.2016.
 */
package com.crazy.thugLife.goSystem.components.input
{
	import com.crazyfm.extension.goSystem.IGameComponent;

	public interface IInput extends IGameComponent
	{
		function inputRight():IInput;
		function inputLeft():IInput;
		function inputUp():IInput;
		function inputDown():IInput;

		function outputRight():IInput;
		function outputLeft():IInput;
		function outputUp():IInput;
		function outputDown():IInput;
	}
}

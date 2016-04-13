/**
 * Created by Anton Nefjodov on 13.04.2016.
 */
package com.crazy.thugLife.goSystem.components.controller
{
	import com.crazyfm.extension.goSystem.IGameComponent;

	public interface IInput extends IGameComponent
	{
		function inputRight():IInput;
		function inputLeft():IInput;
		function inputJump():IInput;

		function outputRight():IInput;
		function outputLeft():IInput;
		function outputJump():IInput;
	}
}

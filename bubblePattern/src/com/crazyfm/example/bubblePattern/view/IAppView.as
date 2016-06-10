/**
 * Created by Anton Nefjodov on 9.06.2016.
 */
package com.crazyfm.example.bubblePattern.view
{
	import com.crazyfm.core.mvc.view.IView;

	public interface IAppView extends IView
	{
		function onAgeChanged():void;
		function onLastNameChanged():void;
		function onFirstNameChanged():void;
	}
}

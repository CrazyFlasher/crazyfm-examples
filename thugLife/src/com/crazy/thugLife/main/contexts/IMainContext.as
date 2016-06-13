/**
 * Created by Anton Nefjodov on 13.06.2016.
 */
package com.crazy.thugLife.main.contexts
{
	import com.crazyfm.core.mvc.context.IContext;

	public interface IMainContext extends IContext
	{
		function launchGame():IMainContext;
		function launchLobby():IMainContext;
	}
}

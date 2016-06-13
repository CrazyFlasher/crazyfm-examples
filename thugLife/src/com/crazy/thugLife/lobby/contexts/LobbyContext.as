/**
 * Created by Anton Nefjodov on 13.06.2016.
 */
package com.crazy.thugLife.lobby.contexts
{
	import com.crazyfm.core.factory.IAppFactory;
	import com.crazyfm.core.mvc.context.AbstractContext;

	import starling.display.DisplayObjectContainer;

	public class LobbyContext extends AbstractContext implements ILobbyContext
	{
		[Autowired]
		public var viewContainer:DisplayObjectContainer;

		public function LobbyContext(factory:IAppFactory)
		{
			super(factory);
		}

		[PostConstruct]
		public function init():void
		{

		}
	}
}

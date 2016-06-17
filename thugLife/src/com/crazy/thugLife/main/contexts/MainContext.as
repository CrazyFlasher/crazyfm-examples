/**
 * Created by Anton Nefjodov on 13.06.2016.
 */
package com.crazy.thugLife.main.contexts
{
	import com.crazy.thugLife.common.messages.ContextMessageType;
	import com.crazy.thugLife.game.contexts.GameContext;
	import com.crazy.thugLife.game.contexts.IGameContext;
	import com.crazy.thugLife.lobby.contexts.ILobbyContext;
	import com.crazy.thugLife.lobby.contexts.LobbyContext;
	import com.crazyfm.core.factory.AppFactory;
	import com.crazyfm.core.factory.IAppFactory;
	import com.crazyfm.core.mvc.context.AbstractContext;
	import com.crazyfm.core.mvc.context.IContext;
	import com.crazyfm.core.mvc.message.IMessage;

	import flash.system.System;

	import flash.ui.Keyboard;

	import starling.core.Starling;
	import starling.display.Stage;
	import starling.events.KeyboardEvent;

	public class MainContext extends AbstractContext implements IMainContext
	{
		[Autowired]
		public var stage:Stage;

		private var gameContext:IGameContext;
		private var lobbyContext:ILobbyContext;

		public function MainContext()
		{
			super();
		}

		[PostConstruct]
		override public function init():void
		{
			super.init();

			Starling.current.showStats = true;

			factory.mapToType(IGameContext, GameContext);
			factory.mapToType(ILobbyContext, LobbyContext);

			addMessageListener(ContextMessageType.EXIT, onContextExit);

			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);

			launchGame();

//			setInterval(switchContexts, 400);
		}

		private function onKeyUp(event:KeyboardEvent, keyCode:uint):void
		{
			if (keyCode == Keyboard.SPACE)
			{
				switchContexts();
			}
		}

		private function switchContexts():void
		{
			if (gameContext)
			{
				launchLobby();
			}else
			{
				launchGame();
			}
		}

		private function onContextExit(message:IMessage):void
		{
			var context:IContext = message.target as IContext;

			if (context is ILobbyContext)
			{
				launchGame();
			}else
			if (context is IGameContext)
			{
				launchLobby();
			}
		}

		public function launchGame():IMainContext
		{
			destroyContext(lobbyContext);
			lobbyContext = null;

			factory.mapToValue(IAppFactory, new AppFactory());
			gameContext = factory.getInstance(IGameContext);
			addModel(gameContext);

			return this;
		}

		public function launchLobby():IMainContext
		{
			destroyContext(gameContext);
			gameContext = null;

			factory.mapToValue(IAppFactory, new AppFactory());
			lobbyContext = factory.getInstance(ILobbyContext);
			addModel(lobbyContext);

			return this;
		}

		private function destroyContext(context:IContext):void
		{
			if (context)
			{
				removeModel(context);

				context.dispose();
			}

			System.pauseForGCIfCollectionImminent(0);
		}
	}
}

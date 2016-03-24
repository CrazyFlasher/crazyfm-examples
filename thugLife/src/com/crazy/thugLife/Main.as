/**
 * Created by Anton Nefjodov on 21.03.2016.
 */
package com.crazy.thugLife
{
	import com.crazy.thugLife.controller.ControllableComponent;
	import com.crazy.thugLife.controller.KeyBoardController;
	import com.crazy.thugLife.physics.PhysObjectComponent;
	import com.crazy.thugLife.physics.PhysWorldComponent;
	import com.crazy.thugLife.view.PhysDebugViewComponent;
	import com.crazyfm.devkit.goSystem.mechanisms.StarlingJugglerMechanism;
	import com.crazyfm.extension.goSystem.GOSystem;
	import com.crazyfm.extension.goSystem.GameObject;
	import com.crazyfm.extension.goSystem.IGOSystem;
	import com.crazyfm.extension.goSystem.IGameObject;
	import com.crazyfm.extensions.physics.IWorldObject;
	import com.crazyfm.extensions.physics.WorldObject;
	import com.crazyfm.extensions.physics.utils.PhysicsParser;

	import flash.utils.ByteArray;

	import starling.core.Starling;
	import starling.display.Sprite;

	public class Main extends Sprite
	{
		[Embed(source="../../../../resources/test.json", mimeType="application/octet-stream")]
		private var WorldClass:Class;

		private var worldDataObject:IWorldObject;

		private var goSystem:IGOSystem;

		private var main:IGameObject;
		private var floor:IGameObject;
		private var user:IGameObject;

		public function Main()
		{
			super();

			worldDataObject = new WorldObject();
			worldDataObject.data = PhysicsParser.parseWorld(JSON.parse((new WorldClass() as ByteArray).toString()));

			goSystem = new GOSystem()
					.setMechanism(new StarlingJugglerMechanism()
							.setJuggler(Starling.juggler))
					.addGameObject(main = new GameObject()
							.addComponent(new PhysWorldComponent()
									.setSpace(worldDataObject.space))
							.addComponent(new PhysDebugViewComponent()
									.setSpace(worldDataObject.space)
									.setViewContainer(Starling.current.nativeOverlay)))
					.addGameObject(user = new GameObject()
							.addComponent(new PhysObjectComponent()
									.setBody(worldDataObject.bodyObjectById("user").body))
							.addComponent(new ControllableComponent())
							.addComponent(new KeyBoardController()
									.setNativeStage(Starling.current.nativeStage)))
					.addGameObject(floor = new GameObject()
							.addComponent(new PhysObjectComponent()
									.setBody(worldDataObject.bodyObjectById("ground").body)));
		}
	}
}

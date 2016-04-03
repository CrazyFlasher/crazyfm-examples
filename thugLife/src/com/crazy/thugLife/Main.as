/**
 * Created by Anton Nefjodov on 21.03.2016.
 */
package com.crazy.thugLife
{
	import com.crazy.thugLife.goSystem.components.controller.Controllable;
	import com.crazy.thugLife.goSystem.components.controller.KeyboardController;
	import com.crazyfm.devkit.goSystem.components.view.PhysDebugView;
	import com.crazyfm.devkit.goSystem.components.physyics.PhysBodyObject;
	import com.crazyfm.devkit.goSystem.components.physyics.PhysWorld;
	import com.crazyfm.devkit.goSystem.mechanisms.StarlingJugglerMechanism;
	import com.crazyfm.extension.goSystem.GOSystem;
	import com.crazyfm.extension.goSystem.GameObject;
	import com.crazyfm.extension.goSystem.IGOSystem;
	import com.crazyfm.extension.goSystem.IGameObject;
	import com.crazyfm.extensions.physics.IWorldObject;
	import com.crazyfm.extensions.physics.WorldObject;
	import com.crazyfm.extensions.physics.utils.PhysicsParser;

	import flash.utils.ByteArray;

	import nape.phys.Body;

	import nape.space.Space;

	import org.swiftsuspenders.Injector;

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

			//stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown)

			var space:Space = worldDataObject.space;
			var floorBody:Body = worldDataObject.bodyObjectById("ground").body;
			var userBody:Body = worldDataObject.bodyObjectById("user").body;

			goSystem = new GOSystem(new StarlingJugglerMechanism(Starling.juggler))
					.addGameObject(main = new GameObject()
							.addComponent(new PhysWorld(space))
							.addComponent(new PhysDebugView(space, Starling.current.nativeOverlay)))
					.addGameObject(user = new GameObject()
							.addComponent(new PhysBodyObject(userBody))
							.addComponent(new Controllable())
							.addComponent(new KeyboardController(Starling.current.nativeStage)))
					.addGameObject(floor = new GameObject()
							.addComponent(new PhysBodyObject(floorBody)));

		}
	}
}

/**
 * Created by Anton Nefjodov on 21.03.2016.
 */
package com.crazy.thugLife
{
	import com.crazy.thugLife.goSystem.components.camera.Camera;
	import com.crazy.thugLife.goSystem.components.camera.ICamera;
	import com.crazy.thugLife.goSystem.components.controller.Controllable;
	import com.crazy.thugLife.goSystem.components.controller.KeyboardInput;
	import com.crazyfm.devkit.goSystem.components.physyics.model.PhysBodyObjectModel;
	import com.crazyfm.devkit.goSystem.components.physyics.model.PhysWorldModel;
	import com.crazyfm.devkit.goSystem.components.physyics.view.IPhysBodyObjectView;
	import com.crazyfm.devkit.goSystem.components.physyics.view.starling.PhysBodyObjectFromDataView;
	import com.crazyfm.devkit.goSystem.mechanisms.StarlingEnterFrameMechanism;
	import com.crazyfm.extension.goSystem.GOSystem;
	import com.crazyfm.extension.goSystem.GameObject;
	import com.crazyfm.extension.goSystem.IGOSystem;
	import com.crazyfm.extension.goSystem.IGameObject;
	import com.crazyfm.extensions.physics.IWorldObject;
	import com.crazyfm.extensions.physics.WorldObject;
	import com.crazyfm.extensions.physics.utils.PhysicsParser;

	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;

	import nape.phys.Body;
	import nape.space.Space;

	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;

	public class Main extends Sprite
	{
		[Embed(source="../../../../resources/test.json", mimeType="application/octet-stream")]
		private var WorldClass:Class;

		private var worldDataObject:IWorldObject;

		private var goSystem:IGOSystem;

		private var main:IGameObject;
		private var floor:IGameObject;
		private var user:IGameObject;
		private var sensors:IGameObject;

		private var camera:ICamera;
		private var userSkin:IPhysBodyObjectView;

		public function Main()
		{
			super();

			Starling.current.showStats = true;

			worldDataObject = new WorldObject();
			worldDataObject.data = PhysicsParser.parseWorld(JSON.parse((new WorldClass() as ByteArray).toString()));

			addEventListener(Event.ADDED_TO_STAGE, added);
		}

		private function added():void
		{
			var space:Space = worldDataObject.space;
			var floorBody:Body = worldDataObject.bodyObjectById("ground").body;
			var userBody:Body = worldDataObject.bodyObjectById("user").body;
			var sensorsBody:Body = worldDataObject.bodyObjectById("sensors").body;

			var debugViewSprite:flash.display.Sprite = new flash.display.Sprite();
			debugViewSprite.alpha = 0.5;
			Starling.current.nativeOverlay.addChild(debugViewSprite);

			var mainViewContainer:Sprite = new Sprite();
			addChild(mainViewContainer);

			goSystem = new GOSystem(new StarlingEnterFrameMechanism(1 / Starling.current.nativeStage.frameRate))
					.addGameObject(main = new GameObject()
							.addComponent(new PhysWorldModel(space))
//							.addComponent(new PhysDebugView(space, debugViewSprite))
							.addComponent(camera = new Camera(mainViewContainer)))
					.addGameObject(user = new GameObject()
							.addComponent(new PhysBodyObjectModel(userBody))
							.addComponent(new Controllable(150, 300, 150))
							.addComponent(new KeyboardInput(stage))
							.addComponent(userSkin = new PhysBodyObjectFromDataView(mainViewContainer, worldDataObject.bodyObjectById("user").data.shapeDataList, 0x00CC00)))
					.addGameObject(floor = new GameObject()
							.addComponent(new PhysBodyObjectModel(floorBody))
							.addComponent(new PhysBodyObjectFromDataView(mainViewContainer, worldDataObject.bodyObjectById("ground").data.shapeDataList, 0xFFCC00)))
					.addGameObject(sensors = new GameObject()
							.addComponent(new PhysBodyObjectModel(sensorsBody))
							.addComponent(new PhysBodyObjectFromDataView(mainViewContainer, worldDataObject.bodyObjectById("sensors").data.shapeDataList, 0xFF00FF))

					);

			goSystem.updateNow();

			camera.setFocusObject(userSkin.skin);
			camera.setViewport(new Rectangle(0, 0, stage.stageWidth, stage.stageHeight));
		}
	}
}

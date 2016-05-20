/**
 * Created by Anton Nefjodov on 21.03.2016.
 */
package com.crazy.thugLife
{
	import com.catalystapps.gaf.core.ZipToGAFAssetConverter;
	import com.catalystapps.gaf.data.GAFBundle;
	import com.crazy.thugLife.enums.GameInputActionEnum;
	import com.crazy.thugLife.goSystem.prefabs.HumanPrefab;
	import com.crazy.thugLife.goSystem.prefabs.IHumanPrefab;
	import com.crazyfm.core.common.AppFactory;
	import com.crazyfm.core.common.ns_app_factory;
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.devkit.goSystem.components.camera.Camera;
	import com.crazyfm.devkit.goSystem.components.camera.ICamera;
	import com.crazyfm.devkit.goSystem.components.input.keyboard.KeyboardInput;
	import com.crazyfm.devkit.goSystem.components.input.keyboard.KeysToActionMapping;
	import com.crazyfm.devkit.goSystem.components.input.mouse.MouseInput;
	import com.crazyfm.devkit.goSystem.components.input.mouse.MouseToActionMapping;
	import com.crazyfm.devkit.goSystem.components.physyics.model.PhysBodyObjectModel;
	import com.crazyfm.devkit.goSystem.components.physyics.model.PhysWorldModel;
	import com.crazyfm.devkit.goSystem.components.physyics.view.starling.PhysBodyObjectFromDataView;
	import com.crazyfm.devkit.goSystem.mechanisms.StarlingEnterFrameMechanism;
	import com.crazyfm.devkit.physics.CFBodyObject;
	import com.crazyfm.devkit.physics.CFShapeObject;
	import com.crazyfm.extension.goSystem.GOSystem;
	import com.crazyfm.extension.goSystem.GOSystemObject;
	import com.crazyfm.extension.goSystem.IGOSystem;
	import com.crazyfm.extension.goSystem.events.GOSystemSignalEnum;
	import com.crazyfm.extensions.physics.IBodyObject;
	import com.crazyfm.extensions.physics.IJointObject;
	import com.crazyfm.extensions.physics.IShapeObject;
	import com.crazyfm.extensions.physics.IVertexObject;
	import com.crazyfm.extensions.physics.IWorldObject;
	import com.crazyfm.extensions.physics.JointObject;
	import com.crazyfm.extensions.physics.VertexObject;
	import com.crazyfm.extensions.physics.WorldObject;
	import com.crazyfm.extensions.physics.vo.units.WorldDataVo;

	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.utils.ByteArray;

	import nape.space.Space;

	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;

	use namespace ns_app_factory;

	public class Main extends Sprite
	{
		[Embed(source="../../../../resources/test.json", mimeType="application/octet-stream")]
		private var WorldClass:Class;

		[Embed(source="../../../../resources/test_assets.zip", mimeType="application/octet-stream")]
		private const BundleZip:Class;

		private var worldObject:IWorldObject;

		private var user:IHumanPrefab;
		private var enemy:IHumanPrefab;

		private var gafBundle:GAFBundle;

		private var camera:ICamera;

		public function Main()
		{
			super();

			Starling.current.showStats = true;

			createPhysics();

			addEventListener(Event.ADDED_TO_STAGE, added);
		}

		private function createPhysics():void
		{
			AppFactory.map(IWorldObject, WorldObject);
			AppFactory.map(IBodyObject, CFBodyObject);
			AppFactory.map(IShapeObject, CFShapeObject);
			AppFactory.map(IJointObject, JointObject);
			AppFactory.map(IVertexObject, VertexObject);

			var worldData:WorldDataVo = getNewInstance(WorldDataVo, JSON.parse((new WorldClass() as ByteArray).toString()));

			worldObject = getNewInstance(WorldObject, worldData);
		}

		private function added():void
		{
			initGafAssets();
		}

		private function initGafAssets():void
		{
			var zip:ByteArray = new BundleZip();
			var converter:ZipToGAFAssetConverter = new ZipToGAFAssetConverter();
			converter.addEventListener("complete", onConverted);
			converter.convert(zip);
		}

		private function onConverted(event:*):void
		{
			gafBundle = (event.target as ZipToGAFAssetConverter).gafBundle;

			start();
		}

		private function start():void
		{
			var keysToAction:Vector.<KeysToActionMapping> = new <KeysToActionMapping>[
				new KeysToActionMapping(GameInputActionEnum.MOVE_LEFT, new <uint>[Keyboard.LEFT]),
				new KeysToActionMapping(GameInputActionEnum.RUN_LEFT, new <uint>[Keyboard.LEFT, Keyboard.SHIFT]),
				new KeysToActionMapping(GameInputActionEnum.MOVE_RIGHT, new <uint>[Keyboard.RIGHT]),
				new KeysToActionMapping(GameInputActionEnum.RUN_RIGHT, new <uint>[Keyboard.RIGHT, Keyboard.SHIFT]),
				new KeysToActionMapping(GameInputActionEnum.MOVE_UP, new <uint>[Keyboard.UP]),
				new KeysToActionMapping(GameInputActionEnum.MOVE_DOWN, new <uint>[Keyboard.DOWN]),
				new KeysToActionMapping(GameInputActionEnum.STOP_HORIZONTAL, null, new <uint>[Keyboard.LEFT, Keyboard.RIGHT]),
				new KeysToActionMapping(GameInputActionEnum.STOP_VERTICAL, null, new <uint>[Keyboard.UP, Keyboard.DOWN]),
				new KeysToActionMapping(GameInputActionEnum.TOGGLE_RUN, null, new <uint>[Keyboard.CAPS_LOCK]),
				new KeysToActionMapping(GameInputActionEnum.CHANGE_WEAPON, null, new <uint>[Keyboard.Z])
			];

			var mouseToAction:Vector.<MouseToActionMapping> = new <MouseToActionMapping>[
				new MouseToActionMapping(GameInputActionEnum.AIM, false, false, false, true)
			];

			var space:Space = worldObject.space;
			var floorBodyObject:IBodyObject = worldObject.bodyObjectById("ground");
			var userBodyObject:IBodyObject = worldObject.bodyObjectById("user");
			var enemyBodyObject:IBodyObject = worldObject.bodyObjectById("enemy_1");

			var mainViewContainer:Sprite = new Sprite();
			addChild(mainViewContainer);

			var goSystem:IGOSystem = new GOSystem(new StarlingEnterFrameMechanism(1 / Starling.current.nativeStage.frameRate))
					.addGameObject(new GOSystemObject()
							.addComponent(new PhysWorldModel(space))
							.addComponent(camera = new Camera(mainViewContainer, 0.5)))
					.addGameObject(user = new HumanPrefab(userBodyObject, gafBundle, mainViewContainer)
							.addInput(new MouseInput(mainViewContainer, mouseToAction))
							.addInput(new KeyboardInput(stage, keysToAction)))
					.addGameObject(enemy = new HumanPrefab(enemyBodyObject, gafBundle, mainViewContainer))
					.addGameObject(new GOSystemObject()
							.addComponent(new PhysBodyObjectModel(floorBodyObject.body))
							.addComponent(new PhysBodyObjectFromDataView(mainViewContainer, floorBodyObject.data.shapeDataList, 0xFFCC00))
					);

			goSystem.addSignalListener(GOSystemSignalEnum.STEP, onGOSystemStep);

			goSystem.updateNow();

			camera.setFocusObject(user.skin);
			camera.setViewport(new Rectangle(0, 0, stage.stageWidth, stage.stageHeight));
		}

		private function onGOSystemStep(e:ISignalEvent):void
		{
			camera.setAimPosition(user.aimPosition.x, user.aimPosition.y);
		}
	}
}

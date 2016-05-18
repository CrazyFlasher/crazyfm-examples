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
	import com.crazyfm.devkit.physics.factories.CFPhysicsObjectFactory;
	import com.crazyfm.devkit.physics.factories.CFPhysicsVoFactory;
	import com.crazyfm.extension.goSystem.GOSystem;
	import com.crazyfm.extension.goSystem.GOSystemObject;
	import com.crazyfm.extension.goSystem.IGOSystem;
	import com.crazyfm.extensions.physics.IBodyObject;
	import com.crazyfm.extensions.physics.IWorldObject;
	import com.crazyfm.extensions.physics.WorldObject;
	import com.crazyfm.extensions.physics.vo.units.WorldDataVo;

	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.utils.ByteArray;

	import nape.space.Space;

	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;

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

		public function Main()
		{
			super();

			Starling.current.showStats = true;

			var worldData:WorldDataVo = new CFPhysicsVoFactory().parseWorld(JSON.parse((new WorldClass() as ByteArray).toString()));

			worldObject = new WorldObject(worldData, new CFPhysicsObjectFactory());

			addEventListener(Event.ADDED_TO_STAGE, added);
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
				new KeysToActionMapping(GameInputActionEnum.TOGGLE_RUN, null, new <uint>[Keyboard.CAPS_LOCK])
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

			var camera:ICamera;

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

			goSystem.updateNow();

			camera.setFocusObject(user.skin);
			camera.setViewport(new Rectangle(0, 0, stage.stageWidth, stage.stageHeight));
		}
	}
}

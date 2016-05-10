/**
 * Created by Anton Nefjodov on 21.03.2016.
 */
package com.crazy.thugLife
{
	import com.catalystapps.gaf.core.ZipToGAFAssetConverter;
	import com.catalystapps.gaf.data.GAFBundle;
	import com.crazy.thugLife.goSystem.components.input.GameInputActionEnum;
	import com.crazy.thugLife.goSystem.gameObjects.HumanGameObject;
	import com.crazy.thugLife.goSystem.gameObjects.IHumanGameObject;
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
	import com.crazyfm.extension.goSystem.GOSystem;
	import com.crazyfm.extension.goSystem.GOSystemObject;
	import com.crazyfm.extension.goSystem.IGOSystem;
	import com.crazyfm.extension.goSystem.IGOSystemObject;
	import com.crazyfm.extensions.physics.IBodyObject;
	import com.crazyfm.extensions.physics.IWorldObject;
	import com.crazyfm.extensions.physics.WorldObject;
	import com.crazyfm.extensions.physics.ns_ext_physics;
	import com.crazyfm.extensions.physics.utils.PhysicsParser;

	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.utils.ByteArray;

	import nape.space.Space;

	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;

	use namespace ns_ext_physics;

	public class Main extends Sprite
	{
		[Embed(source="../../../../resources/test.json", mimeType="application/octet-stream")]
		private var WorldClass:Class;

		[Embed(source="../../../../resources/test_assets.zip", mimeType="application/octet-stream")]
		private const BundleZip:Class;

		private var worldDataObject:IWorldObject;

		private var user:IHumanGameObject;

		private var gafBundle:GAFBundle;

		public function Main()
		{
			super();

			Starling.current.showStats = true;

			worldDataObject = new WorldObject()
				.setData(PhysicsParser.parseWorld(JSON.parse((new WorldClass() as ByteArray).toString())));

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

			var space:Space = worldDataObject.space;
			var floorBodyObject:IBodyObject = worldDataObject.bodyObjectById("ground");
			var userBodyObject:IBodyObject = worldDataObject.bodyObjectById("user");

			var mainViewContainer:Sprite = new Sprite();
			addChild(mainViewContainer);

			var camera:ICamera;

			var goSystem:IGOSystem = new GOSystem(new StarlingEnterFrameMechanism(1 / Starling.current.nativeStage.frameRate))
					.addGameObject(new GOSystemObject()
							.addComponent(new PhysWorldModel(space))
							.addComponent(camera = new Camera(mainViewContainer)))
					.addGameObject(user = new HumanGameObject(userBodyObject, gafBundle, mainViewContainer)
							.addInput(new MouseInput(mainViewContainer, mouseToAction))
							.addInput(new KeyboardInput(stage, keysToAction)))
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

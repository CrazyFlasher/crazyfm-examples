/**
 * Created by Anton Nefjodov on 21.03.2016.
 */
package com.crazy.thugLife
{
	import com.catalystapps.gaf.core.ZipToGAFAssetConverter;
	import com.catalystapps.gaf.data.GAFBundle;
	import com.crazy.thugLife.goSystem.gameObjects.Human;
	import com.crazyfm.devkit.goSystem.components.camera.Camera;
	import com.crazyfm.devkit.goSystem.components.camera.ICamera;
	import com.crazyfm.devkit.goSystem.components.physyics.model.PhysBodyObjectModel;
	import com.crazyfm.devkit.goSystem.components.physyics.model.PhysWorldModel;
	import com.crazyfm.devkit.goSystem.components.physyics.view.starling.PhysBodyObjectFromDataView;
	import com.crazyfm.devkit.goSystem.mechanisms.StarlingEnterFrameMechanism;
	import com.crazyfm.extension.goSystem.GOSystem;
	import com.crazyfm.extension.goSystem.GOSystemObject;
	import com.crazyfm.extension.goSystem.IGOSystem;
	import com.crazyfm.extensions.physics.IBodyObject;
	import com.crazyfm.extensions.physics.IWorldObject;
	import com.crazyfm.extensions.physics.WorldObject;
	import com.crazyfm.extensions.physics.ns_ext_physics;
	import com.crazyfm.extensions.physics.utils.PhysicsParser;

	import flash.display.Sprite;
	import flash.geom.Rectangle;
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

		private var user:Human;

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
			var space:Space = worldDataObject.space;
			var floorBodyObject:IBodyObject = worldDataObject.bodyObjectById("ground");
			var userBodyObject:IBodyObject = worldDataObject.bodyObjectById("user");

			var debugViewSprite:flash.display.Sprite = new flash.display.Sprite();
			debugViewSprite.alpha = 0.5;
			Starling.current.nativeOverlay.addChild(debugViewSprite);

			var mainViewContainer:Sprite = new Sprite();
			addChild(mainViewContainer);

			var camera:ICamera;

			var goSystem:IGOSystem = new GOSystem(new StarlingEnterFrameMechanism(1 / Starling.current.nativeStage.frameRate))
					.addGameObject(new GOSystemObject()
							.addComponent(new PhysWorldModel(space))
							.addComponent(camera = new Camera(mainViewContainer)))
					.addGameObject(user = new Human(userBodyObject, gafBundle, mainViewContainer))
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

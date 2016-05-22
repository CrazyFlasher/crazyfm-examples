/**
 * Created by Anton Nefjodov on 21.03.2016.
 */
package com.crazy.thugLife
{
	import com.catalystapps.gaf.core.ZipToGAFAssetConverter;
	import com.catalystapps.gaf.data.GAFBundle;
	import com.crazy.thugLife.enums.GameInputActionEnum;
	import com.crazy.thugLife.goSystem.components.controllable.Aimable;
	import com.crazy.thugLife.goSystem.components.controllable.Armed;
	import com.crazy.thugLife.goSystem.components.controllable.Climbable;
	import com.crazy.thugLife.goSystem.components.controllable.IAimable;
	import com.crazy.thugLife.goSystem.components.controllable.IArmed;
	import com.crazy.thugLife.goSystem.components.controllable.IClimbable;
	import com.crazy.thugLife.goSystem.components.controllable.IJumpable;
	import com.crazy.thugLife.goSystem.components.controllable.IMovable;
	import com.crazy.thugLife.goSystem.components.controllable.IRotatable;
	import com.crazy.thugLife.goSystem.components.controllable.Jumpable;
	import com.crazy.thugLife.goSystem.components.controllable.Movable;
	import com.crazy.thugLife.goSystem.components.controllable.Rotatable;
	import com.crazy.thugLife.goSystem.prefabs.HumanPrefab;
	import com.crazy.thugLife.goSystem.prefabs.IHumanPrefab;
	import com.crazyfm.core.common.ns_app_factory;
	import com.crazyfm.core.factory.AppFactory;
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.devkit.goSystem.components.camera.Camera;
	import com.crazyfm.devkit.goSystem.components.camera.ICamera;
	import com.crazyfm.devkit.goSystem.components.input.AbstractInputActionVo;
	import com.crazyfm.devkit.goSystem.components.input.keyboard.KeyboardInput;
	import com.crazyfm.devkit.goSystem.components.input.keyboard.KeysToActionMapping;
	import com.crazyfm.devkit.goSystem.components.input.mouse.MouseActionVo;
	import com.crazyfm.devkit.goSystem.components.input.mouse.MouseInput;
	import com.crazyfm.devkit.goSystem.components.input.mouse.MouseToActionMapping;
	import com.crazyfm.devkit.goSystem.components.physyics.model.IInteractivePhysObjectModel;
	import com.crazyfm.devkit.goSystem.components.physyics.model.IPhysBodyObjectModel;
	import com.crazyfm.devkit.goSystem.components.physyics.model.IPhysWorldModel;
	import com.crazyfm.devkit.goSystem.components.physyics.model.InteractivePhysObjectModel;
	import com.crazyfm.devkit.goSystem.components.physyics.model.PhysBodyObjectModel;
	import com.crazyfm.devkit.goSystem.components.physyics.model.PhysWorldModel;
	import com.crazyfm.devkit.goSystem.components.physyics.view.starling.PhysBodyObjectFromDataView;
	import com.crazyfm.devkit.goSystem.mechanisms.StarlingEnterFrameMechanism;
	import com.crazyfm.devkit.physics.CFBodyObject;
	import com.crazyfm.devkit.physics.CFShapeObject;
	import com.crazyfm.devkit.physics.vo.units.CFShapeDataVo;
	import com.crazyfm.extension.goSystem.GOSystem;
	import com.crazyfm.extension.goSystem.GOSystemObject;
	import com.crazyfm.extension.goSystem.IGOSystem;
	import com.crazyfm.extension.goSystem.IGOSystemMechanism;
	import com.crazyfm.extension.goSystem.IGOSystemObject;
	import com.crazyfm.extension.goSystem.events.GOSystemSignalEnum;
	import com.crazyfm.extensions.physics.IBodyObject;
	import com.crazyfm.extensions.physics.IJointObject;
	import com.crazyfm.extensions.physics.IShapeObject;
	import com.crazyfm.extensions.physics.IVertexObject;
	import com.crazyfm.extensions.physics.IWorldObject;
	import com.crazyfm.extensions.physics.JointObject;
	import com.crazyfm.extensions.physics.VertexObject;
	import com.crazyfm.extensions.physics.WorldObject;
	import com.crazyfm.extensions.physics.vo.units.ShapeDataVo;
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

			init();
		}

		private function init():void
		{
			Starling.current.showStats = true;

			AppFactory.getSingletonInstance()
				.registerPool(AbstractInputActionVo, 5)
				.registerPool(MouseActionVo, 1)

				.map(ShapeDataVo, CFShapeDataVo)
				.map(IWorldObject, WorldObject)
				.map(IBodyObject, CFBodyObject)
				.map(IShapeObject, CFShapeObject)
				.map(IJointObject, JointObject)
				.map(IVertexObject, VertexObject)

				.map(IHumanPrefab, HumanPrefab)
				.map(ICamera, Camera)
				.map(IPhysWorldModel, PhysWorldModel)

				.map(IGOSystem, GOSystem)
				.map(IGOSystemMechanism, StarlingEnterFrameMechanism)
				.map(IGOSystemObject, GOSystemObject)

				.map(IPhysBodyObjectModel, PhysBodyObjectModel)
				.map(IInteractivePhysObjectModel, InteractivePhysObjectModel)

				.map(IMovable, Movable)
				.map(IJumpable, Jumpable)
				.map(IClimbable, Climbable)
				.map(IRotatable, Rotatable)
				.map(IAimable, Aimable)
				.map(IArmed, Armed)
			;

			var worldData:WorldDataVo = getInstance(WorldDataVo, JSON.parse((new WorldClass() as ByteArray).toString()));

			worldObject = getInstance(WorldObject, worldData);

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
				new KeysToActionMapping(GameInputActionEnum.MOVE_LEFT, new <uint>[Keyboard.A]),
				new KeysToActionMapping(GameInputActionEnum.RUN_LEFT, new <uint>[Keyboard.LEFT, Keyboard.SHIFT]),
				new KeysToActionMapping(GameInputActionEnum.RUN_LEFT, new <uint>[Keyboard.A, Keyboard.SHIFT]),
				new KeysToActionMapping(GameInputActionEnum.MOVE_RIGHT, new <uint>[Keyboard.RIGHT]),
				new KeysToActionMapping(GameInputActionEnum.MOVE_RIGHT, new <uint>[Keyboard.D]),
				new KeysToActionMapping(GameInputActionEnum.RUN_RIGHT, new <uint>[Keyboard.RIGHT, Keyboard.SHIFT]),
				new KeysToActionMapping(GameInputActionEnum.RUN_RIGHT, new <uint>[Keyboard.D, Keyboard.SHIFT]),
				new KeysToActionMapping(GameInputActionEnum.MOVE_UP, new <uint>[Keyboard.UP]),
				new KeysToActionMapping(GameInputActionEnum.MOVE_UP, new <uint>[Keyboard.W]),
				new KeysToActionMapping(GameInputActionEnum.MOVE_DOWN, new <uint>[Keyboard.DOWN]),
				new KeysToActionMapping(GameInputActionEnum.MOVE_DOWN, new <uint>[Keyboard.S]),
				new KeysToActionMapping(GameInputActionEnum.STOP_HORIZONTAL, null, new <uint>[Keyboard.LEFT, Keyboard.RIGHT]),
				new KeysToActionMapping(GameInputActionEnum.STOP_HORIZONTAL, null, new <uint>[Keyboard.A, Keyboard.D]),
				new KeysToActionMapping(GameInputActionEnum.STOP_VERTICAL, null, new <uint>[Keyboard.UP, Keyboard.DOWN]),
				new KeysToActionMapping(GameInputActionEnum.STOP_VERTICAL, null, new <uint>[Keyboard.W, Keyboard.S]),
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

			var goSystem:IGOSystem =
					(getInstance(IGOSystem, getInstance(IGOSystemMechanism, 1 / Starling.current.nativeStage.frameRate)) as IGOSystem)
					.addGameObject((getInstance(IGOSystemObject) as IGOSystemObject)
							.addComponent(getInstance(IPhysWorldModel, space))
							.addComponent(camera = getInstance(ICamera, mainViewContainer, 0.5)))
					.addGameObject((user = getInstance(IHumanPrefab, userBodyObject, gafBundle, mainViewContainer) as IHumanPrefab)
							.addInput(getInstance(MouseInput, mainViewContainer, mouseToAction))
							.addInput(getInstance(KeyboardInput, stage, keysToAction)))
					.addGameObject(enemy = getInstance(IHumanPrefab, enemyBodyObject, gafBundle, mainViewContainer))
					.addGameObject((getInstance(IGOSystemObject) as IGOSystemObject)
							.addComponent(getInstance(IPhysBodyObjectModel, floorBodyObject.body))
							.addComponent(getInstance(PhysBodyObjectFromDataView, mainViewContainer, floorBodyObject.data.shapeDataList, 0xFFCC00))
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

/**
 * Created by Anton Nefjodov on 21.03.2016.
 */
package com.crazy.thugLife.game.contexts
{
	import com.catalystapps.gaf.core.ZipToGAFAssetConverter;
	import com.catalystapps.gaf.data.GAFBundle;
	import com.crazy.thugLife.game.enums.GameInputActionEnum;
	import com.crazy.thugLife.game.gearSys.components.controllable.Aimable;
	import com.crazy.thugLife.game.gearSys.components.controllable.Armed;
	import com.crazy.thugLife.game.gearSys.components.controllable.Climbable;
	import com.crazy.thugLife.game.gearSys.components.controllable.IAimable;
	import com.crazy.thugLife.game.gearSys.components.controllable.IArmed;
	import com.crazy.thugLife.game.gearSys.components.controllable.IClimbable;
	import com.crazy.thugLife.game.gearSys.components.controllable.IJumpable;
	import com.crazy.thugLife.game.gearSys.components.controllable.IMovable;
	import com.crazy.thugLife.game.gearSys.components.controllable.IRotatable;
	import com.crazy.thugLife.game.gearSys.components.controllable.Jumpable;
	import com.crazy.thugLife.game.gearSys.components.controllable.Movable;
	import com.crazy.thugLife.game.gearSys.components.controllable.Rotatable;
	import com.crazy.thugLife.game.gearSys.prefabs.HumanPrefab;
	import com.crazy.thugLife.game.gearSys.prefabs.IHumanPrefab;
	import com.crazyfm.core.factory.IAppFactory;
	import com.crazyfm.core.mvc.context.AbstractContext;
	import com.crazyfm.core.mvc.message.IMessage;
	import com.crazyfm.devkit.gearSys.components.camera.Camera;
	import com.crazyfm.devkit.gearSys.components.camera.ICamera;
	import com.crazyfm.devkit.gearSys.components.input.AbstractInputActionVo;
	import com.crazyfm.devkit.gearSys.components.input.keyboard.KeyboardInput;
	import com.crazyfm.devkit.gearSys.components.input.keyboard.KeysToActionMapping;
	import com.crazyfm.devkit.gearSys.components.input.mouse.MouseActionVo;
	import com.crazyfm.devkit.gearSys.components.input.mouse.MouseInput;
	import com.crazyfm.devkit.gearSys.components.input.mouse.MouseToActionMapping;
	import com.crazyfm.devkit.gearSys.components.physyics.model.IInteractivePhysObjectModel;
	import com.crazyfm.devkit.gearSys.components.physyics.model.IPhysBodyObjectModel;
	import com.crazyfm.devkit.gearSys.components.physyics.model.IPhysWorldModel;
	import com.crazyfm.devkit.gearSys.components.physyics.model.InteractivePhysObjectModel;
	import com.crazyfm.devkit.gearSys.components.physyics.model.PhysBodyObjectModel;
	import com.crazyfm.devkit.gearSys.components.physyics.model.PhysWorldModel;
	import com.crazyfm.devkit.gearSys.components.physyics.view.starling.PhysBodyObjectFromDataView;
	import com.crazyfm.devkit.gearSys.mechanisms.StarlingEnterFrameMechanism;
	import com.crazyfm.devkit.gearSys.mechanisms.StarlingJugglerMechanism;
	import com.crazyfm.devkit.gearSys.mechanisms.StarlingTimerMechanism;
	import com.crazyfm.devkit.physics.CFBodyObject;
	import com.crazyfm.devkit.physics.CFShapeObject;
	import com.crazyfm.devkit.physics.vo.units.CFShapeDataVo;
	import com.crazyfm.extension.gearSys.GearSys;
	import com.crazyfm.extension.gearSys.GearSysObject;
	import com.crazyfm.extension.gearSys.IGearSys;
	import com.crazyfm.extension.gearSys.IGearSysMechanism;
	import com.crazyfm.extension.gearSys.IGearSysObject;
	import com.crazyfm.extension.gearSys.mechanisms.EnterFrameMechanism;
	import com.crazyfm.extension.gearSys.messages.GearSysMessageEnum;
	import com.crazyfm.extensions.physics.IBodyObject;
	import com.crazyfm.extensions.physics.IJointObject;
	import com.crazyfm.extensions.physics.IShapeObject;
	import com.crazyfm.extensions.physics.IVertexObject;
	import com.crazyfm.extensions.physics.IWorldObject;
	import com.crazyfm.extensions.physics.JointObject;
	import com.crazyfm.extensions.physics.VertexObject;
	import com.crazyfm.extensions.physics.WorldObject;
	import com.crazyfm.extensions.physics.factory.PhysFactory;
	import com.crazyfm.extensions.physics.vo.units.ShapeDataVo;
	import com.crazyfm.extensions.physics.vo.units.WorldDataVo;

	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.utils.ByteArray;

	import nape.space.Space;

	import starling.animation.Juggler;

	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.display.Stage;

	public class GameContext extends AbstractContext implements IGameContext
	{
		[Embed(source="../../../../../../resources/test.json", mimeType="application/octet-stream")]
		private var WorldClass:Class;

		[Embed(source="../../../../../../resources/test_assets.zip", mimeType="application/octet-stream")]
		private const BundleZip:Class;

		[Autowired]
		public var viewContainer:DisplayObjectContainer;

		private var gameViewContainer:Sprite;

		private var gearSys:IGearSys;

		private var worldObject:IWorldObject;

		private var user:IHumanPrefab;
		private var enemy:IHumanPrefab;

		private var gafBundle:GAFBundle;

		private var camera:ICamera;

		public function GameContext(factory:IAppFactory)
		{
			super(factory);
		}

		[PostConstruct]
		public function init():void
		{
			PhysFactory.instance = factory;

			factory
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

					.map(IGearSys, GearSys)
//					.map(IGearSysMechanism, StarlingJugglerMechanism)
					.map(IGearSysMechanism, EnterFrameMechanism)
					.map(IGearSysObject, GearSysObject)

					.map(IPhysBodyObjectModel, PhysBodyObjectModel)
					.map(IInteractivePhysObjectModel, InteractivePhysObjectModel)

					.map(IMovable, Movable)
					.map(IJumpable, Jumpable)
					.map(IClimbable, Climbable)
					.map(IRotatable, Rotatable)
					.map(IAimable, Aimable)
					.map(IArmed, Armed)

					.map(IAppFactory, factory)
					.map(Juggler, Starling.juggler)
			;

			var worldData:WorldDataVo = factory.getInstance(WorldDataVo, [JSON.parse((new WorldClass() as ByteArray).toString())]);

			worldObject = factory.getInstance(WorldObject, [worldData]);

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

			gameViewContainer = new Sprite();
			gameViewContainer.touchable = false;
			viewContainer.addChild(gameViewContainer);

			factory.map(DisplayObjectContainer, gameViewContainer);
			factory.map(GAFBundle, gafBundle);
			factory.map(Stage, viewContainer.stage);

			var mechanism:IGearSysMechanism = factory.getInstance(IGearSysMechanism, [1 / Starling.current.nativeStage.frameRate]) as IGearSysMechanism;
			camera = factory.getInstance(ICamera, [0.5]) as ICamera;
			user = factory.getInstance(IHumanPrefab, [userBodyObject]) as IHumanPrefab;
			enemy = factory.getInstance(IHumanPrefab, [enemyBodyObject]) as IHumanPrefab;

			gearSys = (factory.getInstance(IGearSys, [mechanism]) as IGearSys)
				.addGameObject((factory.getInstance(IGearSysObject) as IGearSysObject)
					.addComponent(factory.getInstance(IPhysWorldModel, [space]))
					.addComponent(camera))
				.addGameObject(user
					.addInput(factory.getInstance(MouseInput, [mouseToAction]))
					.addInput(factory.getInstance(KeyboardInput, [keysToAction])))
				.addGameObject(enemy)
				.addGameObject((factory.getInstance(IGearSysObject) as IGearSysObject)
					.addComponent(factory.getInstance(IPhysBodyObjectModel, [floorBodyObject.body]))
					.addComponent(factory.getInstance(PhysBodyObjectFromDataView, [floorBodyObject.data.shapeDataList, 0xFFCC00]))
				);

			gearSys.addMessageListener(GearSysMessageEnum.STEP, onGearSystemStep);

			gearSys.updateNow();

			camera.setFocusObject(user.skin);
			camera.setViewport(new Rectangle(0, 0, viewContainer.stage.stageWidth, viewContainer.stage.stageHeight));
			camera.updateViewContainerBounds();
		}

		private function onGearSystemStep(message:IMessage):void
		{
			camera.setAimPosition(user.aimPosition.x, user.aimPosition.y);
		}

		override public function dispose():void
		{
			factory.dispose();
			gearSys.disposeWithAllChildren();
			camera.dispose();
			worldObject.dispose();
			gafBundle.dispose();
			gameViewContainer.removeFromParent(true);

			super.dispose();
		}
	}
}

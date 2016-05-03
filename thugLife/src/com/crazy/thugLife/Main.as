/**
 * Created by Anton Nefjodov on 21.03.2016.
 */
package com.crazy.thugLife
{
	import com.crazy.thugLife.goSystem.components.controllable.Aimable;
	import com.crazy.thugLife.goSystem.components.controllable.Climbable;
	import com.crazy.thugLife.goSystem.components.controllable.Jumpable;
	import com.crazy.thugLife.goSystem.components.controllable.Movable;
	import com.crazy.thugLife.goSystem.components.input.GameInputActionEnum;
	import com.crazyfm.devkit.goSystem.components.camera.Camera;
	import com.crazyfm.devkit.goSystem.components.camera.ICamera;
	import com.crazyfm.devkit.goSystem.components.input.keyboard.KeyboardInput;
	import com.crazyfm.devkit.goSystem.components.input.keyboard.KeysToActionMapping;
	import com.crazyfm.devkit.goSystem.components.input.mouse.MouseInput;
	import com.crazyfm.devkit.goSystem.components.input.mouse.MouseToActionMapping;
	import com.crazyfm.devkit.goSystem.components.physyics.model.InteractivePhysObjectModel;
	import com.crazyfm.devkit.goSystem.components.physyics.model.PhysBodyObjectModel;
	import com.crazyfm.devkit.goSystem.components.physyics.model.PhysWorldModel;
	import com.crazyfm.devkit.goSystem.components.physyics.view.IPhysBodyObjectView;
	import com.crazyfm.devkit.goSystem.components.physyics.view.starling.PhysBodyObjectFromDataView;
	import com.crazyfm.devkit.goSystem.mechanisms.StarlingEnterFrameMechanism;
	import com.crazyfm.extension.goSystem.GOSystem;
	import com.crazyfm.extension.goSystem.GameObject;
	import com.crazyfm.extension.goSystem.IGOSystem;
	import com.crazyfm.extension.goSystem.IGameObject;
	import com.crazyfm.extensions.physics.IBodyObject;
	import com.crazyfm.extensions.physics.IWorldObject;
	import com.crazyfm.extensions.physics.WorldObject;
	import com.crazyfm.extensions.physics.utils.PhysicsParser;

	import flash.display.Sprite;
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

		private var worldDataObject:IWorldObject;

		private var goSystem:IGOSystem;

		private var main:IGameObject;
		private var floor:IGameObject;
		private var user:IGameObject;

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
			var floorBodyObject:IBodyObject = worldDataObject.bodyObjectById("ground");
			var userBodyObject:IBodyObject = worldDataObject.bodyObjectById("user");

			var debugViewSprite:flash.display.Sprite = new flash.display.Sprite();
			debugViewSprite.alpha = 0.5;
			Starling.current.nativeOverlay.addChild(debugViewSprite);

			var mainViewContainer:Sprite = new Sprite();
			addChild(mainViewContainer);

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
					new MouseToActionMapping(GameInputActionEnum.AIM, false, false, true)
			];

			goSystem = new GOSystem(new StarlingEnterFrameMechanism(1 / Starling.current.nativeStage.frameRate))
					.addGameObject(main = new GameObject()
							.addComponent(new PhysWorldModel(space))
							.addComponent(camera = new Camera(mainViewContainer)))
					.addGameObject(user = new GameObject()
							.addComponent(new InteractivePhysObjectModel(userBodyObject.body))
							.addComponent(new Jumpable(300))
							.addComponent(new Climbable(100))
							.addComponent(new Movable(75))
							.addComponent(new Aimable())
							.addComponent(new MouseInput(stage, mouseToAction))
							.addComponent(new KeyboardInput(stage, keysToAction))
							.addComponent(userSkin = new PhysBodyObjectFromDataView(mainViewContainer, userBodyObject.data.shapeDataList, 0x00CC00)))
					.addGameObject(floor = new GameObject()
							.addComponent(new PhysBodyObjectModel(floorBodyObject.body))
							.addComponent(new PhysBodyObjectFromDataView(mainViewContainer, floorBodyObject.data.shapeDataList, 0xFFCC00))
					);

			goSystem.updateNow();

			camera.setFocusObject(userSkin.skin);
			camera.setViewport(new Rectangle(0, 0, stage.stageWidth, stage.stageHeight));
		}
	}
}

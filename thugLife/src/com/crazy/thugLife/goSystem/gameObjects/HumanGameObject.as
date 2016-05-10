/**
 * Created by Anton Nefjodov on 10.05.2016.
 */
package com.crazy.thugLife.goSystem.gameObjects
{
	import com.catalystapps.gaf.data.GAFBundle;
	import com.catalystapps.gaf.display.GAFMovieClip;
	import com.crazy.thugLife.goSystem.components.controllable.Aimable;
	import com.crazy.thugLife.goSystem.components.controllable.Climbable;
	import com.crazy.thugLife.goSystem.components.controllable.IAimable;
	import com.crazy.thugLife.goSystem.components.controllable.IClimbable;
	import com.crazy.thugLife.goSystem.components.controllable.IJumpable;
	import com.crazy.thugLife.goSystem.components.controllable.IMovable;
	import com.crazy.thugLife.goSystem.components.controllable.IRotatable;
	import com.crazy.thugLife.goSystem.components.controllable.Jumpable;
	import com.crazy.thugLife.goSystem.components.controllable.Movable;
	import com.crazy.thugLife.goSystem.components.controllable.Rotatable;
	import com.crazy.thugLife.goSystem.components.input.GameInputActionEnum;
	import com.crazy.thugLife.goSystem.components.view.GameCharacterView;
	import com.crazy.thugLife.goSystem.components.view.RayView;
	import com.crazyfm.devkit.goSystem.components.input.keyboard.KeyboardInput;
	import com.crazyfm.devkit.goSystem.components.input.keyboard.KeysToActionMapping;
	import com.crazyfm.devkit.goSystem.components.input.mouse.MouseInput;
	import com.crazyfm.devkit.goSystem.components.input.mouse.MouseToActionMapping;
	import com.crazyfm.devkit.goSystem.components.physyics.model.InteractivePhysObjectModel;
	import com.crazyfm.devkit.goSystem.components.physyics.view.IPhysBodyObjectView;
	import com.crazyfm.extension.goSystem.GOSystemObject;
	import com.crazyfm.extensions.physics.IBodyObject;

	import flash.geom.Point;
	import flash.ui.Keyboard;

	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;

	public class HumanGameObject extends GOSystemObject
	{
		private var bodyObject:IBodyObject;
		private var gafBundle:GAFBundle;
		private var mainViewContainer:DisplayObjectContainer;

		private var userSkin:IPhysBodyObjectView;

		public function HumanGameObject(bodyObject:IBodyObject, gafBundle:GAFBundle, mainViewContainer:DisplayObjectContainer)
		{
			super();

			this.bodyObject = bodyObject;
			this.gafBundle = gafBundle;
			this.mainViewContainer = mainViewContainer;

			configure();
		}

		private function configure():void
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

			var movable:IMovable;
			var jumpable:IJumpable;
			var climbable:IClimbable;
			var aimable:IAimable;
			var rotatable:IRotatable;

			addComponent(new InteractivePhysObjectModel(bodyObject.body));
			addComponent(jumpable = new Jumpable(300));
			addComponent(climbable = new Climbable(100));
			addComponent(movable = new Movable(75));
			addComponent(aimable = new Aimable(new Point(0, -18), 30));
			addComponent(rotatable = new Rotatable());
			addComponent(new MouseInput(mainViewContainer, mouseToAction));
			addComponent(new KeyboardInput(mainViewContainer.stage, keysToAction));
//			addComponent(new PhysBodyObjectFromDataView(mainViewContainer, userBodyObject.data.shapeDataList, 0x00CC00))
			addComponent(new RayView(mainViewContainer, aimable));
			addComponent(userSkin = new GameCharacterView(mainViewContainer,
					new GAFMovieClip(gafBundle.getGAFTimeline("test_assets", "human")),
					movable, jumpable, climbable, aimable, rotatable));
		}

		public function get skin():DisplayObject
		{
			return userSkin.skin;
		}
	}
}

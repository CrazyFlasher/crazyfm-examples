/**
 * Created by Anton Nefjodov on 10.05.2016.
 */
package com.crazy.thugLife.game.gearSys.prefabs
{
	import com.catalystapps.gaf.data.GAFBundle;
	import com.catalystapps.gaf.display.GAFMovieClip;
	import com.crazy.thugLife.common.enums.WeaponEnum;
	import com.crazy.thugLife.game.gearSys.components.controllable.IAimable;
	import com.crazy.thugLife.game.gearSys.components.controllable.IArmed;
	import com.crazy.thugLife.game.gearSys.components.controllable.IClimbable;
	import com.crazy.thugLife.game.gearSys.components.controllable.IJumpable;
	import com.crazy.thugLife.game.gearSys.components.controllable.IMovable;
	import com.crazy.thugLife.game.gearSys.components.controllable.IRotatable;
	import com.crazy.thugLife.game.gearSys.components.view.GameCharacterView;
	import com.crazy.thugLife.game.gearSys.components.view.RayView;
	import com.crazyfm.core.factory.IAppFactory;
	import com.crazyfm.devkit.gearSys.components.input.IInput;
	import com.crazyfm.devkit.gearSys.components.physyics.model.IInteractivePhysObjectModel;
	import com.crazyfm.devkit.gearSys.components.physyics.view.IPhysBodyObjectView;
	import com.crazyfm.extension.gearSys.GearSysObject;
	import com.crazyfm.extensions.physics.IBodyObject;

	import nape.geom.Vec2;
	import nape.phys.Body;

	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;

	public class HumanPrefab extends GearSysObject implements IHumanPrefab
	{
		[Autowired]
		public var gafBundle:GAFBundle;

		[Autowired]
		public var factory:IAppFactory;

		[Autowired]
		public var bodyDataObject:IBodyObject;

		private var userSkin:IPhysBodyObjectView;
		private var armed:IArmed;
		private var physObj:IInteractivePhysObjectModel;

		public function HumanPrefab()
		{
			super();
		}

		[PostConstruct]
		public function configureComponents():void
		{
			addComponent(physObj = factory.mapToValue(Body, bodyDataObject.body).getInstance(IInteractivePhysObjectModel));
			addComponent(armed = factory.getInstance(IArmed)
				.setCurrentWeapon(WeaponEnum.PISTOL));
			addComponent(factory.getInstance(IJumpable, [300]));
			addComponent(factory.getInstance(IClimbable, [100]));
			addComponent(factory.getInstance(IMovable, [75]));
			addComponent(factory.getInstance(IRotatable));
//			addComponent(factory.getInstance(PhysBodyObjectFromDataView, mainViewContainer, bodyObject.data.shapeDataList, 0x00CC00));
			addComponent(factory.getInstance(RayView));
			addComponent(userSkin = factory.getInstance(GameCharacterView, [new GAFMovieClip(gafBundle.getGAFTimeline("test_assets", "human"))]));
		}

		public function get skin():DisplayObject
		{
			return userSkin.skin;
		}

		public function addInput(value:IInput):IHumanPrefab
		{
			addComponent(value/*, 0*/);

			return this;
		}

		public function get aimPosition():Vec2
		{
			return armed ? armed.aimPosition : physObj.worldCenterOfMass;
		}
	}
}

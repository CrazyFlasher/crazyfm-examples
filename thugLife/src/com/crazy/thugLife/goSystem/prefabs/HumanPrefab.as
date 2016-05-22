/**
 * Created by Anton Nefjodov on 10.05.2016.
 */
package com.crazy.thugLife.goSystem.prefabs
{
	import com.catalystapps.gaf.data.GAFBundle;
	import com.catalystapps.gaf.display.GAFMovieClip;
	import com.crazy.thugLife.enums.WeaponEnum;
	import com.crazy.thugLife.goSystem.components.controllable.IArmed;
	import com.crazy.thugLife.goSystem.components.controllable.IClimbable;
	import com.crazy.thugLife.goSystem.components.controllable.IJumpable;
	import com.crazy.thugLife.goSystem.components.controllable.IMovable;
	import com.crazy.thugLife.goSystem.components.controllable.IRotatable;
	import com.crazy.thugLife.goSystem.components.view.GameCharacterView;
	import com.crazy.thugLife.goSystem.components.view.RayView;
	import com.crazyfm.devkit.goSystem.components.input.IInput;
	import com.crazyfm.devkit.goSystem.components.physyics.model.IInteractivePhysObjectModel;
	import com.crazyfm.devkit.goSystem.components.physyics.view.IPhysBodyObjectView;
	import com.crazyfm.extension.goSystem.GOSystemObject;
	import com.crazyfm.extensions.physics.IBodyObject;

	import nape.geom.Vec2;

	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;

	public class HumanPrefab extends GOSystemObject implements IHumanPrefab
	{
		private var bodyObject:IBodyObject;
		private var gafBundle:GAFBundle;
		private var mainViewContainer:DisplayObjectContainer;

		private var userSkin:IPhysBodyObjectView;
		private var armed:IArmed;

		public function HumanPrefab(bodyObject:IBodyObject, gafBundle:GAFBundle, mainViewContainer:DisplayObjectContainer)
		{
			super();

			this.bodyObject = bodyObject;
			this.gafBundle = gafBundle;
			this.mainViewContainer = mainViewContainer;

			configureComponents();
		}

		private function configureComponents():void
		{
			addComponent(getInstance(IInteractivePhysObjectModel, bodyObject.body));
			addComponent(armed = (getInstance(IArmed) as IArmed)
				.setCurrentWeapon(WeaponEnum.HOLSTER));
			addComponent(getInstance(IJumpable, 300));
			addComponent(getInstance(IClimbable, 100));
			addComponent(getInstance(IMovable, 75));
			addComponent(getInstance(IRotatable));
//			addComponent(getInstance(PhysBodyObjectFromDataView, mainViewContainer, bodyObject.data.shapeDataList, 0x00CC00));
			addComponent(getInstance(RayView, mainViewContainer));
			addComponent(userSkin = getInstance(GameCharacterView, mainViewContainer,
					new GAFMovieClip(gafBundle.getGAFTimeline("test_assets", "human"))));
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
			return armed.aimPosition;
		}
	}
}

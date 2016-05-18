/**
 * Created by Anton Nefjodov on 10.05.2016.
 */
package com.crazy.thugLife.goSystem.prefabs
{
	import com.catalystapps.gaf.data.GAFBundle;
	import com.catalystapps.gaf.display.GAFMovieClip;
	import com.crazy.thugLife.enums.WeaponEnum;
	import com.crazy.thugLife.goSystem.components.controllable.Aimable;
	import com.crazy.thugLife.goSystem.components.controllable.Armed;
	import com.crazy.thugLife.goSystem.components.controllable.Climbable;
	import com.crazy.thugLife.goSystem.components.controllable.Jumpable;
	import com.crazy.thugLife.goSystem.components.controllable.Movable;
	import com.crazy.thugLife.goSystem.components.controllable.Rotatable;
	import com.crazy.thugLife.goSystem.components.view.GameCharacterView;
	import com.crazy.thugLife.goSystem.components.view.RayView;
	import com.crazyfm.devkit.goSystem.components.input.IInput;
	import com.crazyfm.devkit.goSystem.components.physyics.model.InteractivePhysObjectModel;
	import com.crazyfm.devkit.goSystem.components.physyics.view.IPhysBodyObjectView;
	import com.crazyfm.extension.goSystem.GOSystemObject;
	import com.crazyfm.extensions.physics.IBodyObject;

	import flash.geom.Point;

	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;

	public class HumanPrefab extends GOSystemObject implements IHumanPrefab
	{
		private var bodyObject:IBodyObject;
		private var gafBundle:GAFBundle;
		private var mainViewContainer:DisplayObjectContainer;

		private var userSkin:IPhysBodyObjectView;

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
			addComponent(new InteractivePhysObjectModel(bodyObject.body));
			addComponent(new Armed()
				.setCurrentWeapon(WeaponEnum.PISTOL));
			addComponent(new Jumpable(300));
			addComponent(new Climbable(100));
			addComponent(new Movable(75));
			addComponent(new Aimable()
				.setAimBeginPosition(new Point(0, -18), 30));
			addComponent(new Rotatable());
//			addComponent(new PhysBodyObjectFromDataView(mainViewContainer, bodyObject.data.shapeDataList, 0x00CC00));
			addComponent(new RayView(mainViewContainer));
			addComponent(userSkin = new GameCharacterView(mainViewContainer,
					new GAFMovieClip(gafBundle.getGAFTimeline("test_assets", "human"))));
		}

		public function get skin():DisplayObject
		{
			return userSkin.skin;
		}

		public function addInput(value:IInput):IHumanPrefab
		{
			addComponent(value, 0);

			return this;
		}
	}
}

/**
 * Created by Anton Nefjodov on 21.03.2016.
 */
package
{
	import com.crazyfm.extension.goSystem.GOSystem;
	import com.crazyfm.extension.goSystem.GameObject;
	import com.crazyfm.extension.goSystem.IGOSystem;
	import com.crazyfm.extensions.physics.IWorldObject;
	import com.crazyfm.extensions.physics.WorldObject;
	import com.crazyfm.extensions.physics.utils.PhysicsParser;

	import components.BallViewComponent;
	import components.PhysObjectComponent;
	import components.PhysWorldComponent;

	import flash.utils.ByteArray;

	import starling.core.Starling;
	import starling.display.Sprite;

	public class Main extends Sprite
	{
		[Embed(source="../resources/test.json", mimeType="application/octet-stream")]
		private var WorldClass:Class;

		private var world:IWorldObject;

		private var goSystem:IGOSystem;

		public function Main()
		{
			super();

			world = new WorldObject();
			world.data = PhysicsParser.parseWorld(JSON.parse((new WorldClass() as ByteArray).toString()));

			goSystem = new GOSystem()
					.setJuggler(Starling.juggler)
					.addGameObject(new GameObject()
										   .addComponent(new PhysWorldComponent()))
					.addGameObject(new GameObject()
										   .addComponent(new PhysObjectComponent().setBody(world.bodyObjectById("ball").body))
										   .addComponent(new BallViewComponent()
																 .setViewContainer(this)));
		}
	}
}

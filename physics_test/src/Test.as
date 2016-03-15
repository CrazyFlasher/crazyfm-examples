/**
 * Created by Anton Nefjodov on 14.03.2016.
 */
package
{
	import com.crazyfm.extensions.physics.IWorldObject;
	import com.crazyfm.extensions.physics.WorldObject;
	import com.crazyfm.extensions.physics.utils.PhysicsParser;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.ByteArray;

	import nape.util.BitmapDebug;
	import nape.util.Debug;

	[SWF(width="550", height="400", frameRate="60", backgroundColor="#000000")]

	public class Test extends Sprite
	{

		[Embed(source="../resources/test.json", mimeType="application/octet-stream")]
		private var WorldClass:Class;

		private var world:IWorldObject;

		private var debug:Debug;

		public function Test()
		{
			super();

			init();
		}

		private function init():void
		{
			world = new WorldObject();
			world.data = PhysicsParser.parseWorld(JSON.parse((new WorldClass() as ByteArray).toString()));

			createDebugDraw();

			addEventListener(Event.ENTER_FRAME, enterFrame);
		}

		private function enterFrame(event:Event):void
		{
			world.space.step(1 / stage.frameRate);

			debug.clear();
			debug.draw(world.space);
			debug.flush();
		}

		private function createDebugDraw():void
		{
			debug = new BitmapDebug(550, 400, 0x000000, false);
			debug.drawCollisionArbiters = true
			addChild(debug.display);
		}
	}
}

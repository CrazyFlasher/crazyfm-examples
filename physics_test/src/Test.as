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
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;

	import nape.constraint.PivotJoint;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyList;
	import nape.util.BitmapDebug;
	import nape.util.Debug;

	[SWF(width="550", height="400", frameRate="60", backgroundColor="#000000")]

	public class Test extends Sprite
	{

		[Embed(source="../resources/test.json", mimeType="application/octet-stream")]
		private var WorldClass:Class;

		private var world:IWorldObject;

		private var debug:Debug;
		private var simulate:Boolean;
		private var handJoint:PivotJoint;

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

			setUpHandJoint();

			addEventListener(Event.ENTER_FRAME, enterFrame);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}

		private function mouseDown(event:MouseEvent):void
		{
			simulate = true;
		}

		private function enterFrame(event:Event):void
		{
			if (simulate)
			{
				world.space.step(1 / stage.frameRate);

				// If the hand joint is active, then set its first anchor to be
				// at the mouse coordinates so that we drag bodies that have
				// have been set as the hand joint's body2.
				if (handJoint.active) {
					handJoint.anchor1.setxy(mouseX, mouseY)
				}
			}

			debug.clear();
			debug.draw(world.space);
			debug.flush();
		}

		private function createDebugDraw():void
		{
			debug = new BitmapDebug(550, 400, 0x000000, false);
			debug.drawCollisionArbiters = true;
			debug.drawConstraints = true;
			addChild(debug.display);
		}

		//
		private function mouseDownHandler(ev:MouseEvent):void {
			// Allocate a Vec2 from object pool.
			var mousePoint:Vec2 = Vec2.get(mouseX, mouseY);

			// Determine the set of Body's which are intersecting mouse point.
			// And search for any 'dynamic' type Body to begin dragging.
			var bodies:BodyList = world.space.bodiesUnderPoint(mousePoint);
			for (var i:int = 0; i < bodies.length; i++) {
				var body:Body = bodies.at(i);

				if (!body.isDynamic()) {
					continue;
				}

				// Configure hand joint to drag this body.
				//   We initialise the anchor point on this body so that
				//   constraint is satisfied.
				//
				//   The second argument of worldPointToLocal means we get back
				//   a 'weak' Vec2 which will be automatically sent back to object
				//   pool when setting the handJoint's anchor2 property.
				handJoint.body2 = body;
				handJoint.anchor2.set(body.worldPointToLocal(mousePoint, true));

				// Enable hand joint!
				handJoint.active = true

				break;
			}

			// Release Vec2 back to object pool.
			mousePoint.dispose();
		}

		private function mouseUpHandler(ev:MouseEvent):void {
			// Disable hand joint (if not already disabled).
			handJoint.active = false;
		}

		private function setUpHandJoint():void
		{

			// Set up a PivotJoint constraint for dragging objects.
			//
			//   A PivotJoint constraint has as parameters a pair
			//   of anchor points defined in the local coordinate
			//   system of the respective Bodys which it strives
			//   to lock together, permitting the Bodys to rotate
			//   relative to eachother.
			//
			//   We create a PivotJoint with the first body given
			//   as 'space.world' which is a pre-defined static
			//   body in the Space having no shapes or velocities.
			//   Perfect for dragging objects or pinning things
			//   to the stage.
			//
			//   We do not yet set the second body as this is done
			//   in the mouseDownHandler, so we add to the Space
			//   but set it as inactive.
			handJoint = new PivotJoint(world.space.world, null, Vec2.weak(), Vec2.weak());
			handJoint.space = world.space;
			handJoint.active = false;

			// We also define this joint to be 'elastic' by setting
			// its 'stiff' property to false.
			//
			//   We could further configure elastic behaviour of this
			//   constraint through the 'frequency' and 'damping'
			//   properties.
			handJoint.stiff = false;
		}
	}
}

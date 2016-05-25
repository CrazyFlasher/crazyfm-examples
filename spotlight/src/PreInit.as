/**
 * Created by Anton Nefjodov on 8.02.2016.
 */
package {
	import com.crazyfm.extension.starlingApp.initializer.models.StarlingConfig;
	import com.crazyfm.extension.starlingApp.initializer.models.StarlingInitializerContext;
	import com.javelin.spotlight.Main;

	import flash.display.Sprite;
	import flash.display3D.Context3DProfile;
	import flash.events.Event;

	/**
	 * PreInit is needed to setup Starling and proceed to Main initialization.
	 * Main extends starling.display.Sprite.
	 */
	public class PreInit extends Sprite
	{
		public function PreInit()
		{
			super();

			addEventListener(Event.ADDED_TO_STAGE, added);
		}

		private function added(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, added);

			var properties:StarlingConfig = new StarlingConfig();
			properties.stageWidth = stage.stageWidth;
			properties.stageHeight = stage.stageHeight;
			properties.context3DProfile = Context3DProfile.BASELINE; //to keep antialiasing
			properties.antiAliasing = 8;

			//Creates IContext, that initializes Starling.
			//This IContext dispatches StarlingInitializerSignal.STARLING_INITIALIZED signal, when starling is ready
			//and automatically creates Main object.
			new StarlingInitializerContext(stage, Main, properties);
		}
	}
}

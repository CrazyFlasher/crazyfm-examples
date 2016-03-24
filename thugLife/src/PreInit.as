/**
 * Created by Anton Nefjodov on 8.02.2016.
 */
package {
	import com.crazy.thugLife.Main;
	import com.crazyfm.extension.starlingApp.initializer.models.StarlingInitializerContext;
	import com.crazyfm.extension.starlingApp.initializer.models.StarlingProperties;

	import flash.display.Sprite;
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

			var properties:StarlingProperties = new StarlingProperties();
			properties.stageWidth = stage.stageWidth;
			properties.stageHeight = stage.stageHeight;
			properties.antiAliasing = 8;

			//Creates IContext, that initializes Starling.
			//This IContext dispatches StarlingInitializerSignal.STARLING_INITIALIZED signal, when starling is ready
			//and automatically creates Main object.
			new StarlingInitializerContext(stage, Main, properties);
		}
	}
}

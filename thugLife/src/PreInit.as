/**
 * Created by Anton Nefjodov on 8.02.2016.
 */
package {
	import com.crazy.thugLife.Main;
	import com.crazyfm.extension.starlingApp.configs.StarlingConfig;
	import com.crazyfm.extension.starlingApp.contexts.StarlingInitializerContext;

	import flash.display.Sprite;
	import flash.display3D.Context3DProfile;
	import flash.events.Event;

	/**
	 * PreInit is needed to setup <code>Starling</code> and proceed to <code>Main</code> initialization.
	 * <code>Main</code> extends <code>starling.display.Sprite</code>.
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
			//and automatically creates <code>Main</code> object.
			new StarlingInitializerContext(stage, Main, properties);
		}
	}
}

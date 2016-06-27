/**
 * Created by Anton Nefjodov on 8.02.2016.
 */
package {
	import com.crazyfm.core.factory.AppFactory;
	import com.crazyfm.core.factory.IAppFactory;
	import com.crazyfm.extension.starlingApp.configs.StarlingConfig;
	import com.crazyfm.extension.starlingApp.initializer.IStarlingInitializer;

	import flash.display.Sprite;
	import flash.display.Stage;
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

			var starlingConfig:StarlingConfig = new StarlingConfig();
			starlingConfig.stageWidth = stage.stageWidth;
			starlingConfig.stageHeight = stage.stageHeight;
			starlingConfig.context3DProfile = Context3DProfile.BASELINE; //to keep antialiasing
			starlingConfig.antiAliasing = 8;

			var factory:IAppFactory = new AppFactory()
				   .mapToValue(Stage, stage)
				   .mapToValue(StarlingConfig, starlingConfig)
				   .mapToValue(Class, Main);

			/**
			 * Creates instance, that initializes Starling.
			 * This <code>IStarlingInitializer</code> dispatches <code>StarlingInitializerMessage.STARLING_INITIALIZED</code> message,
			 * when starling is ready and automatically creates <code>Main</code> object.
			 */
			factory.getInstance(IStarlingInitializer);
		}
	}
}

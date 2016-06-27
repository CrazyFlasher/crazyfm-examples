/**
 * Add "-frame=two,PreInit" as additional compiler option.
 */
package
{
	import com.crazyfm.core.preloader.AbstractInternalPreloader;

	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.utils.getDefinitionByName;

	[SWF(width="550", height="400", frameRate="60", backgroundColor="#000000")]

	/**
	 * Document class of this example
	 */
	public class StartUp extends AbstractInternalPreloader
	{
		public function StartUp()
		{
			GlobalSettings.logEnabled = true;

			super();

			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
		}

		/**
		 * @inheritDoc
		 */
		override protected function appLoaded():void
		{
			//We can make that ordinary way:

			//stage.addChild(new PreInit());

			//But in that case, preloader won't show until all PreInit dependencies are preloaded,
			//and user will see blank screen longer.

			var PreInitClass:Class = getDefinitionByName("PreInit") as Class;
			stage.addChild(new PreInitClass());
			stage.removeChild(this);
		}
	}
}

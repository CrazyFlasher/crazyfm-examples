package
{
	import com.crazyfm.core.preloader.AbstractInternalPreloader;

	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.utils.getDefinitionByName;

	[SWF(width="500", height="500", frameRate="60", backgroundColor="#000000")]

	/**
	 * Document class of this example.
	 */
	public class StartUp extends AbstractInternalPreloader
	{

		public function StartUp()
		{
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

			//import com.crazyfm.example.bubblePattern.Main;
			//...
			//stage.addChild(new Main());

			//But in that case, preloader won't show until all Main dependencies are preloaded,
			//and user will see blank screen longer.

			var MainClass:Class = getDefinitionByName("com.crazyfm.example.bubbleCommandPattern.Main") as Class;
			stage.addChild(new MainClass());
			stage.removeChild(this);
		}
	}
}

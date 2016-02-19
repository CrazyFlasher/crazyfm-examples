package
{
	import com.crazyfm.core.preloader.AbstractInternalPreloader;

	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getDefinitionByName;

	[SWF(width="500", height="500", frameRate="60", backgroundColor="#000000")]

	/**
	 * Document class of this example
	 */
	public class StartUp extends AbstractInternalPreloader
	{
		private var descriptionTf:TextField;

		public function StartUp()
		{
			super();

			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;

			descriptionTf = new TextField();
			descriptionTf.autoSize = TextFieldAutoSize.LEFT;
			descriptionTf.textColor = 0xFFFFFF;
			descriptionTf.text = "Click the ball!";
			stage.addChild(descriptionTf);
		}

		/**
		 * @inheritDoc
		 */
		override protected function appLoaded():void
		{
			//We can make that ordinary way:

			//import com.crazyfm.example.ballClick.Main;
			//...
			//stage.addChild(new Main());

			//But in that case, preloader won't show until all Main dependencies are preloaded,
			//and user will see blank screen longer.

			var MainClass:Class = getDefinitionByName("com.crazyfm.example.ballClick.Main") as Class;
			stage.addChild(new MainClass());
			stage.removeChild(this);
		}
	}
}

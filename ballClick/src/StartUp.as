package
{

	import com.crazyfm.preloader.AbstractInternalPreloader;

	import flash.utils.getDefinitionByName;

	[SWF(width="500", height="500", frameRate="60", backgroundColor="#000000")]
	public class StartUp extends AbstractInternalPreloader
	{
		public function StartUp()
		{
			super();
		}

		override protected function appLoaded():void
		{
			var MainClass:Class = getDefinitionByName("com.crazyfm.example.Main") as Class;
			stage.addChild(new MainClass());
			stage.removeChild(this);
		}
	}
}

/**
 * Created by Anton Nefjodov on 14.03.2016.
 */
package
{
	import flash.display.Sprite;

	public class Test extends Sprite
	{

		[Embed(source="../resources/test.json")]
		private var WorldClass:Class;

		public function Test()
		{
			super();

			init();
		}

		private function init():void
		{

		}
	}
}

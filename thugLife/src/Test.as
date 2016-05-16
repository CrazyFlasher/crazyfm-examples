/**
 * Created by Anton Nefjodov on 16.05.2016.
 */
package
{
	import org.swiftsuspenders.Injector;

	import starling.display.Sprite;

	import test.ITest;
	import test.Test2;
	import test.Vo;

	public class Test extends Sprite
	{
		public var test:ITest;

		private var i:Injector;

		public function Test()
		{
			i = new Injector();
			i.map(ITest).toType(Test2);

			var test:ITest = createTest(new Vo(1, 2));
			var test:ITest = createTest(new Vo(5, 8));
		}

		private function createTest(vo:Vo):ITest
		{
			if (i.hasMapping(Vo))
			{
				i.unmap(Vo);
			}
			i.map(Vo).toValue(vo);
			return i.getInstance(ITest);
		}
	}
}

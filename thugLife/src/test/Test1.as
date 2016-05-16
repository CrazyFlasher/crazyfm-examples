/**
 * Created by Anton Nefjodov on 16.05.2016.
 */
package test
{
	public class Test1 implements ITest
	{
		public function Test1(vo:Vo)
		{
			trace("Test1")
			trace("test1 vo a: ", vo.a);
			trace("test1 vo b: ", vo.b);
		}
	}
}

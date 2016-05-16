/**
 * Created by Anton Nefjodov on 16.05.2016.
 */
package test
{
	public class Vo
	{
		private var _a:int;
		private var _b:int;

		public function Vo(a:int, b:int)
		{
			_a = a;
			_b = b;
		}

		public function get a():int
		{
			return _a;
		}

		public function get b():int
		{
			return _b;
		}
	}
}

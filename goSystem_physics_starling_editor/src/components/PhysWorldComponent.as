/**
 * Created by Anton Nefjodov on 21.03.2016.
 */
package components
{
	import com.crazyfm.extension.goSystem.GameComponent;
	import com.crazyfm.extension.goSystem.IGameComponent;

	import nape.space.Space;

	public class PhysWorldComponent extends GameComponent implements IGameComponent
	{
		private var _space:Space;

		public function PhysWorldComponent()
		{
			super();
		}

		override public function dispose():void
		{
			_space = null;

			super.dispose();
		}

		override public function advanceTime(time:Number):void
		{
			super.advanceTime(time);

			if (_space)
			{
				_space.step(time);
			}
		}

		public function setSpace(value:Space):PhysWorldComponent
		{
			_space = value;

			return this;
		}
	}
}

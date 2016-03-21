/**
 * Created by Anton Nefjodov on 21.03.2016.
 */
package components
{
	import com.crazyfm.extension.goSystem.GameComponent;
	import com.crazyfm.extension.goSystem.IGameComponent;

	import nape.phys.Body;

	public class PhysObjectComponent extends GameComponent
	{
		private var _body:Body;

		public function PhysObjectComponent()
		{
			super();
		}

		public function setBody(value:Body):IGameComponent
		{
			_body = value;

			return this;
		}

		override public function dispose():void
		{
			_body = null;

			super.dispose();
		}

		public function get body():Body
		{
			return _body;
		}
	}
}

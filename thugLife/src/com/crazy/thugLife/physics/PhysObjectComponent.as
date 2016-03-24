/**
 * Created by Anton Nefjodov on 21.03.2016.
 */
package com.crazy.thugLife.physics
{
	import com.crazyfm.extension.goSystem.GameComponent;

	import nape.phys.Body;

	public class PhysObjectComponent extends GameComponent
	{
		private var _body:Body;

		public function PhysObjectComponent()
		{
			super();
		}

		public function setBody(value:Body):PhysObjectComponent
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

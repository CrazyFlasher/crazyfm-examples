/**
 * Created by Anton Nefjodov on 21.03.2016.
 */
package components
{
	import com.crazyfm.extension.goSystem.GameComponent;
	import com.crazyfm.extension.goSystem.IGameComponent;

	import starling.display.DisplayObjectContainer;

	public class ViewComponent extends GameComponent
	{
		private var viewContainer:DisplayObjectContainer;

		public function ViewComponent()
		{
		}

		public function setViewContainer(value:DisplayObjectContainer):ViewComponent
		{
			viewContainer = value;

			return this;
		}

		override public function dispose():void
		{
			viewContainer = null;

			super.dispose();
		}
	}
}

/**
 * Created by Anton Nefjodov on 2.05.2016.
 */
package com.crazy.thugLife.goSystem.components.view
{
	import com.catalystapps.gaf.display.GAFMovieClip;
	import com.crazyfm.devkit.goSystem.components.physyics.view.starling.AbstractPhysBodyObjectView;

	import starling.display.DisplayObjectContainer;

	public class GAFPhysObjectView extends AbstractPhysBodyObjectView
	{
		private var gafSkin:GAFMovieClip;

		public function GAFPhysObjectView(container:DisplayObjectContainer, gafSkin:GAFMovieClip)
		{
			super(container);

			this.gafSkin = gafSkin;
		}

		override protected function drawSkin():void
		{
			_skin.addChild(gafSkin);


		}
	}
}

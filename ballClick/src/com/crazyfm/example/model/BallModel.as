/**
 * Created by Anton Nefjodov on 7.02.2016.
 */
package com.crazyfm.example.model
{
	import com.crazyfm.mvc.model.Model;

	import flash.geom.Point;

	public class BallModel extends Model
	{
		private var _x:int;
		private var _y:int;

		public function BallModel()
		{
			super();
		}

		public function generateRandomCoords():void
		{
			_x = Math.floor(Math.random() * 500);
			_y = Math.floor(Math.random() * 500);

			dispatchSignal("ballCoordsChanged", new Point(_x, _y));
		}
	}
}

/**
 * Created by Anton Nefjodov on 7.02.2016.
 */
package com.crazyfm.core.example.ballClick.model
{
	import com.crazyfm.core.example.ballClick.events.BallModelEventEnum;

	import flash.geom.Point;

	/**
	 * Simple ball logic class.
	 */
	public class BallModel extends Model
	{
		private var _x:int;
		private var _y:int;

		public function BallModel()
		{
			super();
		}

		/**
		 * Generates new coordinates.
		 * Dispatches them from its hierarchy level until hierarchy top.
		 */
		public function generateRandomCoordinates():void
		{
			//Generates new coordinates
			_x = Math.floor(Math.random() * 500);
			_y = Math.floor(Math.random() * 500);

			//Dispatches Point object, that contains new ball coordinates
			//from its hierarchy level until hierarchy top.
			dispatchSignal(BallModelEventEnum.BALL_COORDINATES_CHANGED, new Point(_x, _y));
		}
	}
}
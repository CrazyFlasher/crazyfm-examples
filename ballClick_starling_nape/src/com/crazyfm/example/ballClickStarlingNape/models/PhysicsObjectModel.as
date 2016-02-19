/**
 * Created by Anton Nefjodov on 13.02.2016.
 */
package com.crazyfm.example.ballClickStarlingNape.models
{
	import com.crazyfm.core.mvc.event.ISignalEvent;
	import com.crazyfm.core.mvc.model.Context;
	import com.crazyfm.core.mvc.view.IViewController;
	import com.crazyfm.example.ballClickStarlingNape.signals.PhysicsWorldSignalEnum;
	import com.crazyfm.example.ballClickStarlingNape.views.BallViewController;

	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;

	/**
	 * Base physics model class, that created body, connects to view controller in listens for WORLD_STEP signal from PhysicsWorldContext
	 */
	public class PhysicsObjectModel extends Context
	{
		protected var _body:Body;
		protected var _view:IViewController;

		private var _bodyType:BodyType;

		public function PhysicsObjectModel(bodyType:BodyType)
		{
			super();

			_bodyType = bodyType;

			init();
		}

		private function init():void
		{
			_body = new Body(_bodyType);

			addBodyShapes();

			addSignalListener(PhysicsWorldSignalEnum.WORLD_STEP, onWorldStep);
		}

		protected function addBodyShapes():void
		{
			//override
		}

		protected function onWorldStep(event:ISignalEvent):void
		{
			if (_view)
			{
				(_view as BallViewController).updateTransform(_body.position);
			}
		}

		public function get body():Body
		{
			return _body;
		}

		override public function dispose():void
		{
			_body = null;
			_view = null;
			_bodyType = null;

			super.dispose();
		}

		public function set velocity(value:Vec2):void
		{
			_body.velocity.set(value);
		}

		public function get velocity():Vec2
		{
			return _body.velocity;
		}

		public function set position(value:Vec2):void
		{
			_body.position = value;
		}

		public function get position():Vec2
		{
			return _body.position;
		}

		override public function addViewController(viewController:IViewController):void
		{
			super.addViewController(viewController);

			_view = viewController;
		}
	}
}

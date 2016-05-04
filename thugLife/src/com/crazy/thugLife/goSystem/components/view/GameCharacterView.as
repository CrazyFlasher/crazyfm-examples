/**
 * Created by Anton Nefjodov on 3.05.2016.
 */
package com.crazy.thugLife.goSystem.components.view
{
	import com.catalystapps.gaf.display.GAFMovieClip;
	import com.crazy.thugLife.goSystem.components.controllable.IAimable;
	import com.crazy.thugLife.goSystem.components.controllable.IClimbable;
	import com.crazy.thugLife.goSystem.components.controllable.IJumpable;
	import com.crazy.thugLife.goSystem.components.controllable.IMovable;
	import com.crazyfm.devkit.goSystem.components.physyics.view.starling.gaf.GAFPhysObjectView;

	import flash.geom.Point;

	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;

	public class GameCharacterView extends GAFPhysObjectView
	{
		private const STAY_ANIMATION:String = "stay";
		private const WALK_ANIMATION:String = "walk";
		private const RUN_ANIMATION:String = "run";
		private const JUMP_ANIMATION:String = "jump";
		private const CLIMB_ANIMATION:String = "climb";

		private var movable:IMovable;
		private var jumpable:IJumpable;
		private var climbable:IClimbable;
		private var aimable:IAimable;

		private var gunArm:DisplayObject;

		private var armGlobalPosition:Point = new Point();
		private var armCurrentPosition:Point = new Point();

		public function GameCharacterView(viewContainer:DisplayObjectContainer, gafSkin:GAFMovieClip,
										  movable:IMovable = null,
										  jumpable:IJumpable = null,
										  climbable:IClimbable = null,
										  aimable:IAimable = null)
		{
			super(viewContainer, gafSkin);

			this.movable = movable;
			this.jumpable = jumpable;
			this.climbable = climbable;
			this.aimable = aimable;
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			var isJumping:Boolean = jumpable && jumpable.isJumping;
			var isClimbing:Boolean = climbable && climbable.isClimbing;
			var isWalking:Boolean = movable && movable.isMoving && !movable.isRunning && !isJumping && !isClimbing;
			var isRunning:Boolean = movable && movable.isRunning && !isJumping && !isClimbing;
			var isStaying:Boolean = !isWalking && !isRunning && !isJumping && !isClimbing;

			if (isWalking)
			{
				playAnimation(WALK_ANIMATION);
			} else if (isRunning)
			{
				playAnimation(RUN_ANIMATION);
			} else if (isJumping)
			{
				playAnimation(JUMP_ANIMATION);
			} else if (isClimbing)
			{
				playAnimation(CLIMB_ANIMATION);
				if (model.velocity.length < 10)
				{
					gafSkin.stop(true);
				}
			} else if (isStaying)
			{
				playAnimation(STAY_ANIMATION);
			}

			if (aimable)
			{
				updateAimingView();
			}
		}

		private function updateAimingView():void
		{
			if (gunArm)
			{
				armCurrentPosition.x = gunArm.x;
				armCurrentPosition.y = gunArm.y;

				gunArm.rotation = getAngle(gafSkin.localToGlobal(armCurrentPosition, armGlobalPosition), aimable.aimPosition);
			}
		}

		private function playAnimation(animationId:String):void
		{
			gafSkin.gotoAndStop(animationId);
			gafSkin.play(true);
			gafSkin.stop(false);

			if (!gunArm)
			{
				gunArm = (gafSkin.getChildAt(0) as DisplayObjectContainer).getChildByName("gunArm");
			}
		}

		private function getAngle(p1:Point, p2:Point):Number
		{
			var dx:Number = p1.x - p2.x;
			var dy:Number = p1.y - p2.y;
			return Math.atan2(dy, dx) + Math.PI - _skin.rotation;
		}
	}
}

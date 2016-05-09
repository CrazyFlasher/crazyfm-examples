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
	import com.crazy.thugLife.goSystem.components.controllable.IRotatable;
	import com.crazyfm.devkit.goSystem.components.physyics.view.starling.gaf.GAFPhysObjectView;

	import flash.geom.Point;

	import nape.geom.Vec2;

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
		private var rotatable:IRotatable;

		private var gunArm:DisplayObject;

		private var armGlobalPosition:Point = new Point();
		private var armCurrentPosition:Point = new Point();

		public function GameCharacterView(viewContainer:DisplayObjectContainer, gafSkin:GAFMovieClip,
										  movable:IMovable = null,
										  jumpable:IJumpable = null,
										  climbable:IClimbable = null,
										  aimable:IAimable = null,
										  rotatable:IRotatable = null)
		{
			super(viewContainer, gafSkin);

			this.movable = movable;
			this.jumpable = jumpable;
			this.climbable = climbable;
			this.aimable = aimable;
			this.rotatable = rotatable;
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			var isClimbing:Boolean = climbable && climbable.isClimbing;
			var isJumping:Boolean = jumpable && jumpable.isJumping && !isClimbing;
			var isWalking:Boolean = movable && movable.isMoving && !movable.isRunning && !isJumping && !isClimbing;
			var isRunning:Boolean = movable && movable.isRunning && !isJumping && !isClimbing;
			var isStaying:Boolean = !isWalking && !isRunning && !isJumping && !isClimbing;

			if (isWalking)
			{
				playAnimation(WALK_ANIMATION);
			} else
			if (isRunning)
			{
				playAnimation(RUN_ANIMATION);
			} else
			if (isJumping)
			{
				playAnimation(JUMP_ANIMATION);
			} else
			if (isClimbing)
			{
				playAnimation(CLIMB_ANIMATION);
				/*if (model.velocity.length < 10)
				{
					gafSkin.stop(true);
				}else
				{
					gafSkin.play(true);
					gafSkin.stop(false);
				}*/
			} else
			if (isStaying)
			{
				playAnimation(STAY_ANIMATION);
			}

			if (aimable)
			{
				updateAimingView();
			}
			if (rotatable)
			{
				updateDirection();
			}
		}

		private function updateDirection():void
		{
			if (rotatable.isRotatedLeft && gafSkin.scaleX > 0)
			{
				gafSkin.scaleX = -1;
			}else
			if (!rotatable.isRotatedLeft && gafSkin.scaleX < 0)
			{
				gafSkin.scaleX = 1;
			}
		}

		private function updateAimingView():void
		{
			if (gunArm)
			{
				armCurrentPosition.x = gunArm.x;
				armCurrentPosition.y = gunArm.y;

				gafSkin.localToGlobal(armCurrentPosition, armGlobalPosition);
				viewContainer.globalToLocal(armGlobalPosition, armGlobalPosition);

				gunArm.rotation = getAngle(armGlobalPosition, aimable.aimPosition);
			}
		}

		private function playAnimation(animationId:String):void
		{
//			if (gafSkin.currentSequence != animationId)
//			{
				gafSkin.gotoAndStop(animationId);
				gafSkin.play(true);
				gafSkin.stop(false);

				gunArm = ((gafSkin.getChildByName(animationId) as DisplayObjectContainer)
								.getChildByName("body") as DisplayObjectContainer)
								.getChildByName("gunArm");


//			}
		}

		private function getAngle(p1:Point, p2:Vec2):Number
		{
			var dx:Number = p1.x - p2.x;
			var dy:Number = p1.y - p2.y;
			return Math.atan2(dy, dx) + Math.PI - _skin.rotation;
		}
	}
}

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

	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;

	public class GameCharacterView extends GAFPhysObjectView
	{
		private const STAY_ANIMATION:String = "stay";
		private const WALK_ANIMATION:String = "walk";
		private const WALK_BACK_ANIMATION:String = "walkBack";
		private const RUN_ANIMATION:String = "run";
		private const RUN_BACK_ANIMATION:String = "runBack";
		private const JUMP_ANIMATION:String = "jump";
		private const CLIMB_ANIMATION:String = "climb";
		private const CLIMB_OUT_ANIMATION:String = "climbOut";

		private var movable:IMovable;
		private var jumpable:IJumpable;
		private var climbable:IClimbable;
		private var aimable:IAimable;
		private var rotatable:IRotatable;

		private var gunArm:DisplayObject;

		private var armGlobalPosition:Point = new Point();
		private var armCurrentPosition:Point = new Point();

		private var tween:Tween;

		private var currentAnim:GAFMovieClip;
		private var currentAnimId:String;

		public function GameCharacterView(viewContainer:DisplayObjectContainer, gafSkin:GAFMovieClip)
		{
			super(viewContainer, gafSkin);

//			playAnimation(STAY_ANIMATION, true);
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			fetchControllableModels();

			var isClimbing:Boolean = climbable && climbable.isClimbing;
			var isJumping:Boolean = jumpable && jumpable.isJumping && !isClimbing;
			var isWalking:Boolean = movable && movable.isMoving && !movable.isRunning && !isJumping && !isClimbing;
			var isRunning:Boolean = movable && movable.isRunning && !isJumping && !isClimbing;
			var isStaying:Boolean = !isWalking && !isRunning && !isJumping && !isClimbing;
			var isLeavingLadder:Boolean = climbable && climbable.isLeavingLadder;

			var isLeftDirection:Boolean = movable && movable.isLeftDirection;
			var isAimingLeft:Boolean = aimable && aimable.isAimingLeft;

			var playBackwardAnim:Boolean = isLeftDirection != isAimingLeft;

			if (isLeavingLadder)
			{
				playAnimation(CLIMB_OUT_ANIMATION);
			}else
			if (isWalking)
			{
				playAnimation(playBackwardAnim ? WALK_BACK_ANIMATION : WALK_ANIMATION);
			} else
			if (isRunning)
			{
				playAnimation(playBackwardAnim ? RUN_BACK_ANIMATION : RUN_ANIMATION);
			} else
			if (isJumping)
			{
				playAnimation(JUMP_ANIMATION);
			} else
			if (isClimbing)
			{
				playAnimation(CLIMB_ANIMATION);
				if (model.velocity.length < 10)
				{
					gafSkin.stop(true);
				}else
				{
					gafSkin.play(true);
					gafSkin.stop(false);
				}
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

		private function fetchControllableModels():void
		{
			if (!movable)
			{
				movable = gameObject.getComponentByType(IMovable) as IMovable;
			}
			if (!jumpable)
			{
				jumpable = gameObject.getComponentByType(IJumpable) as IJumpable;
			}
			if (!climbable)
			{
				climbable = gameObject.getComponentByType(IClimbable) as IClimbable;
			}
			if (!aimable)
			{
				aimable = gameObject.getComponentByType(IAimable) as IAimable;
			}
			if (!rotatable)
			{
				rotatable = gameObject.getComponentByType(IRotatable) as IRotatable;
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

				gafSkin.getChildByName(gafSkin.currentSequence).localToGlobal(armCurrentPosition, armGlobalPosition);
				viewContainer.globalToLocal(armGlobalPosition, armGlobalPosition);

				gunArm.rotation = getGunArmAngle(armGlobalPosition, aimable.aimRay.at(100));
			}
		}

		private function playAnimation(animationId:String, force:Boolean = false):void
		{
			if (currentAnimId != animationId || force)
			{
				currentAnimId = animationId;
				currentAnim = gafSkin.getChildByName(animationId) as GAFMovieClip;

				gafSkin.gotoAndStop(animationId);

				currentAnim.gotoAndStop(1);

				gafSkin.play(true);
				gafSkin.stop(false);

				gunArm = null;

				if (currentAnim.getChildByName("body"))
				{
					gunArm = (currentAnim.getChildByName("body") as DisplayObjectContainer)
							.getChildByName("gunArm");
				}

				//gunArm.pivotY = -25;
				//gunArm.pivotX = -10;
			}
		}

		private function getGunArmAngle(p1:Point, p2:Vec2):Number
		{
			var dx:Number = p1.x - p2.x;
			var dy:Number = p1.y - p2.y;

			var angleFromTan:Number =  Math.atan2(dy, dx);
			var finalAngle:Number;

			if (rotatable && rotatable.isRotatedLeft)
			{
				finalAngle = angleFromTan * -1 + additionalRotation;
			}else
			{
				finalAngle = angleFromTan + Math.PI - additionalRotation;
			}

			return finalAngle;
		}

		private function get additionalRotation():Number
		{
			var bodyRotation:Number = currentAnim.getChildByName("body").rotation;
			if (rotatable && rotatable.isRotatedLeft)
			{
				bodyRotation *= -1;
			}

			return _skin.rotation + bodyRotation;
		}

		override protected function setRotation(value:Number):void
		{
			if (!tween)
			{
				tween = new Tween(_skin, 0.1);
			}else
			{
				tween.reset(_skin, 0.1);
			}

			tween.rotateTo(value);
			Starling.juggler.add(tween);
		}

		override public function dispose():void
		{
			if (tween) {
				Starling.juggler.remove(tween);
				tween = null;
			}

			super.dispose();
		}
	}
}

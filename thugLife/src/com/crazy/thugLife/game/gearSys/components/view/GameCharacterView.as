/**
 * Created by Anton Nefjodov on 3.05.2016.
 */
package com.crazy.thugLife.game.gearSys.components.view
{
	import com.catalystapps.gaf.display.GAFMovieClip;
	import com.crazy.thugLife.common.enums.WeaponEnum;
	import com.crazy.thugLife.game.gearSys.components.controllable.IArmed;
	import com.crazy.thugLife.game.gearSys.components.controllable.IClimbable;
	import com.crazy.thugLife.game.gearSys.components.controllable.IJumpable;
	import com.crazy.thugLife.game.gearSys.components.controllable.IMovable;
	import com.crazy.thugLife.game.gearSys.components.controllable.IRotatable;
	import com.crazyfm.devkit.gearSys.components.physyics.view.starling.gaf.GAFPhysObjectView;
	import com.crazyfm.extension.gearSys.IGearSysComponent;

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
		private var rotatable:IRotatable;
		private var armed:IArmed;

		private var body:GAFMovieClip;
		private var gun:DisplayObject;
		private var gunArm_1:DisplayObject;
		private var gunArm_2:DisplayObject;

		private var armGlobalPosition:Point = new Point();
		private var armCurrentPosition:Point = new Point();

		private var tween:Tween;

		private var currentAnim:GAFMovieClip;
		private var currentAnimId:String;
		private var bodyAnim:GAFMovieClip;
		private var currentBodyAnim:GAFMovieClip;

		private var controllableModelsFetched:Boolean;

		public function GameCharacterView(gafSkin:GAFMovieClip)
		{
			super(gafSkin);

//			playAnimation(STAY_ANIMATION, true);
		}

		override public function interact(timePassed:Number):void
		{
			super.interact(timePassed);

			fetchControllableModels();

			var isClimbing:Boolean = isAvailable(climbable) && climbable.isClimbing;
			var isJumping:Boolean = isAvailable(jumpable) && jumpable.isJumping && !isClimbing;
			var isWalking:Boolean = isAvailable(movable) && movable.isMoving && !movable.isRunning && !isJumping && !isClimbing;
			var isRunning:Boolean = isAvailable(movable) && movable.isRunning && !isJumping && !isClimbing;
			var isStaying:Boolean = !isWalking && !isRunning && !isJumping && !isClimbing;
			var isLeavingLadder:Boolean = isAvailable(climbable) && climbable.isLeavingLadder;

			var isLeftDirection:Boolean = isAvailable(movable) && movable.isLeftDirection;
			var isAimingLeft:Boolean = isAvailable(rotatable) && rotatable.isRotatedLeft;
			var isChangingWeapon:Boolean = isAvailable(armed) && armed.isChangingWeapon;

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
					pauseCurrentAnim();
				}else
				{
					resumeCurrentAnim();
				}
			} else
			if (isStaying)
			{
				playAnimation(STAY_ANIMATION);
			}

			if (isAvailable(armed))
			{
				updateAimingView();
			}
			if (isAvailable(rotatable))
			{
				updateDirection();
			}
			if (isChangingWeapon)
			{
				playAnimation(currentAnimId, true);
			}
		}

		private function resumeCurrentAnim():void
		{
			currentAnim.play();
			currentBodyAnim.play();
		}

		private function pauseCurrentAnim():void
		{
			currentAnim.stop();
			currentBodyAnim.stop();
		}

		private function isAvailable(component:IGearSysComponent):Boolean
		{
			return component && component.isEnabled;
		}

		private function fetchControllableModels():void
		{
			if (!controllableModelsFetched)
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
				if (!rotatable)
				{
					rotatable = gameObject.getComponentByType(IRotatable) as IRotatable;
				}
				if (!armed)
				{
					armed = gameObject.getComponentByType(IArmed) as IArmed;
				}

				controllableModelsFetched = true;
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
			if (gun)
			{
				armCurrentPosition.x = gun.x;
				armCurrentPosition.y = gun.y;

				currentAnim.localToGlobal(armCurrentPosition, armGlobalPosition);
				viewContainer.globalToLocal(armGlobalPosition, armGlobalPosition);

//				gun.rotation = getGunArmAngle(armGlobalPosition, armed.aimPosition);
				gun.rotation = fixGunArmAngle(armed.aimPosition.angle);

				if (gunArm_1)
				{
					gunArm_1.x = gun.x;
					gunArm_1.y = gun.y;
					gunArm_1.rotation = gun.rotation;
				}
				if (gunArm_2)
				{
					gunArm_2.x = gun.x;
					gunArm_2.y = gun.y;
					gunArm_2.rotation = gun.rotation;
				}
			}
		}

		private function playAnimation(animationId:String, force:Boolean = false):void
		{
			if (currentAnimId != animationId || force)
			{
				/**
				 * human -> gafSkin
				 * 	|- stay
				 * 	|- walk
				 * 	|- run -> currentAnim
				 * 		|- body -> body
				 * 			|- holster
				 * 			|- pistol
				 * 			|- shotgun -> bodyAnim
				 * 				|- stay
				 * 				|- walk
				 * 				|- run -> currentBodyAnim
				 * 					|- gun
				 * 					|- gunArm_1
				 * 					|- gunArm_2
				 * 					(no gun or gunArm_x if WeaponEnum.HOLSTER)
				 */

				currentAnimId = animationId;
				currentAnim = gafSkin.getChildByName(animationId) as GAFMovieClip;

				gafSkin.gotoAndStop(animationId);

				currentAnim.gotoAndPlay(1);

				body = currentAnim.getChildByName("body") as GAFMovieClip;
				body.gotoAndStop(isAvailable(armed) ? armed.currentWeapon.name : WeaponEnum.HOLSTER.name);

				bodyAnim = body.getChildByName(isAvailable(armed) ? armed.currentWeapon.name : WeaponEnum.HOLSTER.name) as GAFMovieClip;
				bodyAnim.gotoAndStop(animationId);

				currentBodyAnim = bodyAnim.getChildByName(animationId) as GAFMovieClip;
				currentBodyAnim.gotoAndPlay(1);

				gun = null;
				gunArm_1 = null;
				gunArm_2 = null;

				gun = currentBodyAnim.getChildByName("gun");
				gunArm_1 = currentBodyAnim.getChildByName("gunArm_1");
				gunArm_2 = currentBodyAnim.getChildByName("gunArm_2");
			}
		}

		private function fixGunArmAngle(angle:Number):Number
		{
			var finalAngle:Number;

			if (isAvailable(rotatable) && rotatable.isRotatedLeft)
			{
				finalAngle = angle * -1 + additionalRotation + Math.PI;
			}else
			{
				finalAngle = angle - additionalRotation;
			}

			return finalAngle;
		}

		private function get additionalRotation():Number
		{
			var bodyRotation:Number = currentAnim.getChildByName("body").rotation;
			if (isAvailable(rotatable) && rotatable.isRotatedLeft)
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

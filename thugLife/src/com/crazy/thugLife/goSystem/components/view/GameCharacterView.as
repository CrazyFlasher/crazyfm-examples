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

			var isWalking:Boolean = movable && movable.isMoving && !movable.isRunning;
			var isRunning:Boolean = movable && movable.isRunning;
			var isJumping:Boolean = jumpable && jumpable.isJumping;
			var isClimbing:Boolean = climbable && climbable.isClimbing;
			var isStaying:Boolean = !isWalking && !isRunning && !isJumping && !isClimbing;

			if (isWalking)
			{
				playAnimation(WALK_ANIMATION);
			}else
			if (isRunning)
			{
				playAnimation(RUN_ANIMATION);
			}else
			if (isJumping)
			{
				playAnimation(JUMP_ANIMATION);
			}else
			if (isClimbing)
			{
				playAnimation(CLIMB_ANIMATION);
			}else
			if (isStaying)
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
			//TODO:
		}

		private function playAnimation(animationId:String):void
		{
			gafSkin.gotoAndStop(animationId);
		}
	}
}

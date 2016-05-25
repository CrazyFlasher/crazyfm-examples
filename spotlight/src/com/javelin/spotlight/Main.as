/**
 * Created by Anton Nefjodov on 25.05.2016.
 */
package com.javelin.spotlight
{
	import feathers.controls.ImageLoader;

	import flash.display.Loader;

	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.utils.AssetManager;

	public class Main extends Sprite
	{
		private const MAX_T:int = 160;

		private var am:AssetManager;

		private var loadAssets:Boolean;

		private var img:Image;
		private var currentTex:int;

		private var l:ImageLoader;

		public function Main()
		{
			super();

			init();
		}

		private function init():void
		{
			Starling.current.showStats = true;

			addEventListener(Event.ADDED_TO_STAGE, added);
		}

		private function added(event:Event):void
		{
			stage.addEventListener(TouchEvent.TOUCH, onTouch);

			l = new ImageLoader();
			l.addEventListener(Event.COMPLETE, loaded);
			addChild(l);
		}

		private function loaded(event:Event):void
		{

		}

		private function onTouch(event:TouchEvent):void
		{
			var t:Touch = event.touches[0];

			if (t)
			{
				if (t.phase == TouchPhase.BEGAN)
				{
					/*if (!loadAssets)
					{
						load();
					}else
					{
						switchImage();
					}*/
					loadAndShowImage();
				}
			}
		}

		private function loadAndShowImage():void
		{
			l.source = "assets/bg/" + currentTex + ".jpg";

			currentTex++;

			if (currentTex > MAX_T)
			{
				currentTex = 0;
			}
		}

		private function switchImage():void
		{
			if (!img)
			{
				img = new Image(getTexture());
				addChild(img);
			}else
			{
				img.texture = getTexture();
			}
		}

		private function getTexture():Texture
		{
			var t:Texture = am.getTexture(currentTex.toString());

			currentTex++;

			if (currentTex > MAX_T)
			{
				currentTex = 0;
			}

			return t;
		}

		private function load():void
		{
			loadAssets = true;

			am = new AssetManager();

			for (var i:int = 0; i <= MAX_T; i++)
			{
				am.enqueue("assets/bg/" + i + ".jpg");
			}
			am.loadQueue(function(ratio:Number):void {
				//DebugConsole.print("GameData: loading starling assets, progress:", ratio);
				if (ratio == 1.0) {
					log("Assets loaded");
					switchImage();
				}
			})
		}
	}
}

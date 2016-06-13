/**
 * Created by Anton Nefjodov on 13.06.2016.
 */
package com.crazyfm.example.bubbleCommandPattern.view.ui
{
	import com.crazyfm.core.common.IDisposable;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class InputForm extends Sprite implements IDisposable
	{
		private var button:Button;
		private var textField:TextField;

		private var _isDisposed:Boolean;

		public function InputForm()
		{
			super();

			init();
		}

		private function init():void
		{
			textField = new TextField();
			textField.textColor = textField.borderColor = 0xFFFFFF;
			textField.border = true;
			textField.width = 100;
			textField.height = 20;

			button = new Button();
			button.x = 105;
			button.addEventListener(MouseEvent.CLICK, buttonClicked);

			addChild(textField);
			addChild(button);
		}

		private function buttonClicked(event:MouseEvent):void
		{
			dispatchEvent(new Event("formButtonClicked"));
		}

		public function dispose():void
		{
			button.removeEventListener(MouseEvent.CLICK, buttonClicked);
		}

		public function get isDisposed():Boolean
		{
			return _isDisposed;
		}

		public function set text(value:String):void
		{
			textField.text = value;
		}
	}
}

import flash.display.Shape;
import flash.display.Sprite;

internal class Button extends Sprite
{
	public function Button()
	{
		super();

		init();
	}

	private function init():void
	{
		var shape:Shape = new Shape();
		shape.graphics.beginFill(0xFF0000);
		shape.graphics.drawRect(0, 0, 20, 20);
		shape.graphics.endFill();
		addChild(shape);
	}
}

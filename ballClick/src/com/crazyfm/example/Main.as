/**
 * Created by Anton Nefjodov on 7.02.2016.
 */
package com.crazyfm.example
{
	import com.crazyfm.example.model.ApplicationContext;
	import com.crazyfm.example.view.ApplicationViewControllerFlash;

	import flash.display.Sprite;

	public class Main extends Sprite
	{
		public function Main()
		{
			new ApplicationContext().addView(new ApplicationViewControllerFlash(this));
		}
	}
}

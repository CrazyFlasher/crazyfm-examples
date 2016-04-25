/**
 * Created by Anton Nefjodov on 25.04.2016.
 */
package com.crazy.thugLife.goSystem.components.controllable
{
	import com.crazyfm.core.common.Enum;

	public class MovementType extends Enum
	{
		public static const WALK:MovementType = new MovementType("walk");
		public static const RUN:MovementType = new MovementType("run");
		public static const SNEAK:MovementType = new MovementType("sneak");
		public static const CRAWL:MovementType = new MovementType("crawl");

		public function MovementType(name:String)
		{
			super(name);
		}
	}
}

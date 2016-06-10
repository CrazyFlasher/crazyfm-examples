/**
 * Created by Anton Nefjodov on 9.06.2016.
 */
package com.crazyfm.example.bubblePattern.commands
{
	import com.crazyfm.core.mvc.command.AbstractCommand;
	import com.crazyfm.example.bubblePattern.models.IUserDataModel;

	public class ChangeAgeCommand extends AbstractCommand
	{
		[Autowired]
		public var userModel:IUserDataModel;

		override public function execute():void
		{
			userModel.age = Math.floor(Math.random() * 10000);
		}
	}
}
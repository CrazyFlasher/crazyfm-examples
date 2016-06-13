/**
 * Created by Anton Nefjodov on 9.06.2016.
 */
package com.crazyfm.example.bubbleCommandPattern.commands
{
	import com.crazyfm.core.mvc.command.AbstractCommand;
	import com.crazyfm.example.bubbleCommandPattern.models.IUserDataModel;

	public class ChangeFirstNameCommand extends AbstractCommand
	{
		[Autowired]
		public var userModel:IUserDataModel;

		override public function execute():void
		{
			userModel.firstName = "Anton" + Math.floor(Math.random() * 10000);
		}
	}
}

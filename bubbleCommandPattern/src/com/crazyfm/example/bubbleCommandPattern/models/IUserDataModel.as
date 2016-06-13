/**
 * Created by Anton Nefjodov on 9.06.2016.
 */
package com.crazyfm.example.bubbleCommandPattern.models
{
	import com.crazyfm.core.mvc.model.IModel;

	public interface IUserDataModel extends IModel
	{
		function get firstName():String;
		function set firstName(value:String):void;
		function get lastName():String;
		function set lastName(value:String):void;
		function get age():int;
		function set age(value:int):void;
	}
}

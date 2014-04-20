package controller.comands
{
	import org.puremvc.as3.interfaces.INotification;
	public class ChecLoginUserCommand extends GeneralCommand{
		
		override public function execute(notification:INotification):void{
			var loginArray:Array= notification.getBody() as Array;
			//serverProxy.sendRequestAttemptToEnter(loginArray);
			sharedObjectProxy.attemptToEnter(loginArray);
		}
	}
}
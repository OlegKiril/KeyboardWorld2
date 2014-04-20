package controller.comands
{
	import model.proxy.SharedObjectProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class RegistrationUserCommand extends GeneralCommand{
	
		override public function execute(notification:INotification):void{
			var loginArray:Array= notification.getBody() as Array;			
			var sharedObjectProxy:SharedObjectProxy = facade.retrieveProxy( SharedObjectProxy.NAME ) as SharedObjectProxy;
			sharedObjectProxy.registration(loginArray);
			//serverProxy.sendRequestRegistration(loginArray);
		}
	}
}
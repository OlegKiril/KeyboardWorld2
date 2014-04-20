package controller.comands
{
	import org.puremvc.as3.interfaces.INotification;

	public class SendMessageCommand extends GeneralCommand{
	
		override public function execute(notification:INotification):void{
			var message:String= notification.getBody() as String;		
			serverProxy.sendmessage(message);
		}
	}
}
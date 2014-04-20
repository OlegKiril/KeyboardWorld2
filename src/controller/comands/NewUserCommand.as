package controller.comands
{
	import configuration.Notification.NotList;
	import model.VO.PopapDoActionVO;
	import org.puremvc.as3.interfaces.INotification;
	import view.components.PopapViewLogic;
	import view.mediator.PopapMediator;

	public class NewUserCommand  extends GeneralCommand{
	
		override public function execute(notification: INotification):void{
			super.execute(notification);
			var userObject:Object= notification.getBody() as Object;
			sendNotification(NotList.USER_ENTERED,userObject);
			facade.registerMediator(new PopapMediator(new PopapViewLogic("WelcomePopap"),null,[new PopapDoActionVO]));
		}
	}
}
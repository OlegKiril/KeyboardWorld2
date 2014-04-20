package view.mediator
{
	import configuration.Notification.NotList;
	import org.puremvc.as3.interfaces.INotification;
	import view.components.LoginPopapViewLogic;
	import view.components.PopapViewLogic;

	public class LoginPopapMediator extends PopapMediator{
		public static const NAME:String = "LoginPopapMediator";
		
		public function LoginPopapMediator(nameViewLogic:PopapViewLogic, 
										   doNotification:Array=null, 
										   closeNotification:Array=null,
										   modalMode:Boolean=true){
			super(nameViewLogic, doNotification,closeNotification, NAME);
		}
		override public function listNotificationInterests():Array{
			return [NotList.USER_REGISTERED,NotList.USER_ENTERED, NotList.USER_WITH_THAT_NAME_EXIST, NotList.TRY_EGEIN_OR_REGISTER,NotList.NO_CONNECTION_TO_THE_SERVER];
		}
		override public function handleNotification(notification:INotification):void{
			switch(notification.getName()){
				case NotList.USER_ENTERED:
				case NotList.USER_REGISTERED:
					super.closePopap();
					break;
				case NotList.USER_WITH_THAT_NAME_EXIST:
					(viewLogic as LoginPopapViewLogic).text2();
					break;
				case NotList.TRY_EGEIN_OR_REGISTER:
					(viewLogic as LoginPopapViewLogic).text3();
					break;
				case NotList.NO_CONNECTION_TO_THE_SERVER:
					(viewLogic as LoginPopapViewLogic).text4();
					break;
			}
		}
	}
}
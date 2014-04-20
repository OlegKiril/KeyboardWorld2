package view.mediator
{
	import configuration.Notification.NotList;
	
	import flash.events.MouseEvent;
	
	import model.VO.UserVO;
	
	import org.puremvc.as3.interfaces.INotification;
	
	import utility.MyDataEvent;
	
	import view.components.UserPanelViewLogic;

	public class UserPanelMediator extends UIMediator{
		public static const NAME:String = "UserPanelMediator";
						
		public function UserPanelMediator(){
			super(NAME,new UserPanelViewLogic("UserPanel"));	
			viewLogic.addEventListener(MouseEvent.CLICK,btnClickHandler);
			viewLogic.addEventListener(NotList.SEND_MESSAGE,sendMessageHandler);
		}
		protected function btnClickHandler(event:MouseEvent):void{
			sendNotification(NotList.EXIT_TO_MAIN_MENU);
		}
		private function sendMessageHandler(event:MyDataEvent):void{
			sendNotification(NotList.SEND_MESSAGE,event.data);
		}
		override public function listNotificationInterests():Array{
			return [NotList.USERDATA,,NotList.SEND_TO_ALL];
		}
		override public function handleNotification(notification:INotification):void{
			switch(notification.getName()){
				case NotList.USERDATA: 
					var userVO:UserVO = notification.getBody() as UserVO;
					(viewLogic as UserPanelViewLogic).userData(userVO.user_name,userVO.level,userVO.error,userVO.score);
					onRegister();
					break;
				case NotList.SEND_TO_ALL: 
					var message:String = notification.getBody() as String;
					(viewLogic as UserPanelViewLogic).answerMessage(message);
					onRegister();
					break;
			}
		}
	}
}
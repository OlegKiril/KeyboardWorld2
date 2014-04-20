package view.mediator
{
	import configuration.Notification.NotList;
	import flash.display.DisplayObjectContainer;
	import org.puremvc.as3.interfaces.INotification;
	import utility.MyDataEvent;
	import view.components.MainMenuViewLogic;

	public class MainMenuMediator extends UIMediator{
		public static const NAME:String = "MainMenuMediator";
		
		public function MainMenuMediator(){
			super(NAME,new MainMenuViewLogic());
			viewLogic.addEventListener(NotList.NEW_LOCATION,newLocation);
		}
		protected function newLocation(event:MyDataEvent):void{
			var index:int = event.data as int;
			sendNotification(NotList.NEWLEVEL,index);
			onRemove();
		}
		public function setIcon(id:int, url:DisplayObjectContainer, isClosed:Boolean):void{
			(viewLogic as MainMenuViewLogic).setIcon(id,url,isClosed);
		}
		public function updateIcon(id:int, isClosed:Boolean):void{
			(viewLogic as MainMenuViewLogic).updateIcon(id,isClosed);
		}
		public function setlvlForNewLocation(lvlForNewLocation:int):void{
			(viewLogic as MainMenuViewLogic).setlvlForNewLocation(lvlForNewLocation);
		}
		override public function listNotificationInterests():Array{
			return [NotList.MEIN_MENU_ONRREGISTER];
		}
		override public function handleNotification(notification:INotification):void{
			switch(notification.getName()){
				case NotList.MEIN_MENU_ONRREGISTER:
					//onRemove();
					onRegister();
					break;
			}
		}
	}
}
package view.mediator
{
	import configuration.Notification.NotList;
	import flash.events.Event;
	import org.puremvc.as3.interfaces.INotification;
	import view.components.LoaderViewLogic;

	public class LoaderMediator extends UIMediator{
		public static const NAME:String = "LoaderMediator";
		private  var _loaderString:String;
		
		public function LoaderMediator(loaderString:String){
			super(NAME,new LoaderViewLogic);
			_loaderString=loaderString;
			viewLogic.addEventListener(NotList.CLICK_BUT_1,clickButton1);
		}
		public function onProgres(index:int):void{
			(viewLogic as LoaderViewLogic).onProgres(index);		
		}
		public function initializeBtnStart():void{
			(viewLogic as LoaderViewLogic).initializeBtn();		
		}
		private function clickButton1(event:Event):void{
			viewLogic.removeEventListener(NotList.CLICK_BUT_1,clickButton1);
			sendNotification(NotList.MEIN_MENU);
			onRemove();	
		}
		override public function listNotificationInterests():Array{
			return [NotList.ON_PROGRES];
		}
		override public function handleNotification(notification:INotification):void{
			switch(notification.getName()){
				case NotList.ON_PROGRES:
					if(notification.getType()==_loaderString){onProgres(notification.getBody() as int)}
					break;
			}
		}
	}
}
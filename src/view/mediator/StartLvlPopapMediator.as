package view.mediator
{
	import configuration.Notification.NotList;
	import org.puremvc.as3.interfaces.INotification;
	import view.components.PopapViewLogic;

	public class StartLvlPopapMediator extends PopapMediator{
		public static const NAME:String = "StartLvlPopapMediator";
		
		public function StartLvlPopapMediator(nameViewLogic:PopapViewLogic, 
											  doNotification:Array=null, 
											  closeNotification:Array=null,
											  modalMode:Boolean=true){
			super(nameViewLogic, doNotification,closeNotification, NAME);
		}
		override public function listNotificationInterests():Array{
			return [NotList.KEYDOWN,NotList.CLOSE_STARTLVLPOPAPMEDIATOR];
		}
		override public function handleNotification(notification:INotification):void{
			switch(notification.getName()){
				case NotList.KEYDOWN:
					var charCod:int= notification.getBody() as int;
					if (13==charCod){super.closePopap();sendNotification(NotList.MONSTER_MOVE)
					}
					break;
				case NotList.CLOSE_STARTLVLPOPAPMEDIATOR:
					super.closePopap();
					break;
			}
		}
	}
}
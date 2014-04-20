package view.mediator
{
	import configuration.Notification.NotList;
	import org.puremvc.as3.interfaces.INotification;
	import view.components.ViewLogic;
	
	public class MonsterMediator extends UIMediator{
		public static const NAME:String = "MonsterMediator";
				
		public function MonsterMediator(locationInt:int){
			super(NAME,new ViewLogic("monster_"+locationInt));			
		}
		public function move():void{
			viewLogic.content.x+=1;
		}
		public function delMonster():void{
			viewLogic.onRemove();
			onRemove();
		}
		override public function listNotificationInterests():Array{
			return [NotList.DEL_MONSTER];
		}
		override public function handleNotification(notification:INotification):void{
			switch(notification.getName()){
				case NotList.DEL_MONSTER:
					viewLogic.onRemove();
					onRemove();
					break;
			}
		}
	}
}
package view.mediator
{	
	import configuration.Notification.NotList;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class RootMediator extends Mediator{
		public static const NAME:String = "RootMediator";
		private var layer0:Sprite = new Sprite;
		private var layer1:Sprite = new Sprite;
		
		public function RootMediator(mainView:Sprite){
			super(NAME, mainView);
			content.addChild(layer0);
			content.addChild(layer1);
	    }
		public function get content():Sprite{
			return viewComponent as Sprite;
		}
		override public function listNotificationInterests():Array{
			return [NotList.ADD_CHILD_TO_ROOT,NotList.ADD_CHILD_TO_LAYER1,NotList.HERO_MOVED];
		}
		override public function handleNotification(notification:INotification):void{
			switch(notification.getName()){
				case NotList.ADD_CHILD_TO_ROOT:
					if(notification.getBody()){
					layer0.addChild(notification.getBody() as DisplayObject);
					}
					break;
				case NotList.ADD_CHILD_TO_LAYER1:
					layer1.addChild(notification.getBody() as DisplayObject);
					break;
				case NotList.HERO_MOVED:
					var heroMoved:Array= notification.getBody() as Array;
					layer0.x=-(heroMoved[0]-400);
					layer0.y=-(heroMoved[1]-350);
					break;
			}
		}
	}
}
package view.mediator
{
	import configuration.Notification.NotList;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import view.components.ViewLogic;

	public class UIMediator extends Mediator{
		
		public function UIMediator(NAME:String,viewElements:ViewLogic):void{
			super(NAME,viewElements);
		}
		public function get viewLogic():ViewLogic {
			return viewComponent as ViewLogic;
		}
		override public function onRegister():void {
			super.onRegister();
			sendNotification(NotList.ADD_CHILD_TO_ROOT,viewLogic.content);
		}
		override public function onRemove():void{
			super.onRemove();
			viewLogic.onRemove();
		}
	}
}
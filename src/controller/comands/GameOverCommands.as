package controller.comands
{
	import configuration.Notification.NotList;
	import model.VO.PopapDoActionVO;
	import org.puremvc.as3.interfaces.INotification;
	import view.components.PopapViewLogic;
	import view.mediator.PopapMediator;

	public class GameOverCommands extends GeneralCommand{
		
		override public function execute(notification:INotification):void{
			statisticsProxy.timerStop();
			facade.removeMediator("HeroMediator");
			facade.registerMediator(new PopapMediator(new PopapViewLogic("GameOver"),[new PopapDoActionVO(NotList.NEWLEVEL),new PopapDoActionVO(NotList.EXIT_TO_MAIN_MENU)]));
		}
	}
}
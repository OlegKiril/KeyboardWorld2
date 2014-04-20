package controller.comands
{
	import configuration.Notification.NotList;
	import model.VO.PopapDoActionVO;
	import org.puremvc.as3.interfaces.INotification;
	import view.components.LvlWinPopapViewLogic;
	import view.mediator.MonsterMediator;
	import view.mediator.PopapMediator;

	public class LevelWinCommand extends GeneralCommand{
	
		override public function execute(notification:INotification):void{	
			statisticsProxy.timerStop();
			gameProxy.setScore(statisticsProxy.getScore());
			gameProxy.notification();
			facade.registerMediator(new PopapMediator(new LvlWinPopapViewLogic("lvlWin",statisticsProxy.statisticsVO),[new PopapDoActionVO(NotList.NEWLEVEL),new PopapDoActionVO(NotList.EXIT_TO_MAIN_MENU)]));
			var monsterMediator:MonsterMediator = facade.retrieveMediator( MonsterMediator.NAME ) as MonsterMediator;
			monsterMediator.delMonster();
			sendNotification(NotList.DEL_MONSTER);
			facade.removeMediator("MonsterMediator");
			facade.removeMediator("LetterMediator");
		}
	}
}
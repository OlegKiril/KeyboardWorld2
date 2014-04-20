package controller.comands
{
	import configuration.Notification.NotList;
	import flash.display.DisplayObjectContainer;
	import org.puremvc.as3.interfaces.INotification;
	import utility.SWFWarehouse;
	import utility.XMLWarehoase;
	import view.mediator.LoaderMediator;
	import view.mediator.MainMenuMediator;

	public class ToMainMenuCommand extends GeneralCommand{
		override public function execute(notification:INotification):void{	
			sendNotification(NotList.CLOSE_STARTLVLPOPAPMEDIATOR);
			statisticsProxy.timerStop();
			facade.removeMediator("GameOverMediator");
			facade.removeMediator("HeroMediator");
			facade.removeMediator("BackgroundMediator");
			var loaderMediator:LoaderMediator = facade.retrieveMediator( LoaderMediator.NAME ) as LoaderMediator;
			if(loaderMediator){
			   loaderMediator.onRemove();
			   facade.removeMediator("LoaderMediator");
			}
			gameModProxy.setGameMod(false);
			gameModProxy.setLoaderMod();
			gameProxy.setError(5);
				var lettersArrayLength:int= gameProxy.getLettersArraylength();
				if(gameProxy.getLettersArray()&&lettersArrayLength!==0){
				for (var i:int=0; i<lettersArrayLength; i++){
					gameProxy.shiftLettersArray();
					facade.removeMediator("Mediator"+(gameProxy.userVO.lettersArrayVoLenth-gameProxy.userVO.lettersArrayVo.length-1));
					facade.removeMediator("LetterMediator");
				}
			}
				sendNotification(NotList.MEIN_MENU_ONRREGISTER);
				var level:int=gameProxy.userVO.level;
				var myXML:XML=XMLWarehoase.getInstance().getAssetXML("Game_control");				
				var lvlForNewLocation:int=myXML.attribute("lvl_for_new_location");	
				var mainMenuMediator:MainMenuMediator = facade.retrieveMediator( MainMenuMediator.NAME ) as MainMenuMediator;
				for (var j:int=0; j<6; j++) {
					var icon:DisplayObjectContainer=SWFWarehouse.getInstance().getAsset("gameIcon_"+j) as DisplayObjectContainer;
					var isClose:Boolean = true;
					if (level>=j*lvlForNewLocation){isClose=false}
					mainMenuMediator.updateIcon(j,isClose);
				}			
			sendNotification(NotList.USERDATA,gameProxy.userVO);
		}
	}
}
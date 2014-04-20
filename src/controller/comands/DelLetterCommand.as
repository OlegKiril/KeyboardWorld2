package controller.comands
{
	import configuration.Notification.NotList;
	import org.puremvc.as3.interfaces.INotification;
	import view.components.ViewLogic;
	import view.mediator.LetterMediator;
	import view.mediator.UIMediator;

	public class DelLetterCommand extends GeneralCommand{
		
		override public function execute(notification:INotification):void{	
			if(gameModProxy&&gameModProxy.getGameMod()){
				statisticsProxy.setNumberCharacters();
				var letter:String= notification.getBody() as String;
			    if (gameProxy.userVO.lettersArrayVo[0]==letter){
					facade.removeMediator("BangMediator");
				gameProxy.shiftLettersArray();
				var letterMediator:LetterMediator= facade.retrieveMediator("Mediator"+(gameProxy.userVO.lettersArrayVoLenth-gameProxy.userVO.lettersArrayVo.length-1)) as LetterMediator;
				facade.registerMediator(new UIMediator("BangMediator",new ViewLogic("bang")));
				var bang:UIMediator = facade.retrieveMediator("BangMediator") as UIMediator;
				bang.viewLogic.content.x=letterMediator.viewLogic.content.x-25;
				bang.viewLogic.content.y=letterMediator.viewLogic.content.y-25;
				facade.removeMediator("Mediator"+(gameProxy.userVO.lettersArrayVoLenth-gameProxy.userVO.lettersArrayVo.length-1));				
			}else{
				if(letter){
				statisticsProxy.setErrors();
				gameProxy.setErrorInt();
				gameProxy.notification();
				if(gameProxy.getErrorInt()==0){
					gameModProxy.setGameMod(false);
					sendNotification(NotList.GAMEOVER);
				 }
			   }
			}
			    if (!gameProxy.userVO.lettersArrayVo.length){
					gameModProxy.setGameMod(false);
					gameProxy.setLevel();
					sendNotification(NotList.LEVEL_WIN);
					sendNotification(NotList.USERDATA,gameProxy.userVO)
				}
			}
		}
	}
}
package facade
{	
	import configuration.Notification.NotList;
	
	import controller.comands.*;
	
	import flash.display.Sprite;
	
	import org.puremvc.as3.patterns.facade.Facade;
	
	
	
	public class ApplicationFacade extends Facade{ 
		public static function getInstance(): ApplicationFacade {
			if( !instance ) instance = new ApplicationFacade();
			return instance as ApplicationFacade;
		}
		public function startup(  mainView:Sprite):void {
			sendNotification (NotList.STARTUP,mainView);
		}
		override protected function initializeController():void {
			super.initializeController();
			registerCommand(NotList.STARTUP,StartupCommands);
			registerCommand(NotList.MEIN_MENU,StartGameCommands);
			registerCommand(NotList.REGISTER_NEW_USER,RegistrationUserCommand);
			registerCommand(NotList.CHECK_LOGIN,ChecLoginUserCommand);
			registerCommand(NotList.USER_REGISTERED,NewUserCommand);
			registerCommand(NotList.USER_ENTERED,MainMenuBuildCommand);
			registerCommand(NotList.NEWLEVEL, NewLevelCommand);
			registerCommand(NotList.NEWTEXTARRAY,NewLetterFieldCommand);
			registerCommand(NotList.MONSTER_MOVE, MonsterCommand);
			registerCommand(NotList.KEYDOWN,DelLetterCommand);
			registerCommand(NotList.LEVEL_WIN,LevelWinCommand);
			registerCommand(NotList.EXIT_TO_MAIN_MENU,ToMainMenuCommand);
			registerCommand(NotList.GAMEOVER, GameOverCommands);
			registerCommand(NotList.SEND_MESSAGE, SendMessageCommand);
		}
	}
}
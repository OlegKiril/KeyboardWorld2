package controller.comands
{
	import configuration.Notification.NotList;
	
	import model.VO.GameModVO;
	import model.VO.PopapDoActionVO;
	import model.VO.StatisticsVO;
	import model.proxy.GameModProxy;
	import model.proxy.ServerProxy;
	import model.proxy.SharedObjectProxy;
	import model.proxy.StatisticsProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	
	import view.components.LoginPopapViewLogic;
	import view.mediator.LoginPopapMediator;
	import view.mediator.MainMenuMediator;
	import view.mediator.UserPanelMediator;

	public class StartGameCommands extends GeneralCommand{
		
		override public function execute(notification: INotification):void{
			super.execute(notification);
			facade.registerProxy(new SharedObjectProxy());
			//facade.registerProxy(new ServerProxy());
			facade.registerProxy(new StatisticsProxy(new StatisticsVO));
			facade.registerProxy(new GameModProxy(new GameModVO));
			facade.registerMediator(new MainMenuMediator);
			facade.registerMediator(new UserPanelMediator);
			facade.registerMediator(new LoginPopapMediator(new LoginPopapViewLogic("LoginPopap"),[new PopapDoActionVO(NotList.CHECK_LOGIN,{additionalData:null},null,false),
				                                                                                  new PopapDoActionVO( NotList.REGISTER_NEW_USER,{additionalData:null},null,false)]));
		}
	}
}
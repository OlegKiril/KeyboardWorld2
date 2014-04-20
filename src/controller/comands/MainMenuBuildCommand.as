package controller.comands
{
	import flash.display.DisplayObjectContainer;
	import model.VO.UserVO;
	import model.proxy.GameProxy;
	import model.proxy.LettersProxy;
	import org.puremvc.as3.interfaces.INotification;
	import utility.SWFWarehouse;
	import utility.XMLWarehoase;
	import view.mediator.MainMenuMediator;
	
	public class MainMenuBuildCommand extends GeneralCommand{
	
		override public function execute(notification: INotification):void{
			super.execute(notification);
			var userObject:Object= notification.getBody() as Object;				
			var userVO:UserVO=new UserVO;
			for(var i:String in userObject){
				userVO[i] = userObject[i];		
			}
			var level:int=userVO.level;
			facade.registerProxy(new GameProxy(userVO));
			facade.registerProxy(new LettersProxy());
			var myXML:XML=XMLWarehoase.getInstance().getAssetXML("Game_control");				
			var lvlForNewLocation:int=myXML.attribute("lvl_for_new_location");	
				for (var j:int=0; j<6; j++) {
					var icon:DisplayObjectContainer=SWFWarehouse.getInstance().getAsset("gameIcon_"+j) as DisplayObjectContainer;
					var isClose:Boolean = true;
					if (level>=j*lvlForNewLocation){isClose=false}
					var mainMenuMediator:MainMenuMediator = facade.retrieveMediator( MainMenuMediator.NAME ) as MainMenuMediator;
					mainMenuMediator.setIcon(j,icon,isClose);
			}	
				mainMenuMediator.setlvlForNewLocation(lvlForNewLocation);
				gameProxy.notification();
		}
	}
}
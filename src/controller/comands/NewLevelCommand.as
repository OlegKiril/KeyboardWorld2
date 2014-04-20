package controller.comands
{	
	import configuration.Notification.NotList;
	import flash.display.MovieClip;
	import flash.events.Event;
	import model.VO.UserVO;
	import model.proxy.LettersProxy;
	import org.puremvc.as3.interfaces.INotification;
	import utility.MultiLoader;
	import utility.MyDataEvent;
	import utility.SWFWarehouse;
	import utility.XMLWarehoase;
	import view.components.ViewLogic;
	import view.mediator.*;
	
	public class NewLevelCommand extends GeneralCommand{
		private var loaderMod:int;
		private var path:String;
		private var locationInt:int;
		
		override public function execute(notification:INotification):void{
			if(notification.getBody()){
				var index:int= notification.getBody() as int;
			}else{
				index= gameModProxy.getlocationMod();
			}
			var lettersArrayLength:int= gameProxy.getLettersArraylength();
			if(gameProxy.getLettersArray()&&lettersArrayLength!==0){
				for (var i:int=0; i<lettersArrayLength; i++){
					gameProxy.shiftLettersArray();
					facade.removeMediator("Mediator"+(gameProxy.userVO.lettersArrayVoLenth-gameProxy.userVO.lettersArrayVo.length-1));
				}
			}	
			facade.removeMediator("LetterMediator");
			facade.removeMediator("GameOverMediator");
			facade.removeMediator("BackgroundMediator");
			facade.removeMediator("HeroMediator");
			facade.removeMediator("LoaderMediator");
			gameModProxy.setLoaderMod();
			loaderMod=gameModProxy.getLoaderMod();
			facade.registerMediator(new LoaderMediator("loader"+loaderMod));
			var userPanelMediator:UserPanelMediator = facade.retrieveMediator( UserPanelMediator.NAME ) as UserPanelMediator;
			userPanelMediator.onRegister();
			var myXML:XML=XMLWarehoase.getInstance().getAssetXML("Graphics_path");	
			locationInt=index;		
			switch(index){
				case 0 : if(gameModProxy.getLocation0LoaderMod()==false){var path0:String = myXML.attribute("Level_0"); dovnloadLevel(path0);}else{levelGo()} break;
				case 1 : if(gameModProxy.getLocation1LoaderMod()==false){var path1:String = myXML.attribute("Level_1"); dovnloadLevel(path1);}else{levelGo()} break;
				case 2 : if(gameModProxy.getLocation2LoaderMod()==false){var path2:String = myXML.attribute("Level_2"); dovnloadLevel(path2);}else{levelGo()} break;
				case 3 : if(gameModProxy.getLocation3LoaderMod()==false){var path3:String = myXML.attribute("Level_3"); dovnloadLevel(path3);}else{levelGo()} break;
				case 4 : if(gameModProxy.getLocation4LoaderMod()==false){var path4:String = myXML.attribute("Level_4"); dovnloadLevel(path4);}else{levelGo()} break;
				case 5 : if(gameModProxy.getLocation5LoaderMod()==false){var path5:String = myXML.attribute("Level_5"); dovnloadLevel(path5);}else{levelGo()} break;
			}			
		}
			protected function dovnloadLevel(path:String):void{
			var _multiloader:MultiLoader = new MultiLoader;	
			_multiloader.addTask(path);
			_multiloader.start();
			_multiloader.addEventListener(NotList.EVENT_COMPLETE_ITEM, onCompliteItem);
			_multiloader.addEventListener(NotList.TOTAL_PROGRES, totalProgres);
			_multiloader.addEventListener(NotList.EVENT_COMPLETE, onComplite);	
		}
			protected function onCompliteItem(event:Event):void{
				SWFWarehouse.getInstance().addContent(event.target as MultiLoader);
			}
			protected function onComplite(event:Event):void{
				var multiloader:MultiLoader = event.target as MultiLoader;
				multiloader.removeEventListener(NotList.EVENT_COMPLETE, onComplite);
				multiloader.removeEventListener(NotList.EVENT_COMPLETE_ITEM, onCompliteItem);		
				multiloader.removeEventListener(NotList.TOTAL_PROGRES, totalProgres);
				
				switch(locationInt){
					case 0 : gameModProxy.setLocation0LoaderMod(true); break;
					case 1 : gameModProxy.setLocation1LoaderMod(true); break;
					case 2 : gameModProxy.setLocation2LoaderMod(true); break;
					case 3 : gameModProxy.setLocation3LoaderMod(true); break;
					case 4 : gameModProxy.setLocation4LoaderMod(true); break;
					case 5 : gameModProxy.setLocation5LoaderMod(true); break;
				}
				var location:MovieClip = SWFWarehouse.getInstance().getAsset("location_"+locationInt) as MovieClip;				
				if(location){levelGo()}
			}	
			protected function levelGo():void{
				gameModProxy.setlocationMod(locationInt);
				var loaderMediator:LoaderMediator = facade.retrieveMediator( LoaderMediator.NAME ) as LoaderMediator;
				gameProxy.setError(5);				
					facade.registerMediator(new UIMediator("BackgroundMediator",new ViewLogic("background_"+locationInt)));
					if(loaderMediator){
						loaderMediator.onRemove();
						facade.removeMediator("LoaderMediator");
					}
				var _userVO:UserVO = gameProxy.userVO;
				var lettersProxy:LettersProxy = facade.retrieveProxy( LettersProxy.NAME ) as LettersProxy;
				
				gameProxy.setlocationInt(locationInt);
				var location:MovieClip = SWFWarehouse.getInstance().getAsset("location_"+locationInt) as MovieClip;
				
				var j:int=0;
				for (var i:int=0; i<location.numChildren; i++) {
					var plaseForLettersName:Array = location.getChildAt(i).name.split("_");
					var plaseForLetters:String = plaseForLettersName[0];					
					if (plaseForLetters=="point"){
						 j++;
					}
				}			
				lettersProxy.newLettersArray(_userVO.level,j);			
				gameProxy.notification();
				sharedObjectProxy.setUserArraySO(_userVO);
				//serverProxy.sendRequestSaveUserData(_userVO.user_name,_userVO);	
				var userPanelMediator:UserPanelMediator = facade.retrieveMediator( UserPanelMediator.NAME ) as UserPanelMediator;
				userPanelMediator.onRegister();
				statisticsProxy.delLevelData();
			}
			protected function totalProgres(event:MyDataEvent):void{
				sendNotification(NotList.ON_PROGRES,event.data,"loader"+gameModProxy.getLoaderMod());
		}
	}
}
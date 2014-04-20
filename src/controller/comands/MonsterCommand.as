package controller.comands
{
	import configuration.Notification.NotList;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import org.puremvc.as3.interfaces.INotification;
	
	import view.mediator.HeroMediator;
	import view.mediator.MonsterMediator;
	import view.mediator.UIMediator;

	public class MonsterCommand extends GeneralCommand{
		private var _monsterMediator:MonsterMediator;
		private var hero:HeroMediator;
				
		override public function execute(notification:INotification):void{	
			facade.registerMediator(new MonsterMediator(gameModProxy.getlocationMod()));
			_monsterMediator= facade.retrieveMediator( MonsterMediator.NAME ) as MonsterMediator;						
			gameModProxy.setGameMod(true);
			statisticsProxy.timerStart();
			_monsterMediator.viewLogic.content.addEventListener(Event.ENTER_FRAME, onFrame);
			if (gameModProxy.getlocationMod()!==5){
				facade.registerMediator(new HeroMediator(gameModProxy.getlocationMod()));
				hero= facade.retrieveMediator( HeroMediator.NAME ) as HeroMediator;
			}else{
				sendNotification(NotList.LEVEL_5_PLAY);
			}				
		}		
		private function onFrame(event:Event):void {					
			if(gameModProxy.getlocationMod()!==5){heroHitTestObject();}else{letterHitTestObject();}
			var _hero:MovieClip = hero.viewLogic.content["hero"] as MovieClip;
			/*if (_hero.x>600){*/
			//trace(_hero.x);
			//trace(_hero.y);
		//	sendNotification(NotList.HERO_MOVED,[_hero.x,_hero.y]);
			//}
		}		
		private function heroHitTestObject():void{
				if (gameModProxy.getlocationMod()==0||gameModProxy.getlocationMod()==1||gameModProxy.getlocationMod()==2){
					var monster:MovieClip=_monsterMediator.viewLogic.content["pointHitTest_"+gameModProxy.getlocationMod()];
					monster.visible=false;
				}else{
					 monster=_monsterMediator.viewLogic.content as MovieClip;
				}					
			if(gameModProxy.getGameMod()==false){
				_monsterMediator.viewLogic.content.removeEventListener(Event.ENTER_FRAME, onFrame);
				sendNotification(NotList.DEL_MONSTER);
				facade.removeMediator("MonsterMediator");
			}else{			
			if(monster.hitTestObject(hero.viewLogic.content)){
				gameModProxy.setGameMod(false);
				sendNotification(NotList.GAMEOVER);
			   }
			}
			var letter:UIMediator=facade.retrieveMediator("Mediator"+(gameProxy.userVO.lettersArrayVoLenth-gameProxy.userVO.lettersArrayVo.length)) as UIMediator;	
			if(gameModProxy.getGameMod()==true&&hero.viewLogic.content.hitTestObject(letter.viewLogic.content)){
				hero.heroStop();
			}else{
				hero.heroPlay();
			}
		}
			private function letterHitTestObject():void{
				var monster:MovieClip=_monsterMediator.viewLogic.content as MovieClip;
				var letter:UIMediator=facade.retrieveMediator("Mediator"+(gameProxy.userVO.lettersArrayVoLenth-gameProxy.userVO.lettersArrayVo.length)) as UIMediator;	
				if(gameModProxy.getGameMod()==false){
					_monsterMediator.viewLogic.content.removeEventListener(Event.ENTER_FRAME, onFrame);
					sendNotification(NotList.DEL_MONSTER);
					facade.removeMediator("MonsterMediator");
				}else{			
					if(monster.hitTestObject(letter.viewLogic.content)){
						gameModProxy.setGameMod(false);
						sendNotification(NotList.GAMEOVER);
					}
				}
			}
	}
}
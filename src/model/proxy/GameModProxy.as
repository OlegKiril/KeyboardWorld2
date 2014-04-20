package model.proxy
{
	import model.VO.GameModVO;
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class GameModProxy extends Proxy{
		public static const NAME:String = "GameModProxy"
			
		public function GameModProxy(gameModVO:GameModVO){
			super(NAME,gameModVO);
		    }
			public function get gameModVO( ):GameModVO {  
				return data as GameModVO;  
			}
			public function setGameMod(gameMod:Boolean):void {  
				gameModVO.gameMod=gameMod; 
			}
			public function getGameMod():Boolean {  
				return gameModVO.gameMod; 
			}
			public function setLoaderMod():void {  
				gameModVO.loaderMod++; 
			}
			public function getLoaderMod():int {  
				return gameModVO.loaderMod; 
		    }
			public function setlocationMod(index:int):void {  
				gameModVO.locationMod=index; 
			}
			public function getlocationMod():int {  
				return gameModVO.locationMod; 
			}
			public function setLocation0LoaderMod(location0LoaderMod:Boolean):void {  
				gameModVO.location0LoaderMod=location0LoaderMod; 
			}
			public function getLocation0LoaderMod():Boolean {  
				return gameModVO.location0LoaderMod; 
			}
			public function setLocation1LoaderMod(location1LoaderMod:Boolean):void {  
				gameModVO.location1LoaderMod=location1LoaderMod; 
			}
			public function getLocation1LoaderMod():Boolean {  
				return gameModVO.location1LoaderMod; 
			}
			public function setLocation2LoaderMod(location2LoaderMod:Boolean):void {  
				gameModVO.location2LoaderMod=location2LoaderMod; 
			}
			public function getLocation2LoaderMod():Boolean {  
				return gameModVO.location2LoaderMod; 
			}
			public function setLocation3LoaderMod(location3LoaderMod:Boolean):void {  
				gameModVO.location3LoaderMod=location3LoaderMod; 
			}
			public function getLocation3LoaderMod():Boolean {  
				return gameModVO.location3LoaderMod; 
			}
			public function setLocation4LoaderMod(location4LoaderMod:Boolean):void {  
				gameModVO.location4LoaderMod=location4LoaderMod; 
			}
			public function getLocation4LoaderMod():Boolean {  
				return gameModVO.location4LoaderMod; 
			}
			public function setLocation5LoaderMod(location5LoaderMod:Boolean):void {  
				gameModVO.location5LoaderMod=location5LoaderMod; 
			}
			public function getLocation5LoaderMod():Boolean {  
				return gameModVO.location5LoaderMod; 
			}
			
	}
}
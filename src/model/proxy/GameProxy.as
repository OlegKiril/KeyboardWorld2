package model.proxy
{
	import configuration.Notification.NotList;
	import model.VO.UserVO;
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class GameProxy extends Proxy{
		public static const NAME:String = "GameProxy";
				
		public function GameProxy(userVO:UserVO){
			super(NAME,userVO);
		}
		override public function onRegister():void {
			super.onRegister();
		}
		public function get userVO( ) : UserVO {  
			return data as UserVO;  
		}
		public function setLevel() : void {  
			userVO.level++; 
		}
		public function getLevel():int {  
			return userVO.level; 
		}
		public function newLettersArray(lettersArray:Array) : void {			
			userVO.lettersArrayVo=lettersArray; 			
		}
		public function newLettersArrayLength(lettersArray:Array) : void {			
			userVO.lettersArrayVoLenth=lettersArray.length;
		}
		public function getLettersArray():Array {			
			return userVO.lettersArrayVo; 
		}
		public function getLettersArraylength():int {			
			return userVO.lettersArrayVoLenth; 
		}
		public function shiftLettersArray() : void {  
			userVO.lettersArrayVo.shift(); 
		}
		public function getErrorInt():int {  
			return userVO.error; 
		}
		public function setErrorInt(): void {  
			userVO.error--; 
		}
		public function setError(_error:int): void {  
			userVO.error=_error;
		}
		public function setScore(_score:int): void {  
			userVO.score+=_score;
		}
		public function setlocationInt(locationInt:int): void {  
			userVO.locationInt=locationInt;
		}
		public function getlocationInt(): int {  
			return userVO.locationInt;
		}
		public function notification() : void {  
			sendNotification(NotList.USERDATA,userVO);
		}
	}
}
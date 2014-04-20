package model.proxy
{
	import configuration.Notification.NotList;
	import flash.net.SharedObject;
	import model.VO.UserVO;
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class SharedObjectProxy extends Proxy{
		public static const NAME:String = "SharedObjectProxy"
		private var _dataSO:SharedObject = SharedObject.getLocal("_userSO");
		private var _userObject:Object;
		private var _userArraySO:Array = [];
		private var _int:int;
		
		public function SharedObjectProxy(){
			super(NAME);			
		}
		public function searchInSO(loginArray:Array):Object{	
			_userArraySO = _dataSO.data.userArraySO;
			_userObject=null;			
			if(!_userArraySO){_userArraySO = []}
			if (_userArraySO&&_userArraySO.length){
			for(var i:int=0; i<_userArraySO.length; i++){
				for(var j:int=0; j<2; j++){
					if (loginArray[0]==_userArraySO[i][0]){					
						_userObject = _userArraySO[i][1]; _int=i;						
					   }
					}
				}
			}
			return _userObject;
		}
		public function registration(loginArray:Array):void{
			_userObject = searchInSO(loginArray);
			if(_userObject||loginArray[0]==""||loginArray[1]==""||loginArray[0]==" "||loginArray[1]==" "){sendNotification(NotList.USER_WITH_THAT_NAME_EXIST);_userObject=null;
			}else{
				_userObject = new Object;
				_userObject.user_name = loginArray[0];
				_userObject.user_password = loginArray[1];
				var arr:Array = [_userObject.user_name,_userObject];
				_int = _userArraySO.length;
				_userArraySO.push(arr);				
				_dataSO.data.userArraySO = _userArraySO;
				_dataSO.flush();
				//_dataSO.clear();
				sendNotification(NotList.USER_REGISTERED,_userObject); 
			}
		}
		public function attemptToEnter(loginArray:Array):void{
			_userObject = searchInSO(loginArray);
			if(loginArray[0]!==""||loginArray[1]!==""||loginArray[0]!==" "||loginArray[1]!==" "){
			if(_userObject&&_userObject.user_password==loginArray[1]){ sendNotification(NotList.USER_ENTERED,_userObject);
			}else{
				sendNotification(NotList.TRY_EGEIN_OR_REGISTER);_userObject=null; 
			   }
			}
		}
			public function setUserArraySO(userObject:UserVO):void{
				_userArraySO[_int][1]=userObject;
				_dataSO.data.userArraySO = _userArraySO;
				_dataSO.flush();
		}      
	}
}
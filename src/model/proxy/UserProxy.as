package model.proxy
{
	import flash.utils.Proxy;
	
	import model.VO.UserVO;

	public class UserProxy extends Proxy{
		public static const NAME:String = "UserProxy";
		
		public function UserProxy(){
			super(NAME,new UserVO);
		}
		public function UserProxy(){
			
		}
	}
}
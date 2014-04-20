package model.proxy
{
	import model.VO.FlashVarsVO;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class FlashVarsProxy extends Proxy{
		public static const NAME:String = "FlashVarsProxy"
			
		public function FlashVarsProxy(parameters:Object){
			super(NAME, new FlashVarsVO(parameters));
		}
		public function get flashVars():FlashVarsVO{
			return data as FlashVarsVO;
		}
	}
}
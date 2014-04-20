package model.VO
{
	public class FlashVarsVO{
		private var _parameters:Object;
		
		public function FlashVarsVO(parameters:Object){
			_parameters=parameters==null?{}:parameters;
		}
		public function get configXML():String{
			return _parameters.configXML as String;
		}
	}
}
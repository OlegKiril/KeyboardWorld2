package model.VO
{
	public class PopapDoActionVO{
		private var _name:String;
		private var _body:Object;
		private var _type:String;
		private var _isNeedClose:Boolean=true;
		
		public function PopapDoActionVO(notificationName:String=null,notificationBody:Object=null,notificationType:String=null,
										isNeedClose:Boolean=true){
			_name = notificationName;
			_body = notificationBody;
			_type = notificationType;
			_isNeedClose = isNeedClose;
		}
		public function getName():String{
			return _name;
		}
		public function getBody():Object{
			return _body;
		}
		public function setBody(body:Object):void{
			 _body=body;
		}
		public function getType():String{
			return _type;
		}
		public function getisNeedClose():Boolean{
			return _isNeedClose;
		}
	}
}
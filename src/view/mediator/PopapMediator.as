package view.mediator
{
	import configuration.Notification.NotList;
	import model.VO.PopapDoActionVO;
	import org.puremvc.as3.interfaces.INotification;
	import utility.MyDataEvent;
	import view.components.PopapViewLogic;
	
	public class PopapMediator extends ModalUIMediator{
		public static const NAME:String = "PopapMediator";
		private var _modalMode:Boolean;
		private var _doNotification:Array;
		private var _closeNotification:Array;
		private var _name:String;
		private var notificationName:String;
		protected var body:Object;
		
		public function PopapMediator(nameViewLogic:PopapViewLogic, 
									  doNotification:Array=null, 
									  closeNotification:Array=null,
									  name:String=null,
									  modalMode:Boolean=true){
			(_name=name==null?NAME:name);
			(_name=name!==null&&name.length!==0?name:NAME);
			super(_name,nameViewLogic);
			if (doNotification!=null&&doNotification.length!==0){this._doNotification=doNotification}
			if (closeNotification!=null&&closeNotification.length!==0){this._closeNotification=closeNotification}
			if(modalMode==false){setContentLyer0()}
			registerListener();
		}
			protected function registerListener():void{
			viewLogic.addEventListener(NotList.DU_BTN_CLICK,handlerDoBTN);
			viewLogic.addEventListener(NotList.CLOSE_BTN_CLICK,handlerCloseBTN);
		}
			protected function handlerDoBTN(event:MyDataEvent):void{
				var indexDoBtn:Object = event.data.hasOwnProperty('index') ? event.data.index as int : -1;
				var additionalData:Object = event.data.hasOwnProperty('additionalData') ? event.data.additionalData : null;
				if(indexDoBtn!=-1 && _doNotification.length>indexDoBtn){
					var pDAVO:PopapDoActionVO = _doNotification[indexDoBtn] as PopapDoActionVO;
					if (pDAVO.getBody()!==null&&pDAVO.getBody().hasOwnProperty("additionalData")){
						pDAVO.setBody(additionalData);
					}
					sendNotification(pDAVO.getName(),pDAVO.getBody(),pDAVO.getType());
				}
				if (pDAVO.getisNeedClose()==true){closePopap()}
			}
			private function handlerCloseBTN(event:MyDataEvent):void{
				var indexcloseBtn:Object = event.data.hasOwnProperty('index') ? event.data.index as int : -1;
				var additionalData:Object = event.data.hasOwnProperty('additionalData') ? event.data.additionalData : null;
				if(indexcloseBtn!=-1 && _closeNotification!==null && _closeNotification.length>indexcloseBtn){
					var pDAVO:PopapDoActionVO = _closeNotification[indexcloseBtn] as PopapDoActionVO;
					if (pDAVO.getBody()!==null&&pDAVO.getBody().hasOwnProperty("additionalData")){
						pDAVO.setBody(additionalData);
					}
					sendNotification(pDAVO.getName(),pDAVO.getBody(),pDAVO.getType());
				}
				if (pDAVO.getisNeedClose()==true){closePopap()}
			}
			public function closePopap():void{
				viewLogic.removeEventListener(NotList.DU_BTN_CLICK,handlerDoBTN);
				viewLogic.removeEventListener(NotList.CLOSE_BTN_CLICK,handlerCloseBTN);
				viewLogic.onRemove();
				onRemove();
				facade.removeMediator(_name);
		}
			protected function setContentLyer0():void{
				viewLogic.onRemove();
				sendNotification(NotList.ADD_CHILD_TO_ROOT,viewLogic.content);
		}
	}
}
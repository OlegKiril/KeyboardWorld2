package view.components
{
	import configuration.Notification.NotList;
	
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import utility.MyDataEvent;

	public class UserPanelViewLogic extends ViewLogic{
		private var _textFieldChat:TextField=new TextField;
		private var _chatTextFieldSend:TextField=new TextField;
		
		public function UserPanelViewLogic(Graphics:String):void{
			super(Graphics);
			var btn:SimpleButton=content["menuBtn_0"];
			btn.addEventListener(MouseEvent.CLICK,dispatchEvent);
			_textFieldChat=content["ChatTextField"];
			_chatTextFieldSend=content["ChatTextFieldSend"];
			var btnSend:SimpleButton=content["send"];
			btnSend.addEventListener(MouseEvent.CLICK,clickSend);
		}
		public function clickSend(e:MouseEvent):void{			
			dispatchEvent(new MyDataEvent(NotList.SEND_MESSAGE,_chatTextFieldSend.text))
			_chatTextFieldSend.text="";
		}
		public function userData(_UserName:String,_level:int,_life:int,_score:int):void{
			var UserName:TextField=content["nameTxt"];
			UserName.text = _UserName; 
			var level:TextField=content["levelTxt"];
			level.text = _level.toString(); 
			var life:TextField=content["lifeTxt"];
			life.text = _life.toString();
			var score:TextField=content["scoreTxt"];
			score.text = _score.toString(); 
		}
		public function answerMessage(message:String):void{
			_textFieldChat.appendText(message+ "\n" );
			_textFieldChat.scrollV = _textFieldChat.maxScrollV;
		}		
	}
}
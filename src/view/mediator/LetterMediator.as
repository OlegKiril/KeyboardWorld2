package view.mediator
{
	import configuration.Notification.NotList;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import org.puremvc.as3.interfaces.INotification;
	import utility.SWFWarehouse;
	import view.components.ViewLogic;
		
	public class LetterMediator extends UIMediator{
		public static const NAME:String = "LetterMediator";
				private var point:DisplayObjectContainer;
				private var _level:MovieClip;
				
		public function LetterMediator(name:String,newClass:String,i:int,locationInt:int):void{
			var _name:String=name==null? NAME:name;
			var shareInt:int = Math.floor(Math.random()*13 + 1);
			super(_name, new ViewLogic("shar_"+shareInt));	
			var _i:int=i;
			_level = SWFWarehouse.getInstance().getAsset("location_"+locationInt) as MovieClip;
			_level.stop();			
			point = _level["point_"+_i];
			if(locationInt==5){viewLogic.content.addEventListener(Event.ENTER_FRAME, onFrame);}
			viewLogic.content.x=point.x;
			viewLogic.content.y=point.y;	
			var textField:TextField = new TextField();
			textField.x=-7;
			textField.y=-20;
			textField.width=20;
			textField.height=40;			
			var format1:TextFormat = new TextFormat();
			format1.font="Arial";
			format1.size = 30;
			format1.color = 0xFFFFFF;
			format1.bold = true;
			textField.defaultTextFormat = format1;
			textField.text=newClass;
			viewLogic.content.addChild(textField);
		}
		private function onFrame(event:Event):void{
			viewLogic.content.x=point.x;
			viewLogic.content.y=point.y;
		}
		override public function listNotificationInterests():Array{
			return [NotList.LEVEL_5_PLAY,NotList.GAMEOVER,NotList.LEVEL_WIN];
		}
		override public function handleNotification(notification:INotification):void{
			switch(notification.getName()){
				case NotList.LEVEL_5_PLAY:
					_level.play();
					break;
				case NotList.GAMEOVER:
				case NotList.LEVEL_WIN:
					viewLogic.content.removeEventListener(Event.ENTER_FRAME, onFrame);
					_level.stop();
					break;
			}
		}
	}
}
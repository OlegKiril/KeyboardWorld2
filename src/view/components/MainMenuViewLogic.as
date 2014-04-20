package view.components
{
	import configuration.Notification.NotList;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import utility.MyDataEvent;

	public class MainMenuViewLogic extends ViewLogic{
		private var _lvlForNewLocation:int;
		private var btn_0:MovieClip;
		private var btn_1:MovieClip;
		private var btn_2:MovieClip;
		private var btn_3:MovieClip;
		private var btn_4:MovieClip;
		private var btn_5:MovieClip;
		private var movic:MovieClip	;
		private var _url:MovieClip	;
		private var _isClosed:Boolean;
		private var btn_0isClosed:Boolean;
		private var btn_1isClosed:Boolean;
		private var btn_2isClosed:Boolean;
		private var btn_3isClosed:Boolean;
		private var btn_4isClosed:Boolean;
		private var btn_5isClosed:Boolean;
		
		public function MainMenuViewLogic(){
			super("MainMenu");
		}
		public function setIcon(id:int, url:DisplayObjectContainer, isClosed:Boolean):void{			
			var _url:MovieClip = url as MovieClip;
			content.removeChild(content["loader_"+id]);
			content["place_"+id].addChild(_url);
			
			switch(id){
				case 0 : btn_0=_url["btn_"+id] as MovieClip; btn_0.gotoAndStop(1); btn_0.buttonMode=true; addedEventListener(btn_0, isClosed); break;
				case 1 : btn_1=_url["btn_"+id] as MovieClip; btn_1.gotoAndStop(1); btn_1.buttonMode=true; addedEventListener(btn_1, isClosed);break;
				case 2 : btn_2=_url["btn_"+id] as MovieClip; btn_2.gotoAndStop(1); btn_2.buttonMode=true; addedEventListener(btn_2, isClosed);break;
				case 3 : btn_3=_url["btn_"+id] as MovieClip; btn_3.gotoAndStop(1); btn_3.buttonMode=true; addedEventListener(btn_3, isClosed);break;
				case 4 : btn_4=_url["btn_"+id] as MovieClip; btn_4.gotoAndStop(1); btn_4.buttonMode=true; addedEventListener(btn_4, isClosed);break;
				case 5 : btn_5=_url["btn_"+id] as MovieClip; btn_5.gotoAndStop(1); btn_5.buttonMode=true; addedEventListener(btn_5, isClosed);break;
			}				
		}
		public function addedEventListener (btn:MovieClip, isClosed:Boolean):void{ 
				var icon:MovieClip = btn.parent as MovieClip;
			if (isClosed==false){
				var _lock:MovieClip = icon["lock"] as MovieClip; 
				_lock.visible=false;
				btn.addEventListener(MouseEvent.CLICK, btnClickHandler);
				btn.addEventListener(MouseEvent.ROLL_OVER,btnOverHandler);
				btn.addEventListener(MouseEvent.ROLL_OUT,btnOutHandler);
			}else{
				btn.addEventListener(MouseEvent.ROLL_OVER,btnOverHandler);
				btn.addEventListener(MouseEvent.ROLL_OUT,btnOutHandler);	
			}
		}
		public function setlvlForNewLocation(lvlForNewLocation:int):void{
			_lvlForNewLocation=lvlForNewLocation;
		}
		private function btnClickHandler(event:MouseEvent):void{
			
			var btn:MovieClip=event.target as MovieClip;
			btn.gotoAndStop(1);
			removeEventListenerBtn();
			var arr:Array = event.target.name.split("_");				
			var index:int = arr[1].substr(0,1);
			dispatchEvent(new MyDataEvent(NotList.NEW_LOCATION,index));
		}
		private function btnOverHandler(event:MouseEvent):void{
			var btn:MovieClip=event.target as MovieClip;
			btn.gotoAndStop(2);
			var icon:MovieClip = btn.parent as MovieClip;
			var _lock:MovieClip = icon["lock"] as MovieClip;
			if(_lock.visible==true){
			var movicWithText:MovieClip=icon["movic"] as MovieClip;
			movicWithText.gotoAndPlay("start");
			var btnName:String = btn.name;
			var arr:Array = btnName.split("_");				
			var index:int = arr[1].substr(0,1);
			var elementForText:MovieClip=movicWithText["ElementForText"] as MovieClip;
			var textField:TextField = elementForText["textField"] as TextField;
			textField.text="From Level "+index*_lvlForNewLocation;	
			}
		}
		private function btnOutHandler(event:MouseEvent):void{
			var btn:MovieClip=event.target as MovieClip;
			btn.gotoAndStop(1);
			var icon:MovieClip = btn.parent as MovieClip;
			var _lock:MovieClip = icon["lock"] as MovieClip;
			if(_lock.visible==true){
			var movicWithText:MovieClip=icon["movic"] as MovieClip;
			movicWithText.gotoAndPlay("backup");
			}
		}
		public function updateIcon(id:int, isClosed:Boolean):void{
			switch(id){
				case 0 : var btn:MovieClip=btn_0; var icon:DisplayObjectContainer = btn.parent; break;
				case 1 : btn=btn_1 as MovieClip; icon = btn.parent; break;
				case 2 : btn=btn_2 as MovieClip; icon = btn.parent; break;
				case 3 : btn=btn_3 as MovieClip; icon = btn.parent; break;
				case 4 : btn=btn_4 as MovieClip; icon = btn.parent; break;
				case 5 : btn=btn_5 as MovieClip; icon = btn.parent; break;
			}					
			if (isClosed==false){
				var _lock:MovieClip = icon["lock"] as MovieClip; 
				_lock.visible=false;
				btn.addEventListener(MouseEvent.CLICK, btnClickHandler);
				btn.addEventListener(MouseEvent.ROLL_OVER,btnOverHandler);
				btn.addEventListener(MouseEvent.ROLL_OUT,btnOutHandler);
			}else{
				btn.addEventListener(MouseEvent.MOUSE_OVER,btnOverHandler);
				btn.addEventListener(MouseEvent.MOUSE_OUT,btnOutHandler);
			}
		}
		private function removeEventListenerBtn():void{
			btn_0.removeEventListener(MouseEvent.CLICK, btnClickHandler);
			btn_0.removeEventListener(MouseEvent.ROLL_OVER,btnOverHandler);
			btn_0.removeEventListener(MouseEvent.ROLL_OUT,btnOutHandler);
			btn_1.removeEventListener(MouseEvent.CLICK, btnClickHandler);
			btn_1.removeEventListener(MouseEvent.ROLL_OVER,btnOverHandler);
			btn_1.removeEventListener(MouseEvent.ROLL_OUT,btnOutHandler);
			btn_2.removeEventListener(MouseEvent.CLICK, btnClickHandler);
			btn_2.removeEventListener(MouseEvent.ROLL_OVER,btnOverHandler);
			btn_2.removeEventListener(MouseEvent.ROLL_OUT,btnOutHandler);
			btn_3.removeEventListener(MouseEvent.CLICK, btnClickHandler);
			btn_3.removeEventListener(MouseEvent.ROLL_OVER,btnOverHandler);
			btn_3.removeEventListener(MouseEvent.ROLL_OUT,btnOutHandler);
			btn_4.removeEventListener(MouseEvent.CLICK, btnClickHandler);
			btn_4.removeEventListener(MouseEvent.ROLL_OVER,btnOverHandler);
			btn_4.removeEventListener(MouseEvent.ROLL_OUT,btnOutHandler);
			btn_5.removeEventListener(MouseEvent.CLICK, btnClickHandler);
			btn_5.removeEventListener(MouseEvent.ROLL_OVER,btnOverHandler);
			btn_5.removeEventListener(MouseEvent.ROLL_OUT,btnOutHandler);
		}
	}
}
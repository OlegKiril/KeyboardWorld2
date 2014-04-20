package view.components
{
	import configuration.Notification.NotList;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class LoaderViewLogic extends ViewLogic{
		private var _button:SimpleButton;
		
		public function LoaderViewLogic(){
			super("LoaderView");
			_button = content["btnStart"] as SimpleButton;
	        _button.visible=false;
		}
		public function onProgres(index:int):void{
			content["DownloadProgress1"].x=+(index*3);
		}
		public function initializeBtn():void{
			_button.visible=true;			
			_button.addEventListener(MouseEvent.CLICK, click); 
		}
		private function click(event:MouseEvent):void {
			_button.removeEventListener(MouseEvent.CLICK, click); 
			dispatchEvent(new Event (NotList.CLICK_BUT_1));
		}
	}
}
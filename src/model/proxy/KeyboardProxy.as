package model.proxy
{	
	import configuration.Notification.NotList;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class KeyboardProxy extends Proxy{
		public static const NAME:String = "KeyboardProxy";
		
		public function KeyboardProxy(mainView:Sprite) {
			super(NAME, mainView);
		}
		override public function onRegister():void {
		super.onRegister();
		(getData() as Sprite).stage.tabChildren = false;
		(getData() as Sprite).stage.addEventListener(KeyboardEvent.KEY_DOWN, HandlerKeyboard);
	    (getData() as Sprite).addEventListener(KeyboardEvent.KEY_UP, HandlerKeyboard);
		}
		private function HandlerKeyboard(event:KeyboardEvent):void {
			trace(event.currentTarget.name + " hears key press: " +         String.fromCharCode(event.charCode) + " (key code: " +         event.keyCode + " character code: " + event.charCode + ")");
			if (event.keyCode >= 65 && event.keyCode<=90 || event.keyCode==32){
			facade.sendNotification (NotList.KEYDOWN,String.fromCharCode(event.charCode));
			}
			if (event.keyCode <= 65 || event.keyCode>=90){ 
				facade.sendNotification (NotList.KEYDOWN,event.keyCode);
			}
		}
	}
}
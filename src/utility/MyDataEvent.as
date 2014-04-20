package utility
{
	import flash.events.Event;
		
	public class MyDataEvent extends Event{
		public var data:*;
		
		public function MyDataEvent(type:String, data:* = null, bubbles:Boolean = false, cancelable:Boolean = false){
			super(type, bubbles, cancelable);
			this.data = data;
		}		
	}
}
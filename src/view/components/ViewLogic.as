package view.components
{
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	import utility.SWFWarehouse;

	public class ViewLogic extends EventDispatcher{
		private var _graphics:DisplayObjectContainer;
		
		public function ViewLogic(name:String):void {
			_graphics = SWFWarehouse.getInstance().getAsset(name);
		}	
		public function get content(): DisplayObjectContainer{
			return _graphics as  DisplayObjectContainer;
		}
		public function onRemove():void {
			if( content && content.parent ){
				content.parent.removeChild(content);}
		}
	}
}
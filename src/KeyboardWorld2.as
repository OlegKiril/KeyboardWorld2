package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import facade.ApplicationFacade;
	
	
	[SWF(width=800,height=700)]
	public class KeyboardWorld2 extends Sprite
	{
		public function KeyboardWorld2()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);	
		}
		private function onAddedToStage(event:Event):void {
			ApplicationFacade.getInstance().startup(this);
		}
	}
}
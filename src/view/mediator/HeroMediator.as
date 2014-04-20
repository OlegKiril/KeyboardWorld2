package view.mediator
{
	import flash.display.MovieClip;
	
	import view.components.ViewLogic;

	public class HeroMediator  extends UIMediator{
		public static const NAME:String = "HeroMediator";
		
		public function HeroMediator(locationInt:int){
			super(NAME,new ViewLogic("hero_"+locationInt));
		}
		public function delHero():void{
			viewLogic.onRemove();
			onRemove();
		}
		public function heroStop():void{
			var hero:MovieClip=viewLogic.content as MovieClip
			hero.stop();
		}
		public function heroPlay():void{
			var hero:MovieClip=viewLogic.content as MovieClip
			hero.play();
		}
	}
}
package view.components
{
	import flash.display.MovieClip;
	import flash.text.TextField;

	public class LoginPopapViewLogic extends PopapViewLogic{
			
		public function LoginPopapViewLogic(sprite:String){
			super(sprite);
			var text2:MovieClip = content["Text2"];
			text2.visible = false;
			var text3:MovieClip = content["Text3"];
			text3.visible = false;
			var text4:TextField = content["noConnection"];
			text4.visible = false;
		}
		public function text2():void{
			var text1:MovieClip = content["Text1"];
			text1.visible = false;
			var text2:MovieClip = content["Text2"];
			text2.visible = true;
			var text3:MovieClip = content["Text3"];
			text3.visible = false;
			var text4:TextField = content["noConnection"];
			text4.visible = false;
		}
		public function text3():void{
			var text1:MovieClip = content["Text1"];
			text1.visible = false;
			var text2:MovieClip = content["Text2"];
			text2.visible = false;
			var text3:MovieClip = content["Text3"];
			text3.visible = true;
			var text4:TextField = content["noConnection"];
			text4.visible = false;
		}
		public function text4():void{
			var text1:MovieClip = content["Text1"];
			text1.visible = false;
			var text2:MovieClip = content["Text2"];
			text2.visible = false;
			var text3:MovieClip = content["Text3"];
			text3.visible = false;
			var text4:TextField = content["noConnection"];
			text4.visible = true;
		}
	}
}
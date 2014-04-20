package model.proxy
{
	import configuration.Notification.NotList;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class LettersProxy extends Proxy{
		public static const NAME:String = "LettersProxy";
				
		public function LettersProxy(){
			super(NAME);
		}
		override public function onRegister():void {
			super.onRegister();
		}
			public function newLettersArray(_level:int,plaseForLetters:int):void{
			var level:int = _level;
			var letters:Array = ["f"," ", "j", "k", "d", "l", "s", "a", "h"," ", "g", "t", "y", "r", "e"," ", "w", "q", "u", "i", "o", " ","p", "b", "n", "v", " ","m", "c", "x", "z"];
			var shuffledLetters:Array = new Array(10);
			var emptySlots:Array = new Array();
			for (var n:int = 0; n < plaseForLetters; n++){
				emptySlots.push(n);
			}
			var randomPos:Number = 0;
			var actualSlot:Number = 0;
			for (var k:int = 0; k < plaseForLetters; k++){
				randomPos = int(Math.random() * emptySlots.length);    
				actualSlot = emptySlots[randomPos];
				var j:int = (Math.random() * (2+level));
				shuffledLetters[actualSlot] = letters[j];
				emptySlots.splice(randomPos, 1);//заполняет пустые слоты
				if (shuffledLetters[0]==" ")shuffledLetters[0]=letters[1];
			}
			sendNotification(NotList.NEWTEXTARRAY,shuffledLetters);
		}	
	}
}

package controller.comands
{
	import flash.display.MovieClip;
	import org.puremvc.as3.interfaces.INotification;
	import utility.SWFWarehouse;
	import view.components.PopapViewLogic;
	import view.mediator.LetterMediator;
	import view.mediator.StartLvlPopapMediator;

	public class NewLetterFieldCommand extends GeneralCommand{
		
		override public function execute(notification:INotification):void{
			var lettersArray:Array= notification.getBody() as Array;
			gameProxy.newLettersArray(lettersArray);
			gameProxy.newLettersArrayLength(lettersArray);		
			var level:MovieClip = SWFWarehouse.getInstance().getAsset("location_"+gameProxy.getlocationInt()) as MovieClip;			
			for (var i:int=0; i<lettersArray.length; i++){
			facade.registerMediator(new LetterMediator("Mediator"+i,lettersArray[i],i,gameProxy.getlocationInt())); 
			}
			facade.registerMediator(new StartLvlPopapMediator(new PopapViewLogic("pleasePressEnterPopap")));
		}
	}
}
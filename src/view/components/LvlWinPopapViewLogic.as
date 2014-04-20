package view.components
{
	import flash.text.TextField;
	
	import model.VO.StatisticsVO;
	
	public class LvlWinPopapViewLogic extends PopapViewLogic{
		
		public function LvlWinPopapViewLogic(sprite:String,statisticsVO:StatisticsVO){
			super(sprite);
			var timeLevel:TextField = content["timeLevel"] as TextField;
			timeLevel.text=statisticsVO.timeLevel;
			var numberCharacters:TextField = content["numberCharacters"];
			numberCharacters.text=statisticsVO.numberCharacters.toString();
			var inputRate:TextField = content["inputRate"];
			inputRate.text=statisticsVO.inputRate.toString();
			var errors:TextField = content["errors"];
			errors.text=statisticsVO.errors.toString();
			var percentageOfErrors:TextField = content["percentageOfErrors"];
			percentageOfErrors.text=statisticsVO.percentageOfErrors;
			var smoothEntry:TextField = content["smoothEntry"];
			smoothEntry.text=statisticsVO.smoothEntry.toString();
			var score:TextField = content["score"];
			score.text=statisticsVO.score.toString();			
		}
	}
}
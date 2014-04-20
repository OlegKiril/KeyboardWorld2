package model.proxy
{
	import configuration.Notification.NotList;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import model.VO.StatisticsVO;
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class StatisticsProxy extends Proxy{
		public static const NAME:String = "StatisticsProxy";
		private var _timer:Timer;
		private var _timeLevel:Number;
		private var _period:Array=[];
						
		public function StatisticsProxy(statisticsVO:StatisticsVO){
			super(NAME,statisticsVO);
		}
		override public function onRegister():void {
			super.onRegister();
		}
		public function get statisticsVO( ) : StatisticsVO {  
			return data as StatisticsVO;  
		}
		public function timerStart():void { 
			_timer = new Timer(100);
			_timer.start();
			_timer.addEventListener(TimerEvent.TIMER, onTick); 
		}
		public function onTick(event:TimerEvent):void {  
			_timeLevel = event.target.currentCount;
		}
		public function timerStop():void {  
			if(_timer){_timer.stop();_timer.removeEventListener(TimerEvent.TIMER, onTick);}
			setTimeLevel();
			setInputRate();
			setPercentageOfErrors();
			setSmoothEntry();
			setScore();
			sendNotification(NotList.STATISTICS,statisticsVO);
		}
		public function setTimeLevel():void {  
			var currentTimeLevel:Number=_timeLevel/10;
			var tenthsOfSecond:Number=_timeLevel-(currentTimeLevel*10);
			statisticsVO.timeLevel=currentTimeLevel.toString()+tenthsOfSecond.toString();
		}
		public function setNumberCharacters():void {  
			statisticsVO.numberCharacters++; 
			_period.push(_timeLevel);
		}
		public function setInputRate():void {
			statisticsVO.inputRate= 600*statisticsVO.numberCharacters/_timeLevel;
		}
		public function setErrors():void {  
			statisticsVO.errors++; 
		}
		public function setPercentageOfErrors():void {  			
			var beforePoint:int = statisticsVO.errors*100/statisticsVO.numberCharacters;
			var X:int=statisticsVO.errors*1000/statisticsVO.numberCharacters;
			var Y:int=beforePoint*10;
			var afterPoint:int = X-Y;
			 statisticsVO.percentageOfErrors= beforePoint+","+afterPoint+"0";
		}
		public function setSmoothEntry():void {  
			for (var i:int=1; i<_period.length; i++){
				statisticsVO.smoothEntry+=_period[i]-_period[i-1];
			}
		}
		public function setScore():void { 
			var currentErrors:Number=statisticsVO.errors+1;
			statisticsVO.score=statisticsVO.numberCharacters*10000/currentErrors/_timeLevel-statisticsVO.smoothEntry+1000;
		}
		public function getScore():int { 
			return statisticsVO.score;
		}
		public function delLevelData():void {  
			statisticsVO.numberCharacters=0;
			statisticsVO.inputRate=0;
			statisticsVO.errors=0;
			statisticsVO.smoothEntry=0;
			statisticsVO.score=0; 
		}
	}
}
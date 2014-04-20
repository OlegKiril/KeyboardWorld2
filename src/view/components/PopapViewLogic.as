package view.components
{
	import configuration.Notification.NotList;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import utility.MyDataEvent;
		
	public class PopapViewLogic extends ViewLogic{
		private var _body:Array = new Array;
		
		public function PopapViewLogic(_sprite:String){
			super(_sprite);
			content.x=400;
			content.y=350;
			for (var i:int=0; i<content.numChildren; i++) {
				if (content.getChildAt(i).toString()=="[object SimpleButton]"){
					content.getChildAt(i).addEventListener(MouseEvent.CLICK, btnClickHandler);
				}
		    }
		}
	protected function btnClickHandler(event:MouseEvent):void{
		for (var i:int=0; i<content.numChildren; i++) {
			if (content.getChildAt(i).toString()=="[object TextField]"){
				var textFieldName:String = content.getChildAt(i).name; 
				var arrText:Array = textFieldName.split("_");
				if(arrText[0]=="text"){
					var textIndex:int = arrText[1];
					_body[textIndex] = (content.getChildAt(i) as TextField).text;
				}
			}
		}
		var btnName:String = event.target.name; 
		var arrBtn:Array = btnName.split("_");
		var btnIndex:int = arrBtn[1];
		if (arrBtn[0]=="doBtn"){dispatchEvent(new MyDataEvent(NotList.DU_BTN_CLICK,{index:btnIndex,additionalData:_body}))}
		if (arrBtn[0]=="closeBtn"){dispatchEvent(new MyDataEvent(NotList.CLOSE_BTN_CLICK,{index:btnIndex,additionalData:_body}))};				
		}	
	protected function removeEventListenerBtn():void{
		for (var i:int=0; i<content.numChildren; i++) {
			if (content.getChildAt(i).toString()=="[object SimpleButton]"){
			content.getChildAt(i).removeEventListener(MouseEvent.CLICK, btnClickHandler);
			}
		  }
	   }
	}
}
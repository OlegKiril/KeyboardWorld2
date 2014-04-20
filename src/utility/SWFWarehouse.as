package utility
{
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;

	public class SWFWarehouse extends EventDispatcher{		
		private static var _instance:SWFWarehouse;
		private var swfList:Array = new Array();
			
		public function getAsset(assetsName:String):DisplayObjectContainer{			
			for (var i:int=0; i<swfList.length; i++){
				if (swfList[i].contentLoaderInfo.applicationDomain.hasDefinition(assetsName)==true){
				    var assetClass:Class = swfList[i].contentLoaderInfo.applicationDomain.getDefinition(assetsName) as Class;
					 var dis_obj:DisplayObjectContainer = new assetClass();	
			   }
			}
			return  dis_obj;
		}
		public function getAssetClass(assetsName:String):Class{
			for (var i:int=0; i<swfList.length; i++){
				if (swfList[i].contentLoaderInfo.applicationDomain.hasDefinition(assetsName)==true){
					var assetClass:Class = swfList[i].contentLoaderInfo.applicationDomain.getDefinition(assetsName) as Class;
				}
			}
			return assetClass;
		}
		static public function getInstance():SWFWarehouse{
			if (_instance == null){
				_instance = new SWFWarehouse();
			}
			return _instance;
		}	
		public function addContent(multiloader:MultiLoader):void{
			swfList.push(multiloader._assetLoader.contentLoaderInfo.loader);
		}
	}
}
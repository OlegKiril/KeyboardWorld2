package utility
{
	public class XMLWarehoase
	{
		private static var _instance:XMLWarehoase;
		private var xmlList:Array = new Array();
		
		public function getAssetXML(assetsName:String):XML{
			for (var i:int=0; i<xmlList.length; i++){
				var myXML:XML = new XML(xmlList[i].data);
				if (myXML.hasOwnProperty(assetsName)){
					var assetXML:XML=myXML[assetsName][0]; 
				}
			}
			return assetXML;
		}
		static public function getInstance():XMLWarehoase{
			if (_instance == null){
				_instance = new XMLWarehoase();
			}
			return _instance;
		}	
		public function addContent(multiloader:MultiLoader):void{
			xmlList.push(multiloader._assetURLLoader);
		}
	}
}
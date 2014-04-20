package utility {
	import configuration.Notification.NotList;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
		
	public class MultiLoader extends  EventDispatcher {
		private var load_arr:Array = new Array();
		private var arrLenth:int;
		private var i:int=0;
		public var _assetLoader:Loader;
		public var _assetURLLoader:URLLoader;
		
		public function addTask(url:String):void{
			load_arr.push(url);
		} 
		public function start ():void {
			loadNextItem ();
		}
		public function loadNextItem ():void {
			if (i==0){arrLenth = load_arr.length; i++}
			loadAssets(load_arr[0]);
			load_arr.shift();
		}
		public function loadAssets(path:String):void{
			_assetLoader=new Loader();
			var _path:String = path+"?nocache="+Math.random();
			var urlRequest:URLRequest = new URLRequest(path);
			_assetLoader.load(urlRequest);
			_assetLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, handlerComplete);
			_assetLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
			_assetLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
		}
		protected function handlerComplete(event:Event):void{
			dispatchEvent(new Event(NotList.EVENT_COMPLETE_ITEM));
			if (load_arr&&load_arr.length!==0){ loadNextItem (); 
			}else{
				dispatchEvent(new Event(NotList.EVENT_COMPLETE));
				(event.target as LoaderInfo).removeEventListener(Event.COMPLETE, handlerComplete);
				(event.target as LoaderInfo).removeEventListener(ProgressEvent.PROGRESS, onProgress);
				(event.target as LoaderInfo).removeEventListener(IOErrorEvent.IO_ERROR, onError);
			}				
		}
		protected function onProgress(event:Event):void{
			var progress:Number = _assetLoader.contentLoaderInfo.bytesLoaded / _assetLoader.contentLoaderInfo.bytesTotal;
			var itemProgress:int=Math.floor(progress*100);		
			var totalProgres:int = ((arrLenth-load_arr.length-1)*100/arrLenth)+(itemProgress/arrLenth);
			dispatchEvent(new MyDataEvent(NotList.TOTAL_PROGRES,totalProgres));
		}
		protected function onError(event:Event):void{
			trace("Error");
		}
		public function loadTEXT(path:String):void{
			_assetURLLoader=new URLLoader();	
			//path = path+"?nocache="+Math.random();
			var urlRequest:URLRequest = new URLRequest(path);
			_assetURLLoader.load(urlRequest);
			_assetURLLoader.addEventListener(Event.COMPLETE, handlerCompleteURL);
			_assetURLLoader.addEventListener(IOErrorEvent.IO_ERROR, onError);
		}
		protected function handlerCompleteURL(event:Event):void{
			dispatchEvent(new Event(NotList.EVENT_COMPLETE_ITEM_URL));
			
		}
	}
}
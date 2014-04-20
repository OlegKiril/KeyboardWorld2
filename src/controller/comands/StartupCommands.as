package controller.comands
{
	import configuration.Notification.NotList;
	import flash.display.Sprite;
	import flash.events.Event;
	import model.proxy.FlashVarsProxy;
	import model.proxy.KeyboardProxy;
	import org.puremvc.as3.interfaces.INotification;
	import utility.MultiLoader;
	import utility.MyDataEvent;
	import utility.SWFWarehouse;
	import utility.XMLWarehoase;
	import view.mediator.*;

	public class StartupCommands extends GeneralCommand{
		private var _loaderMediator:LoaderMediator;
		
		override public function execute(notification: INotification):void{
			super.execute(notification);
			var mainView:Sprite= notification.getBody() as Sprite;
			facade.registerMediator(new RootMediator(mainView));
			facade.registerProxy(new KeyboardProxy(mainView));
			facade.registerProxy(new FlashVarsProxy(mainView.loaderInfo.parameters));
			var _multiloader:MultiLoader = new MultiLoader;	
			//var pathConfig:String = flashVarsProxy.flashVars.configXML;
			var pathConfig:String = "../res/textWarehouses/config.xml";
			_multiloader.loadTEXT(pathConfig);
			_multiloader.addEventListener(NotList.EVENT_COMPLETE_ITEM_URL, onCompliteURLItem);
		}
		protected function onCompliteURLItem(event:Event):void{
			var multiloader:MultiLoader = event.target as MultiLoader;
			multiloader.removeEventListener(NotList.EVENT_COMPLETE_ITEM_URL, onCompliteURLItem);
			XMLWarehoase.getInstance().addContent(event.target as MultiLoader);
			loadLoaderView();
		}
		protected function loadLoaderView():void{
			var _multiloader:MultiLoader = new MultiLoader;	
			var myXML:XML=XMLWarehoase.getInstance().getAssetXML("Graphics_path");	
			var loaderView:String=myXML.attribute("LoaderView");
			_multiloader.addTask(loaderView);
			_multiloader.start();
			_multiloader.addEventListener(NotList.EVENT_COMPLETE, onCompliteLoaderView);
		}
		protected function onCompliteLoaderView(event:Event):void{			
			var multiloader:MultiLoader = event.target as MultiLoader;
			multiloader.removeEventListener(NotList.EVENT_COMPLETE, onCompliteLoaderView);
			SWFWarehouse.getInstance().addContent(event.target as MultiLoader);
			facade.registerMediator(new LoaderMediator("loader0"));
			_loaderMediator=facade.retrieveMediator( LoaderMediator.NAME ) as LoaderMediator;
			loadGraphics();
		}
			protected function loadGraphics():void{
			var _multiloader:MultiLoader = new MultiLoader;	
			var myXML:XML=XMLWarehoase.getInstance().getAssetXML("Graphics_path");				
			var gameGraphicsPath:String=myXML.attribute("GameGraphics");			
			_multiloader.addTask(gameGraphicsPath);
			var gameIcons:String=myXML.attribute("GameIcons");			
			_multiloader.addTask(gameIcons);
			_multiloader.start();
			_multiloader.addEventListener(NotList.EVENT_COMPLETE_ITEM, onCompliteItem);
			_multiloader.addEventListener(NotList.TOTAL_PROGRES, totalProgres);
			_multiloader.addEventListener(NotList.EVENT_COMPLETE, onComplite);
		}
		protected function onCompliteItem(event:Event):void{
			SWFWarehouse.getInstance().addContent(event.target as MultiLoader);
		}
		protected function onComplite(event:Event):void{
			
			var multiloader:MultiLoader = event.target as MultiLoader;
			multiloader.removeEventListener(NotList.EVENT_COMPLETE, onComplite);
			multiloader.removeEventListener(NotList.EVENT_COMPLETE_ITEM, onCompliteItem);		
			_loaderMediator.initializeBtnStart();
		}
		protected function totalProgres(event:MyDataEvent):void{
			sendNotification(NotList.ON_PROGRES,event.data,"loader0");
			if (event.data==100){var multiloader:MultiLoader = event.target as MultiLoader; multiloader.removeEventListener(NotList.TOTAL_PROGRES, totalProgres)}
		}
	}
}
package model.proxy
{
	import configuration.Notification.NotList;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import org.puremvc.as3.patterns.proxy.Proxy;
	import utility.ageCrypt;
	
	public class ServerProxy extends Proxy{
		public static const NAME:String = "ServerProxy"
		public static const LOCAL_PORT:int = 1024;
		public static const LOCAL_IP:String = "127.0.0.1";
		private var _socket:Socket=new Socket;
		private var response:String;
		
		public function ServerProxy(){
			super(NAME);		
			connectToServer();
		}
		public function connectToServer():void{
			configureListeners();
			_socket.connect(LOCAL_IP, LOCAL_PORT);
		}
		private function configureListeners():void {
			_socket.addEventListener(Event.CONNECT, connectHandler);			
			_socket.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			_socket.addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
			_socket.addEventListener(Event.CLOSE, closeHandler);
		}
		private function connectHandler(event:Event):void {
			trace("connectHandler: " + event);
		}
		public function sendRequestRegistration(loginArray:Array):void {
			var arr:Array=["registration",loginArray];
			var json_out:String = JSON.stringify(arr);
			var strEncode:String=ageCrypt.encode(json_out); 		
			try {
				_socket.writeUTFBytes(strEncode);
				_socket.flush();
			}
			catch(e:IOError) {
				trace(e);
				sendNotification(NotList.NO_CONNECTION_TO_THE_SERVER);
			}
		}
		public function sendRequestAttemptToEnter(loginArray:Array):void {
			var arr:Array=["attemptToEnter",loginArray];
			var json_out:String = JSON.stringify(arr);
			var strEncode:String=ageCrypt.encode(json_out); 
			try {
				_socket.writeUTFBytes(strEncode);
				_socket.flush();
			}
			catch(e:IOError) {
				trace(e);
				sendNotification(NotList.NO_CONNECTION_TO_THE_SERVER);
			}
		}
		public function sendRequestSaveUserData(userName:String,userObject:Object):void{
			var userArray:Array=[userName,userObject];
			var arr:Array=["saveUserData",userArray];
			var json_out:String = JSON.stringify(arr);
			var strEncode:String=ageCrypt.encode(json_out); 
			try {
				_socket.writeUTFBytes(strEncode);
				_socket.flush();
			}
			catch(e:IOError){
				trace(e);
			}
		}		
		public function sendmessage(message:String):void {
			var arr:Array=["sendMessage",message];
			var json_out:String = JSON.stringify(arr);
			var strEncode:String=ageCrypt.encode(json_out); 
			try {
				_socket.writeUTFBytes(strEncode);
				_socket.flush();
			}
			catch(e:IOError) {
				trace(e);
			}
		}
		private function ioErrorHandler(event:IOErrorEvent):void {
			trace("ioErrorHandler: " + event);
		}
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("securityErrorHandler: " + event);
		}
		private function socketDataHandler(event:ProgressEvent):void {
			trace("socketDataHandler: " + event);
			var str:String = _socket.readUTFBytes(_socket.bytesAvailable);
			var strDecode:String=ageCrypt.decode(str);  
			var responseArray:Array = JSON.parse(strDecode) as Array;
			if(responseArray[0]=="USER_WITH_THAT_NAME_EXIST"){sendNotification(NotList.USER_WITH_THAT_NAME_EXIST);}
			if(responseArray[0]=="USER_REGISTERED"){sendNotification(NotList.USER_REGISTERED,responseArray[1]);}
			if(responseArray[0]=="USER_ENTERED"){sendNotification(NotList.USER_ENTERED,responseArray[1]);}
			if(responseArray[0]=="TRY_EGEIN_OR_REGISTER"){sendNotification(NotList.TRY_EGEIN_OR_REGISTER);}
			if(responseArray[0]=="SEND_TO_ALL"){sendNotification(NotList.SEND_TO_ALL,responseArray[1]);}
		}
		private function closeHandler(event:Event):void {
			trace("closeHandler: " + event);
		}
	}
}
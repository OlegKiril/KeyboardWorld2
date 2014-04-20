package model.proxy
{
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.Proxy;
	
	import model.VO.ClientVO;

	public class ClientProxy extends Proxy{
		public static const NAME:String = "ClientProxy";
		public static const LOCAL_PORT:int = 1024;
		public static const LOCAL_IP:String = "127.0.0.1";
		private var _socket:Socket=new Socket;
		private var response:String;
		
		public function ClientProxy(){
			super(NAME,new ClientVO);
		}
		public function connectToServer(){
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
			sendRequest();
		}
		private function sendRequest():void {
			trace("sendRequest");
			response = "";
			writeln("GET /");
			_socket.flush();
		}
		private function writeln(str:String):void {
			str += "\n";
			try {
				_socket.writeUTFBytes(str);
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
			readResponse();
		}
		private function readResponse():void {
			var str:String = _socket.readUTFBytes(_socket.bytesAvailable);
			response += str;
			trace(str);
		}
		private function closeHandler(event:Event):void {
			trace("closeHandler: " + event);
			trace(response.toString());
		}
	}
}
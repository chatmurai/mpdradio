package net
{

	import com.worlize.websocket.WebSocket;
	import com.worlize.websocket.WebSocketErrorEvent;
	import com.worlize.websocket.WebSocketEvent;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class Esp8266SocketManager extends EventDispatcher
	{

		public static var CONNECT_SUCCESS:String = "connectSuccess";
		public static var CONNECT_FAIL:String = "connectFail";
		public static var CONNECT_CLOSE:String = "connectClose";

		private var _socket:WebSocket;
		private var _pingPongTimer:Timer;
		public var  connected:Boolean;

		public function Esp8266SocketManager()
		{
			connected = false;

			_pingPongTimer = new Timer(1000, 0);
			_pingPongTimer.addEventListener(TimerEvent.TIMER, sendPing)
		}

		public function connect(Esp8266Ip:String):void
		{
			if(_socket != null){
				_socket.close(false);
				_socket = null;
			}

			_socket = new WebSocket(Esp8266Ip, "*", "arduino");
			//_socket.debug = true;
			_socket.addEventListener(WebSocketErrorEvent.CONNECTION_FAIL, onConnectionFailed);
			_socket.addEventListener(WebSocketEvent.OPEN, onConnectionOpened);
			_socket.addEventListener(WebSocketEvent.CLOSED, onConnectionClosed);
			_socket.addEventListener(WebSocketEvent.MESSAGE, onDataReceived);

			_socket.connect();
		}

		private function onConnectionFailed(e:WebSocketErrorEvent):void
		{
			trace("Connection to Esp8266 failed");

			connected = false;
			dispatchEvent(new Event(Esp8266SocketManager.CONNECT_FAIL, false, false));

		}

		private function onConnectionOpened(e:WebSocketEvent):void
		{
			trace("Connected to Esp8266");

			connected = true;
			_pingPongTimer.start();
			dispatchEvent(new Event(Esp8266SocketManager.CONNECT_SUCCESS, false, false));

		}

		private function onConnectionClosed(evt:WebSocketEvent):void
		{
			trace("Connection to Esp8266 closed");
			connected = false;
			_pingPongTimer.stop();
			dispatchEvent(new Event(Esp8266SocketManager.CONNECT_CLOSE, false, false))
		}

		public function sendData(pData:String):void
		{
			trace(this + " sendData( " + pData + " )");
			if(connected) _socket.sendUTF(pData);
		}

		private function onDataReceived(e:WebSocketEvent):void
		{
			try {
				trace( "####### received from Esp8266: ", e.message.utf8Data );
			}
			catch (e:Error) {
				trace('error');
			}
		}

		public function sendPing(e:TimerEvent):void
		{
			trace(this + " sendPing()");
			if(connected) _socket.sendUTF("ping");
		}

	}
}

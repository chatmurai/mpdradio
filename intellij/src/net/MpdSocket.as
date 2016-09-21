package net
{

	import flash.errors.IOError;
	import flash.events.*;
	import flash.net.Socket;
	import flash.utils.Timer;
	import flash.utils.setTimeout;

	import model.vo.MPDInfosVO;

	import net.event.MpdSocketEvent;

	public class MpdSocket extends EventDispatcher
	{

		//private const MPD_CONNECT_OK_REGEXP:RegExp = new RegExp("^OK( MPD [0-9]+\.[0-9]+\.[0-9]+)?", "m");

		private const MPD_CONNECT_OK_REGEXP:RegExp = /OK MPD /;
		private const MPD_OK_REGEXP:RegExp = /OK\n/;
		private const MPD_IDLE_REGEXP:RegExp = /changed: /;
		private const MPD_INFO_CMD:String = "command_list_begin\nstatus\ncurrentsong\ncommand_list_end";

		private var _appActive:Boolean;
		private var _socket:Socket;
		private var _host:String;
		private var _port:uint;
		private var _receiveBuffer:String;
		private var _infosTimer:Timer;

		public function MpdSocket(pHost:String = null, pPort:int = undefined):void
		{
			_appActive = false;
			_host = pHost;
			_port = pPort;
			_receiveBuffer = "";

			addEventListener(Event.ACTIVATE, onAppActivate);
			addEventListener(Event.DEACTIVATE, onAppDeActivate);

			_socket = new Socket(pHost, pPort);
			_socket.addEventListener(Event.CONNECT, onSocketConnected);
			_socket.addEventListener(Event.CLOSE, onSocketClosed);
			_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSocketError);
			_socket.addEventListener(ProgressEvent.SOCKET_DATA, onSocketDataReceive);

			_infosTimer = new Timer(2000, 0);
			_infosTimer.addEventListener(TimerEvent.TIMER, function(e:Event):void{
				sendCommandToSocket(MPD_INFO_CMD);
			})

		}

		// ########################################################################## APP ACTIVATION / DEACTIVATION
		private function onAppActivate(e:Event):void
		{
			trace("APP ACTIVATE !");
			_appActive = true;
			connect();
		}

		private function onAppDeActivate(e:Event):void
		{
			_appActive = false;
			close();
		}

		// ########################################################################## SOCKET
		public function connect(e:Event = null):void
		{
			trace(this + " connect()");
			if (!_socket.connected) _socket.connect(_host, _port);
			dispatchEvent(new MpdSocketEvent(MpdSocketEvent.SOCKET_CONNECTING));
		}

		public function close(e:Event = null):void
		{
			trace(this + " close()");
			if (_socket.connected) _socket.close();
			if(_infosTimer.running) _infosTimer.reset();
			dispatchEvent(new MpdSocketEvent(MpdSocketEvent.SOCKET_CLOSING));
		}

		private function onSocketConnected(e:Event):void
		{
			trace(this + " onSocketConnected()");
			sendCommandToSocket(MPD_INFO_CMD);
			if(!_infosTimer.running) _infosTimer.start();

			dispatchEvent(new MpdSocketEvent(MpdSocketEvent.SOCKET_CONNECTED));
		}

		private function onSocketClosed(e:Event):void
		{
			trace(this + " onSocketClosed()");
			if(_appActive) connect();
			dispatchEvent(new MpdSocketEvent(MpdSocketEvent.SOCKET_CLOSED));
		}

		private function onSocketError(e:*):void
		{
			trace(this + " onSocketError()");
			dispatchEvent(new MpdSocketEvent(MpdSocketEvent.SOCKET_ERROR));
		}

		private function onSocketDataReceive(e:ProgressEvent):void
		{
			trace(this  + " onSocketDataReceive() ");

			// We add data to the buffer
			_receiveBuffer += _socket.readUTFBytes(_socket.bytesAvailable);
			//trace("A : " + _receiveBuffer);

			// If the MPD_CONNECT_OK_REGEXP pattern is found, meaning that this is a handshake, we flush the buffer because
			// the "real" connection event is handled by Event.CONNECT and we don't want fill the buffer with this crap.
			if(_receiveBuffer.match(MPD_CONNECT_OK_REGEXP) !== null) _receiveBuffer = "";

			// If an "OK\n" string is found in the buffer, meaning the message is complete…
			if(_receiveBuffer.match(MPD_OK_REGEXP) !== null)
			{
				// …    if there is more than a simple "OK" message in the buffer we get all chars before "OK\n" (the s option after the / allows the . operator to match newlines)
				if(_receiveBuffer !== "OK\n" && _receiveBuffer.length > 3)
				{
					// if something changed on the server
					/*if(_receiveBuffer.match(MPD_IDLE_REGEXP) !== null)
					{
						trace("IDLE CHANGE DETECTED");
						sendCommandToSocket(MPD_INFO_CMD);
					}*/

					// we trim the last "\nOK\n" chars at the end of the buffer
					_receiveBuffer = /.+?(?=\nOK\n)/s.exec(_receiveBuffer);
					//trace("C : " + _receiveBuffer);

					// then we create an array from buffer data…
					var a1:Array = _receiveBuffer.split('\n');

					// …and we populate a MPDInfosVO object with it…
					if(a1.length == 21)
					{
						var mivo:MPDInfosVO = new MPDInfosVO();
						for(var i:uint = 0; i < a1.length; i++)
						{
							var propName:String = /.+?(?=: )/.exec(String(a1[i])); // get all chars before ": "
							var propValue:String = /(?<=: ).*/.exec(String(a1[i])); // get all chars after ": "

							mivo[propName] = propValue;
						}

						trace("*** ", mivo.Name, mivo.state, mivo.volume);

						//dispatchEvent(new MpdSocketEvent(MpdSocketEvent.SOCKET_DATA_RECEIVED, true, false, mivo));

						//setTimeout(function():void{sendCommandToSocket("idle playlist player mixer")}, 500);

					}
				}

				// And finally we empty the buffer and get rid of utility vars
				_receiveBuffer = "";
				a1 = null;
				mivo = null;
			}
		}

		public function sendCommandToSocket(pCmd:String):void
		{
			if (pCmd != '')
			{
				try {
					pCmd += "\n";
					_socket.writeUTFBytes(pCmd);
					_socket.flush();
					dispatchEvent(new MpdSocketEvent(MpdSocketEvent.SOCKET_DATA_SENT, false, false));
				}
				catch (e:IOError) {
					trace(e.toString());
				}
			}

		}

		// ########################################################################## COMMANDS
		public function nextSong():void
		{
			sendCommandToSocket("next");
		}

		public function prevSong():void
		{
			sendCommandToSocket("prev");
		}

		public function volumeUp():void
		{
			sendCommandToSocket("volume 10");
		}

		public function volumeDown():void
		{
			sendCommandToSocket("volume -10");
		}

		public function getStatus(e:Event = null):void
		{
			sendCommandToSocket("status");
		}

		public function getCurrentSong(e:Event = null):void
		{
			sendCommandToSocket("currentsong");
		}

	}
}
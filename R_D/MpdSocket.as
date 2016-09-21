package net
{

	import flash.events.*;
	import flash.utils.*;

	import utils.Parser;

	public class MpdSocket extends EventDispatcher
	{
		public static const CURRENT_SONG_CHANGED:String = 'current song changed';
		public static const PLAYLIST_CHANGED:String = 'playlist changed';
		public static const STATUS_CHANGED:String = 'status changed';

		private const MPD_COMMAND_COMPLETE:RegExp = new RegExp('^OK( MPD [0-9]+\.[0-9]+\.[0-9]+)?', 'm');

		protected var _info:Object = new Object();
		protected var _infoString:String = '';
		protected var _status:Object = new Object();
		protected var _statusString:String = '';
		protected var _playlist:Array;
		protected var _playlistString:String = '';

		private var statusUpdateTimer:Timer;
		private var commandUpdateTimer:Timer;
		private var statusSocket:TelnetSocket;
		private var commandSocket:TelnetSocket;

		public function MpdSocket(h:String = null, p:int = undefined, dualSocket:Boolean = false):void
		{
			commandSocket = new TelnetSocket(h, p, MPD_COMMAND_COMPLETE);
			statusSocket = (dualSocket) ? new TelnetSocket(h, p, MPD_COMMAND_COMPLETE) : commandSocket;

			statusUpdateTimer = new Timer(1000, 0);
			statusUpdateTimer.addEventListener(TimerEvent.TIMER, getCurrentSong);
			statusUpdateTimer.addEventListener(TimerEvent.TIMER, getStatus);
			statusUpdateTimer.addEventListener(TimerEvent.TIMER, getPlaylist);

			commandUpdateTimer = new Timer(5000, 0);
			commandUpdateTimer.addEventListener(TimerEvent.TIMER, stayALive);

			connect();

			//statusUpdateTimer.addEventListener(TimerEvent.TIMER,getCurrentSong);
			//statusUpdateTimer.removeEventListener(TimerEvent.TIMER,connect);

			statusSocket.addEventListener(Event.CLOSE, onStatusSocketDisconnect);
			statusSocket.addEventListener(Event.CONNECT, onStatusSocketSuccessfulConnect);
			commandSocket.addEventListener(Event.CLOSE, onDisconnect);
			commandSocket.addEventListener(Event.CONNECT, onSuccessFullConnect);
			commandSocket.addEventListener(TelnetEvent.RECEIVED_DATA, onDataReceived);
			commandSocket.addEventListener(TelnetEvent.SENT_DATA, onDataSent);

		}

		public function connect(e:Event = null):void
		{
			if (!commandSocket.connected)commandSocket.connect(e);
			if ((!statusSocket.connected) && statusSocket != commandSocket)statusSocket.connect(e);

		}

		public function onDataSent(e:TelnetEvent):void
		{
			dispatchEvent(new TelnetEvent(TelnetEvent.SENT_DATA, e.data));
		}

		public function onDataReceived(e:TelnetEvent):void
		{
			dispatchEvent(new TelnetEvent(TelnetEvent.RECEIVED_DATA, e.data));
		}

		public function reconnect(e:Event = null):void
		{
			connect(e);
		}

		public function onSuccessFullConnect(e:Event):void
		{
			dispatchEvent(e);
		}

		public function onDisconnect(e:Event):void
		{
			dispatchEvent(e);
		}

		public function onStatusSocketSuccessfulConnect(e:Event):void
		{

			statusUpdateTimer.start();
			dispatchEvent(e);
		}

		public function onStatusSocketDisconnect(e:Event):void
		{
			statusUpdateTimer.stop();
			reconnect();
			dispatchEvent(e);
		}

		public function moveTo(id:int, to:int):void
		{
			send('moveid ' + id + ' ' + to);
		}

		public function get playlistLength():uint
		{
			return uint(_status['playlistlength']);
		}

		public function play(index:* = null):void
		{
			send('play ' + ((index != null) ? index : ''));
		}

		public function stop():void
		{
			send('stop');
		}

		public function next():void
		{
			send('next');
		}

		public function previous():void
		{
			send('previous');
		}

		public function pause():void
		{
			send('pause');
		}

		public function remove(trackId:int):void
		{
			send('delete ' + trackId);
		}

		public function move(a:int, b:int):void
		{
			a = Math.max(0, Math.min(playlist.length - 1, a));
			b = Math.max(0, Math.min(playlist.length - 1, b));
			send('move ' + a + ' ' + b);
		}

		public function removeAll():void
		{
			send('clear');
		}

		public function add(file:String):void
		{
			send('add "' + file + '"');
		}

		public function addAsNext(file:String):void
		{
			sendReceive('addid "' + file + '"', cueTrack);

		}

		public function addAlbum(name:String):void
		{
			list(addFiles, 'file', 'album', name);
		}

		public function addArtist(name:String):void
		{
			list(addFiles, 'file', 'artist', name);
		}

		public function addFiles(str:String):void
		{
			var lines:Array = str.split('\n');
			for each(var line:String in lines)
			{
				var song:Array = line.split(': ');
				if (song && song.length > 1)add(song[1]);
			}
		}

		public function cueTrack(s:*):void
		{
			var trackId:int;

			if (s is String)
			{
				var pair:Array = s.match(/Id: ([0-9]*)/);
				if (pair)trackId = int(pair[1]);
			}
			else if (s is int)
			{
				trackId = s;
			}

			if (trackId >= 0)moveTo(trackId, currentTrackPosition + 1);
		}

		public function set password(password:String):void
		{
			send('password ' + password);
		}

		public function set volume(v:int):void
		{
			send('setvol ' + v);
		}

		public function get volume():int
		{
			return Number(_status['volume']);
		}

		public function set random(b:Boolean):void
		{
			send('random ' + (b ? '1' : '0'));
		}

		public function get random():Boolean
		{
			return (_status['random'] == '1');
		}

		public function set repeat(b:Boolean):void
		{
			send('repeat ' + (b ? '1' : '0'));
		}

		public function get repeat():Boolean
		{
			return (_status['repeat'] == '1');
		}

		public function get playing():Boolean
		{
			return (_status['state'] && _status['state'] == 'play');
		}

		public function get currentTrack():String
		{
			return (_info['Title']) ? _info['Title'] : file;
		}

		public function get album():String
		{
			return (_info['Album']) ? _info['Album'] : null;
		}

		public function get artist():String
		{
			return (_info['Artist']) ? _info['Artist'] : null;
		}

		public function get currentTrackPosition():int
		{
			return int(_info['Pos']);
		}

		public function get file():String
		{
			return (_info['file']) ? _info['file'] : '';
		}

		public function get currentTrackId():int
		{
			return int((_info['Id']) ? _info['Id'] : 0);
		}

		public function get currentTrackPlaylistId():int
		{
			return int((_info['Pos']) ? _info['Pos'] : 0);
		}

		public function get trackTime():String
		{
			return (_status['time']) ? _status['time'] : '';
		}

		public function set trackTime(time:String):void
		{
			var trackId:int = currentTrackId;
			send('seekid ' + trackId.toString() + ' ' + time.toString());

		}

		public function listDirectory(o:*, callback:Function):void
		{
			sendReceive('lsinfo "' + o + '"', callback);
		}

		public function search(callback:Function, filter:String = null, filterType:String = 'any'):void
		{
			sendReceive('search ' + ((filter && filterType) ? filterType + ' "' + filter + '"' : ''), callback)
		}

		public function find(callback:Function, filter:String = null, filterType:String = 'any'):void
		{
			sendReceive('find ' + ((filter && filterType) ? filterType + ' "' + filter + '"' : ''), callback)
		}

		public function list(callback:Function, seachType:String, filterType:String = null, filter:String = null):void
		{
			sendReceive('list ' + seachType + ' ' + ((filter && filterType) ? filterType + ' "' + filter + '"' : ''), callback)
		}

		public function sendReceive(str:String, callback:Function = null):void
		{
			commandSocket.sendReceive(str, callback);
		}

		public function send(str:String):void
		{
			commandSocket.send(str);
		}

		public function get info():Object
		{
			return _info;
		}

		public function get status():Object
		{
			return _status;
		}

		public function get playlist():Array
		{
			return _playlist;
		}

		public function get playlistSongs():Array
		{
			return [];
		}

		public function getCurrentSong(e:Event = null):void
		{
			statusSocket.sendReceive('currentsong', updateCurrentSong);
		}

		public function getStatus(e:Event = null):void
		{
			statusSocket.sendReceive('status', updateStatus);
		}

		public function getPlaylist(e:Event = null):void
		{
			if (statusUpdateTimer.currentCount % 2 == 1)
				statusSocket.sendReceive('playlistinfo', updatePlaylist);
		}

		public function updateCurrentSong(str:String):void
		{
			if (str.length != _infoString.length || str != _infoString)
			{
				_infoString = str;
				_info = Parser.pairs(str, Object, /^([^:]*): (.*)/);
				//trace('info', _info);
				//trace( "updateCurrentSong() " + str + "\n" );
				dispatchEvent(new Event(CURRENT_SONG_CHANGED));
			}
		}

		public function updatePlaylist(str:String):void
		{
			if (str.length != _playlistString.length || str != _playlistString)
			{
				_playlistString = str;
				var songs:Array = str.replace(/file:/g, '|Song: file:').split('|');
				songs.shift();
				_playlist = songs;
				//trace('playlist', _playlist);
				//trace( "updatePlaylist() " + str + "\n" );
				dispatchEvent(new Event(PLAYLIST_CHANGED));
			}

		}

		public function updateStatus(str:String):void
		{
			if (str.length != _statusString.length || str != _statusString)
			{
				_statusString = str;
				_status = Parser.pairs(str, Object, /^([^:]*): (.*)/);
				//trace('status', _status);
				//trace( "updateStatus() " + str + "\n" );
				dispatchEvent(new Event(STATUS_CHANGED));

			}

		}

		private function stayALive(e:TimerEvent):void
		{
			sendReceive("ping", function(str:String):void{
				trace(str);
			});
		}

		/*private function Parser.csv(input:String,type:Class=null,pairDeliminator:String=': ',lineDeliminator:String='\n'):*
		 {
		 if(!type)type=Object;
		 var d:Array=input.split(lineDeliminator);
		 var output:*=new type();
		 var indexType:Class=(type is Array)?int:String;
		 for each(var s:String in d)
		 {
		 var pair:Array=s.split(pairDeliminator,2);
		 if(pair.length>=2)output[indexType(pair[0])]=pair[1];
		 }
		 return output;

		 }*/


		/*private function mergeData(a:Object,o:Object):void
		 {
		 for(var n:String in o)
		 {
		 a[n]=o[n];
		 }
		 }*/


	}
}

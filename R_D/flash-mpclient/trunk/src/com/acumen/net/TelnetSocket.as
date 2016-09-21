package com.acumen.net
{
	import com.acumen.utils.*;
	
	import flash.errors.*;
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;
	
	public class TelnetSocket  extends EventDispatcher
	{
		private var socket:Socket=new Socket();
		private var lock:Boolean=false;
		private var receiveCallback:Function;
		private var receiveBuffer:String='';
		private var sendQueue:Array=new Array();
		protected var hostname:String;
		protected var port:int;
		protected var commandCompleteString:RegExp;
		public var lastStringSent:String='';
		
		public function TelnetSocket(h:String=null,p:int=undefined,c:RegExp=null):void
		{
			
			hostname=h || '127.0.0.1';
			port=p || 6600;
			commandCompleteString=c || /OK\n/;

			socket.addEventListener(Event.CLOSE,dispatchCloseEvent);
			socket.addEventListener(Event.CONNECT,dispatchConnectEvent);
			socket.addEventListener(ProgressEvent.SOCKET_DATA,receive);

			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			socket.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			
			receiveCallback=nullReceive;
			
		}
		
		public function dispatchConnectEvent(e:Event=null):void
		{
			sendQueue.unshift(new Command('',receiveConnectionMessage));
			sendNextCommand();
			dispatchEvent(new Event(Event.CONNECT));
			
		}
		
		public function dispatchCloseEvent(e:Event=null):void
		{
			lock=false;
			receiveCallback=nullReceive;
			dispatchEvent(new Event(Event.CLOSE));
			
		}

		
		public function connect(e:Event=null):void
		{
			
			socket.connect(hostname,port);		
		}
		
		public function get connected():Boolean
		{
			return socket.connected;
		}
		
		public function onSecurityError(e:Event=null):void
		{
			throw new Error('policy file missing or disallowed communication');
		}

		public function onIOError(e:Event=null):void
		{
			//throw new Error('could not connect to socket, or could not find host');
		}

		public function send(str:String):void
		{
			//writeln(str);
			sendReceive(str,null);
		}
		
		public function sendReceive(str:String,callback:Function=null):void
		{
			if(callback==null)callback=nullReceive;
			
			
			if(lock)
			{
				//throw new Error("Socket Error: Can't send, awaiting command return");
				sendQueue.push(new Command(str,callback));
			}
			else if(!socket.connected)
			{
				sendQueue.push(new Command(str,callback));
			}
			else
			{
				lock=true;
				receiveCallback=callback;
				lastStringSent=str;
				writeln(str);
			}
		}
		
		protected function receive(e:Event=null):void
		{
			var str:String = socket.readUTFBytes(socket.bytesAvailable);
			var callback:Function=receiveCallback;
			var completedCommand:Boolean=(str.match(commandCompleteString)!=null);
			
			lock=false;
			dispatchEvent(new TelnetEvent(TelnetEvent.RECEIVED_DATA,'['+lastStringSent+':'+(completedCommand?' complete ':' ')+':'+str+']'));
			if(completedCommand)
			{
				
				str=str.replace(commandCompleteString,'|OK|');
				var returnArray:Array=str.split('|OK|');
				
				receiveBuffer=receiveBuffer+returnArray[0];
				callback(receiveBuffer);
				sendNextCommand();	
				receiveBuffer=returnArray[1];
				
			}
			else
			{
				receiveBuffer=receiveBuffer+str;
				
			}
			
		}
		
		private function nullReceive(str:String):void
		{
			
		}
		
		private function receiveConnectionMessage(str:String):void
		{
			
		}
		
		private function sendNextCommand():void
		{
			if(sendQueue.length>0)
			{	
				socket.flush();
				var command:Command=Command(sendQueue.shift());
				sendReceive(command.command,command.callback);
			}
		}
		
		private function writeln(str:String):void {
	        
	        if(str!='')try {
		        str += "\n";
	        	socket.writeUTFBytes(str);
	        	socket.flush();
				dispatchEvent(new TelnetEvent(TelnetEvent.SENT_DATA,str));
	        }
	        catch(e:IOError) {
	        	Debug.instance.message(e.toString());
	        }
	    }
	
	}
}
internal class Command
{
	public var command:String;
	public var callback:Function
	public function Command(command:String,callback:Function):void
	{
		this.command=command;
		this.callback=callback;
	}
}
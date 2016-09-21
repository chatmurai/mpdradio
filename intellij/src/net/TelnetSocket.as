package net {

import flash.errors.*;
import flash.events.*;
import flash.net.*;

import net.event.TelnetEvent;

public class TelnetSocket extends EventDispatcher {
    private var _socket:Socket = new Socket();
    private var _lock:Boolean = false;
    private var _receiveCallback:Function;
    private var _receiveBuffer:String = '';
    private var _sendQueue:Array = new Array();
    protected var _hostname:String;
    protected var _port:int;
    protected var _commandCompleteString:RegExp;
    public var _lastStringSent:String = '';

    public function TelnetSocket(pHost:String = null, pPort:int = undefined, pCompleteCommand:RegExp = null):void {

        _hostname = pHost || '127.0.0.1';
        _port = pPort || 6600;
        _commandCompleteString = pCompleteCommand || /OK\n/;

        _socket.addEventListener(Event.CLOSE, dispatchCloseEvent);
        _socket.addEventListener(Event.CONNECT, dispatchConnectEvent);
        _socket.addEventListener(ProgressEvent.SOCKET_DATA, receive);

        _socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
        _socket.addEventListener(IOErrorEvent.IO_ERROR, onIOError);

        _receiveCallback = nullReceive;

    }

    public function dispatchConnectEvent(e:Event = null):void {
        _sendQueue.unshift(new Command('', receiveConnectionMessage));
        sendNextCommand();
        dispatchEvent(new Event(Event.CONNECT, false, false));

    }

    public function dispatchCloseEvent(e:Event = null):void {
        _lock = false;
        _receiveCallback = nullReceive;
        dispatchEvent(new Event(Event.CLOSE, false, false));

    }


    public function connect(e:Event = null):void {

        _socket.connect(_hostname, _port);
    }

    public function get connected():Boolean {
        return _socket.connected;
    }

    public function onSecurityError(e:Event = null):void {
        throw new Error('policy file missing or disallowed communication');
    }

    public function onIOError(e:Event = null):void {
        //throw new Error('could not connect to _socket, or could not find host');
    }

    public function send(str:String):void {
        //writeln(str);
        sendAndReceive(str, null);
    }

    public function sendAndReceive(str:String, callback:Function = null):void {
        if (callback == null) callback = nullReceive;


        if (_lock) {
            //throw new Error("Socket Error: Can't send, awaiting command return");
            _sendQueue.push(new Command(str, callback));
        }
        else if (!_socket.connected) {
            _sendQueue.push(new Command(str, callback));
        }
        else {
            _lock = true;
            _receiveCallback = callback;
            _lastStringSent = str;
            writeln(str);
        }
    }

    protected function receive(e:Event = null):void {
        var str:String = _socket.readUTFBytes(_socket.bytesAvailable);
        trace('************** ' + str);
        var callback:Function = _receiveCallback;
        var completedCommand:Boolean = (str.match(_commandCompleteString) != null);

        _lock = false;
        dispatchEvent(new TelnetEvent(TelnetEvent.DATA_RECEIVED, '[' + _lastStringSent + ':' + (completedCommand ? ' complete ' : ' ') + ':' + str + ']'));
        if (completedCommand) {
            str = str.replace(_commandCompleteString, '|OK|');
            var returnArray:Array = str.split('|OK|');

            _receiveBuffer = _receiveBuffer + returnArray[0];
            callback(_receiveBuffer);
            sendNextCommand();
            _receiveBuffer = returnArray[1];
        }
        else {
            _receiveBuffer = _receiveBuffer + str;
        }

    }

    private function nullReceive(str:String):void {

    }

    private function receiveConnectionMessage(str:String):void {

    }

    private function sendNextCommand():void {
        if (_sendQueue.length > 0) {
            _socket.flush();
            var command:Command = Command(_sendQueue.shift());
            sendAndReceive(command.command, command.callback);
        }
    }

    private function writeln(str:String):void {

        if (str != '')
            try {
                str += "\n";
                _socket.writeUTFBytes(str);
                _socket.flush();
                dispatchEvent(new TelnetEvent(TelnetEvent.DATA_SENT, str));
            }
            catch (e:IOError) {
                trace(e.toString());
            }
    }

}
}
internal class Command {
    public var command:String;
    public var callback:Function

    public function Command(command:String, callback:Function):void {
        this.command = command;
        this.callback = callback;
    }
}
package com.acumen.display
{
	import com.acumen.net.*;
	import com.acumen.utils.*;
	import com.bit101.components.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.ui.*;
	
	public class ConsolePanel extends MpdPanel
	{
		public var console:Console;
		//public var socket:MpdSocket;
		public var closeButton:CloseButton;
		
		public function ConsolePanel(socket:MpdSocket,parent:DisplayObjectContainer=null)
		{
		
			addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE,onRemovedFromStage);
			
			if(parent)parent.addChild(this);
			
			new Label(this,5,0,'Console');
			
			
			
			/*this.socket=socket;
			graphics.beginFill(Settings.instance.backgroundColour,1);
			graphics.drawRect(0,0,320,240);
			graphics.endFill();
			this.filters=[new BevelFilter(2,45,0xffffff,0.8,0x0,0.4,4,4,1,1)];
			*/
			
			console=new Console(this,10,20);
			console.maxLines=Settings.instance.consoleLines;
			//console.textArea.filters=[new BevelFilter(1,225,0xffffff,0.8,0x0,0.4,4,4,1,1,BitmapFilterType.OUTER)];
			console.addEventListener(ConsoleEvent.LINE_ENTERED,onLineEntered);
			socket.addEventListener(TelnetEvent.RECEIVED_DATA,onData);
			socket.addEventListener(TelnetEvent.SENT_DATA,onDataSent);
			closeButton=new CloseButton(this,305,5);
			visible=false;
			
			
			super(socket,parent,320,240);
			
		}
		
		public function onAddedToStage(e:Event):void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyPressed);
		}
		
		public function onRemovedFromStage(e:Event):void
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN,onKeyPressed);
		}
		
		public function onLineEntered(c:ConsoleEvent):void
		{
			socket.send(c.data);
		}
		
		public function onData(t:TelnetEvent):void
		{
			console.append(t.data+'\n');
		}
		
		public function onDataSent(t:TelnetEvent):void
		{
			console.append('> '+t.data+'\n');
		}
		
		public function onKeyPressed(k:KeyboardEvent):void
		{
			
			if(k.keyCode==192) //Keyboard.BACKQUOTE didn't work for some reason
				toggleVisibility(k)
		}
		
		public function toggleVisibility(e:Event=null):void
		{
			if(visible)
				hide();
			else 
				show();
		}
		
		public function show(e:Event=null):void
		{
			visible=true;
		}
		
		public function hide(e:Event=null):void
		{
			visible=false;
		}
	}
}
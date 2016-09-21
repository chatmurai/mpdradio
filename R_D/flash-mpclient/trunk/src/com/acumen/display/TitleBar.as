package com.acumen.display
{
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import com.acumen.net.*;
	import com.acumen.utils.*;
	
	import com.bit101.components.*;
	
	public class TitleBar extends MpdPanel
	{
		private var lamp:Lamp;
		private var titleLabel:Label;
	
		public function TitleBar(socket:MpdSocket,parent:DisplayObjectContainer=null,title:String=null)
		{
			title=title||'MPD Client';
			this.x=0;
			this.y=0;
			
			titleLabel=new Label(this,5,0,title);
			
			addChild(lamp=new Lamp(0x00f000,0xf00000));
			lamp.x=300;
			lamp.y=4;
			lamp.alpha=0.8;
			lamp.buttonMode=true;
			socket.addEventListener(Event.CLOSE,lamp.off);
			socket.addEventListener(Event.CONNECT,lamp.on);
			
			lamp.addEventListener(MouseEvent.CLICK,socket.reconnect);
			
			super(socket,parent,320,20);
			}
		
		public function set title(s:String):void
		{
			titleLabel.text=s;	
		}
		
		public override function draw():void
		{
			super.draw();
			titleLabel.draw();
		}
	}
}
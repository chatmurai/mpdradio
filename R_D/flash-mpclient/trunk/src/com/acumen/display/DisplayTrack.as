package com.acumen.display
{
	import com.acumen.net.*;
	import com.acumen.utils.Debug;
	import com.acumen.utils.Parser;
	import com.acumen.utils.Settings;
	import com.bit101.components.*;
	
	import flash.display.*;
	import flash.events.*;

	public class DisplayTrack extends Label
	{
		
		private var socket:MpdSocket;
		
		public function DisplayTrack(socket:MpdSocket,parent:DisplayObjectContainer=null)
		{
			super(parent,5,25);
			
			this.socket=socket;
			socket.addEventListener("status changed",update);
			
		}
		
		protected override function init():void
		{
			super.init();
			var _mask:Sprite=new Sprite()
			this.addChild(_mask);
			_mask.graphics.beginFill(0);
			_mask.graphics.drawRect(0,0,300,20);
			_mask.graphics.endFill();
			mask=_mask;
		}
		
		public function update(e:Event=null):void
		{	
			var info:Object=socket.info;
			text=Parser.substitute(Settings.instance.playingSongDisplay,info);
			/*text=(socket.artist?socket.artist+' : ':'')
				+(socket.album?socket.album+' : ':'')
				+socket.currentTrack;
				*/
		}
	}
}
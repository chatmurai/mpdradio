package com.acumen.display
{
	import flash.display.*;
	import flash.events.*;
	
	import com.bit101.components.*;
	
	import com.acumen.net.*;
	
	public class RepeatCheckbox extends CheckBox
	{
		public var socket:MpdSocket;
		
		public function RepeatCheckbox(socket:MpdSocket,parent:DisplayObjectContainer = null)
		{
			this.socket=socket;
			super(parent,190,16,"repeat");
			addEventListener(MouseEvent.CLICK,changeRandom);
			socket.addEventListener("status changed",update);
			
		}
		
		public function changeRandom(e:Event):void
		{
			socket.repeat=selected;
			
		}
		
		public function update(e:Event=null):void
		{
			selected=socket.repeat;
		}
}
}
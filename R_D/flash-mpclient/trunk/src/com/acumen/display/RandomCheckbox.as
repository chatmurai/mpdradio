package com.acumen.display
{
	import flash.display.*;
	import flash.events.*;
	
	import com.bit101.components.*;
	
	import com.acumen.net.*;
	
	public class RandomCheckbox extends CheckBox
	{
		public var socket:MpdSocket;
		
		public function RandomCheckbox(socket:MpdSocket,parent:DisplayObjectContainer = null)
		{
			this.socket=socket;
			super(parent,135,16,"random");
			addEventListener(MouseEvent.CLICK,changeRandom);
			socket.addEventListener("status changed",update);
			
		}
		
		public function changeRandom(e:Event):void
		{
			socket.random=selected;
			
		}
		
		public function update(e:Event=null):void
		{
			selected=socket.random;
		}
}
}
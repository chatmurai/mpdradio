package com.acumen.display
{
	import com.acumen.net.*;

	
	import flash.display.*;
	import flash.events.*;
	
	import com.bit101.components.*;
	
	public class VolumeSlider extends HUISlider
	{
		private var socket:MpdSocket;
		private var dragging:Boolean=false;
	
		public function VolumeSlider(socket:MpdSocket,parent:DisplayObjectContainer = null):void
		{
			this.socket=socket;
			super(parent,5,40,"volume");
			labelPrecision=0;
			addEventListener(Event.CHANGE,changeVolume);
			socket.addEventListener("status changed",updateVolume);
			addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			
			
		}	
		
		public function onMouseDown(e:Event):void
		{
			 dragging=true;
			 stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
		}
		
		public function onMouseUp(e:Event):void
		{
			dragging=false;
			stage.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp);
		}
		
		public function changeVolume(e:Event):void
		{
			socket.volume=Math.round(value);
		}
		
		public function updateVolume(e:Event):void
		{
			if(!dragging)value=socket.volume;
		}

	}
}
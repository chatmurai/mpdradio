package com.acumen.display
{
	import flash.display.*;
	import flash.events.*;
	
	public class Lamp extends Sprite
	{
		private var _on:Sprite=new Sprite();
		private var _off:Sprite=new Sprite();
		
		public function Lamp(onColour:Number=0x00ff,offColour:Number=0xffffff)
		{
			drawRect(_on,onColour);
			drawRect(_off,offColour);
			_on.visible=false;
			addChild(_on);
			addChild(_off);
		}
		
		public function on(e:Event=null):void
		{
			_on.visible=true;
			_off.visible=false;
		}
		
		public function off(e:Event=null):void
		{
			_off.visible=true;
			_on.visible=false;
		}
		
		private function drawRect(s:Sprite,c:Number):void
		{
			s.graphics.lineStyle(1,0x666666);
			s.graphics.beginFill(c,0.7);
			s.graphics.drawRect(0,0,10,10);
			s.graphics.endFill();
		}
	}
}
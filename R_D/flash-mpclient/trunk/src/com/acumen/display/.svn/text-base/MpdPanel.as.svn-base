package com.acumen.display
{
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import com.acumen.net.*;
	import com.acumen.utils.*;
	import com.bit101.components.*;
	
	public class MpdPanel extends Sprite
	{
		public var socket:MpdSocket;
		private var _width:Number;
		private var _height:Number;
	
		public function MpdPanel(socket:MpdSocket,parent:DisplayObjectContainer,width:Number,height:Number)
		{
			if(parent)parent.addChild(this);
			this.socket=socket;
			_width=width;
			_height=height;
			draw();
			Settings.instance.addEventListener(Settings.SETTINGS_SAVED,onSettingsChanged);
		}
		
		public function setPosition(x:Number,y:Number):void
		{
			this.x=x;
			this.y=y;
		}
		
		public override function set width(s:Number):void
		{
			_width=s;
			draw();
		}

		public override function set height(s:Number):void
		{
			_height=s;
			draw();
		}

		
		protected function onSettingsChanged(e:Event):void
		{
			draw();
		}
		
		public function draw():void
		{
			graphics.clear();
			graphics.beginFill(Settings.instance.backgroundColour,1);
			graphics.drawRect(0,0,_width,_height);
			graphics.endFill();
			this.filters=[new BevelFilter(2,45,0xffffff,0.8,0x0,0.4,4,4,1,1)];
		}
	}
}
package com.acumen.display
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	
	import com.bit101.components.*;
	

	public class CloseButton extends Sprite
	{
		private static const SIZE:Number=10;
		
		
		public function CloseButton(parent:DisplayObjectContainer = null,x:Number=0,y:Number=0)
		{
			setPosition(x,y);
			parent.addChild(this);
			buttonMode=true;
			mouseEnabled=true;
			draw();
			addEventListener(MouseEvent.CLICK,close);
		}
		
		public function setPosition(x:Number,y:Number):void
		{
			this.x=x;
			this.y=y;
		}
		
		private function close(e:Event):void
		{
			parent.visible=false;
		}
		
		public function draw():void
		{
			graphics.clear();
			graphics.lineStyle(1,Style.LABEL_TEXT);
			graphics.beginFill(Style.BUTTON_FACE);
			graphics.drawRect(0,0,SIZE,SIZE);
			graphics.endFill();
			graphics.moveTo(2,2);
			graphics.lineTo(SIZE-1,SIZE-1);
			graphics.moveTo(SIZE-1,2);
			graphics.lineTo(2,SIZE-1);
			
		}
	}
}
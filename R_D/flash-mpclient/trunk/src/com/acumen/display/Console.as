package com.acumen.display
{
	import flash.display.*;
	import flash.events.*;
	import flash.ui.*;
	
	import com.bit101.components.*;
	
	public class Console extends Sprite
	{
		protected var _maxLines:uint=128;
		public var textArea:Text;
		public var input:InputText;
		
		public function Console(parent:DisplayObjectContainer=null,x:Number=0,y:Number=0):void
		{
			this.x=x;
			this.y=y;
			if(parent)parent.addChild(this);
			textArea=new Text(this,0,0);
			textArea.setSize(300, 185);
			input=new InputText(this,0,190);
			input.setSize(300,20);
			input.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
		}
		
		public function onKeyDown(k:KeyboardEvent):void
		{
			if(k.keyCode==Keyboard.ENTER)
			{
				var line:String=input.text;
				input.text='';
				dispatchEvent(new ConsoleEvent(ConsoleEvent.LINE_ENTERED,line));
			}
		}
		
		public function append(text:String=''):void
		{
			//textArea.text+=text;
			textArea.text=(textArea.text+text).split('\n').slice(-_maxLines,-1).join('\n');
		}
		
		public function set maxLines(i:uint):void
		{
			_maxLines=i;
			append();
		}
	}
}
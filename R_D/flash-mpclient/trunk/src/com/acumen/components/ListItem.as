package com.acumen.components
{
	import flash.events.*;
	import flash.display.*;
	import flash.text.*;
	
	import com.bit101.components.*;

	public class ListItem extends Sprite
	{
		public var index:*;
		
		private var _selected:Boolean=false;
		protected var _label:Label;
	
		public function ListItem(parent:DisplayObjectContainer = null,x:Number=0,y:Number=0,s:String='',i:*=null):void
		{
			//super(parent,x,y,s);
			if(parent)parent.addChild(this);
			_label=new Label(this,0,0,s);
			this.x=x;
			this.y=y;
			index=i;
			mouseEnabled=true;
			addEventListener(MouseEvent.CLICK,onClick);
			buttonMode=true;
			draw();
		}
		
		public function onClick(e:MouseEvent):void
		{
			dispatchEvent(new ListEvent(ListEvent.ITEM_CLICK,index,e.shiftKey,e.ctrlKey));
		}
		
		public function set selected(s:Boolean):void
		{
			_selected=s;
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function draw():void
		{
			
		}
		
	}
}
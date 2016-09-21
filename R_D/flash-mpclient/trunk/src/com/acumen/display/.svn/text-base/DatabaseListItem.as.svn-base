package com.acumen.display
{
	import com.acumen.net.*;
	import com.acumen.components.*;
	
	import flash.events.*;
	import flash.display.*;
	import flash.filters.*;
	
	public class DatabaseListItem extends ListItem
	{
		protected var socket:MpdSocket;
	
		public var identifier:String;
		public var label:String;
		
		protected var _background:Sprite;

	
		public function DatabaseListItem(socket:MpdSocket,parent:DisplayObjectContainer = null,x:Number=0,y:Number=0,s:String='',i:*=null):void
		{
			label=(s.match(/\//))?s.split('/').pop():s;
			identifier=s;
			
			this.socket=socket;
			addChild(_background=new Sprite());
			_background.graphics.beginFill(0xFFFFFF,1);
			_background.graphics.drawRect(0,0,300,15);
			_background.graphics.endFill();
			_background.alpha=0;
			super(parent,x,y,label,i);	
			
			
			addEventListener(MouseEvent.MOUSE_OVER,enableHighlight);
			addEventListener(MouseEvent.MOUSE_OUT,disableHighlight);
		}
		
		public function disableHighlight(e:Event):void
		{
			_label.filters=[];
		}
		
		public function enableHighlight(e:Event):void
		{
			_label.filters=[new GlowFilter(0x000000,1,6,6,2,1,true),new GlowFilter(0xffffff,1,6,6,2,1,false)];
			
		}
		
		public function addItem(e:ContextMenuEvent):void
		{
			//var item:ListItem=ListItem(e.mouseTarget)
			//var clicked:Array=currentDirectoryContents[item.index].split(': ');
			socket.add(identifier);
		}

		public function addItemAsNext(e:ContextMenuEvent):void
		{
			//var item:ListItem=ListItem(e.mouseTarget)
			//var clicked:Array=currentDirectoryContents[item.index].split(': ');
			socket.addAsNext(identifier);
			
		}
		
		public function get type():String
		{
			return Object(this).constructor.TYPE;
		}

	}
}
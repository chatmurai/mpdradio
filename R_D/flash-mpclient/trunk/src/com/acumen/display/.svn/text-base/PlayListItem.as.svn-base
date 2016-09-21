package com.acumen.display
{
	import com.acumen.net.*;
	import com.acumen.utils.*;
	import com.acumen.components.*;
	
	import flash.events.*;
	import flash.display.*;
	import flash.filters.*;
	import flash.geom.*;
	public class PlayListItem extends ListItem
	{
		public static const DROPPED:String='item dropped';
		
		protected var info:Object={};
		protected var _background:Sprite;
		
		private var old:Point;
		private var dragged:Boolean;

		public function PlayListItem(parent:DisplayObjectContainer = null,x:Number=0,y:Number=0,str:String='',i:*=null):void
		{
			var obj:Object=Parser.pairs(str);
			info=obj;
			info.Title=info.Title||'';
			info.file=info.file||'';
			addChild(_background=new Sprite());
			_background.alpha=0;
			var label:String=Parser.substitute(Settings.instance.playlistSongDisplay,info);
			if(label=='')label=info.file;
			super(parent,x,y,label,i);	
			addEventListener(MouseEvent.MOUSE_OVER,enableHighlight);
			addEventListener(MouseEvent.MOUSE_OUT,disableHighlight);
			addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
		}
		
		public function disableHighlight(e:Event):void
		{
			_label.filters=[];
		}
		
		public function enableHighlight(e:Event):void
		{
			_label.filters=[new GlowFilter(0x000000,1,6,6,2,1,true),new GlowFilter(0xffffff,1,6,6,2,1,false)];
		}
		
		public function onMouseDown(e:Event):void
		{
			startDrag(false,new Rectangle(this.x,0,0,parent.height));
			old=new Point(x,y);
			stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
			dragged=false;
		}
		
		public function onMouseMove(e:MouseEvent):void
		{
			dragged=true;
		}
		
		public function onMouseUp(e:MouseEvent):void
		{
			stopDrag();
			stage.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			dispatchEvent(new Event(DROPPED,true));
			x=old.x;
			y=old.y;
		}
		
		public override function onClick(e:MouseEvent):void
		{
			if(!dragged)
			{
				super.onClick(e);
			}
		}
		
		public override function set selected(s:Boolean):void
		{
			
			if(s){
				
				_background.alpha=1;				
			}else
			{
				_background.alpha=0;
			}
			super.selected=s;
		}
		
		public override function draw():void
		{
			_background.graphics.clear();
			_background.graphics.beginFill(Settings.instance.buttonFaceColour,1);
			_background.graphics.drawRect(0,0,300,15);
			_background.graphics.endFill();
		}

	}
}
package com.acumen.display
{
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;

	import com.acumen.net.*;
	import com.acumen.utils.*;
	
	import com.bit101.components.*;
	
	public class SongSelector extends Sprite
	{
		public var list:LibraryList;
		public var socket:MpdSocket;
		public var closeButton:CloseButton;
		public var breadCrumbs:BreadCrumbs;
	
		public function SongSelector(socket:MpdSocket,parent:DisplayObjectContainer=null)
		{
			if(parent)parent.addChild(this);
			
			new Label(this,5,0,'Browsing Filesystem');
			
			this.socket=socket;
			graphics.beginFill(Settings.instance.backgroundColour,1);
			graphics.drawRect(0,0,320,240);
			graphics.endFill();
			this.filters=[new BevelFilter(2,45,0xffffff,0.8,0x0,0.4,4,4,1,1)];
			
			list=new LibraryList(socket,this,10,65,300,165);
			list.filters=[new BevelFilter(2,225,0xffffff,0.8,0x0,0.4,4,4,1,1,BitmapFilterType.OUTER)];
			
			breadCrumbs=new BreadCrumbs(this,5,15);
			breadCrumbs.addEventListener(TextEvent.LINK,onBreadCrumbHit);

			
			closeButton=new CloseButton(this,305,5);
			visible=false;
			list.addEventListener('list changed',updateBreadCrumbs);
		}
		
		public function updateList(list:Array):void
		{
			
		}
		public function onBreadCrumbHit(e:TextEvent):void
		{
			list.restoreBreadCrumb(int(e.text));
		}
		
		public function updateBreadCrumbs(e:Event):void
		{
			var crumbs:Array=[];
			for(var n:String in list.breadCrumbs)
			{
				if(list.breadCrumbs[n] is DatabaseListItem){
					var crumb:DatabaseListItem=list.breadCrumbs[n];
					crumbs.push(crumb.label);
				}
				else if(list.breadCrumbs[n] is String)
				{
					crumbs.push(list.breadCrumbs[n]);
				}
				
			}
			breadCrumbs.crumbs=crumbs;
		}
		
		public override function set visible(b:Boolean):void
		{
			if(b)list.getDirectory();
			super.visible=b;
		}
				
		public function show(e:Event=null):void
		{
			visible=true;
		}
		
		public function hide(e:Event=null):void
		{
			visible=false;
		}
	}
}
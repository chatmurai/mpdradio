package com.acumen.display
{
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	
	import com.acumen.net.*;
	import com.acumen.utils.*;
	
	public class PlaylistPanel extends MpdPanel
	{
		public var playlist:PlayList;
		//public var socket:MpdSocket;
		
		public function PlaylistPanel(socket:MpdSocket,parent:DisplayObjectContainer=null)
		{
			//if(parent)parent.addChild(this);
			x=0;
			y=80;
			/*this.socket=socket;
			
			graphics.beginFill(Settings.instance.backgroundColour,1);
			graphics.drawRect(0,0,320,120);
			graphics.endFill();
			this.filters=[new BevelFilter(2,45,0xffffff,0.8,0x0,0.4,4,4,1,1)];
			*/
			playlist=new PlayList(socket,this);
			playlist.filters=[new BevelFilter(2,225,0xffffff,0.8,0x0,0.4,4,4,1,1,BitmapFilterType.OUTER)];
			
			super(socket,parent,320,120);
		}
	}
}
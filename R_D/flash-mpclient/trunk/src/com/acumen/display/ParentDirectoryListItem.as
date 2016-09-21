package com.acumen.display
{
	import com.acumen.net.*;
	
	
	import flash.events.*;
	import flash.display.*;
	import flash.filters.*;
	import flash.ui.*;
	
	public class ParentDirectoryListItem extends DatabaseListItem
	{
		public static const TYPE:String='parent';

		public function ParentDirectoryListItem(socket:MpdSocket,parent:DisplayObjectContainer = null,x:Number=0,y:Number=0,s:String='',i:*=null):void
		{
			super(socket,parent,x,y,'..',i);	
			identifier=s;
		}	
	}
}
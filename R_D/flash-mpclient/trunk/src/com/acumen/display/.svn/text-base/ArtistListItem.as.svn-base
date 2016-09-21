package com.acumen.display
{
	import com.acumen.net.*;
	
	
	import flash.events.*;
	import flash.display.*;
	import flash.filters.*;
	import flash.ui.*;
	
	public class ArtistListItem extends DatabaseListItem
	{
		public static const TYPE:String='Artist';
		
		public function ArtistListItem(socket:MpdSocket,parent:DisplayObjectContainer = null,x:Number=0,y:Number=0,s:String='',i:*=null):void
		{
			super(socket,parent,x,y,s,i);	
			var _contextMenu:ContextMenu = new ContextMenu();
			var add:ContextMenuItem=new ContextMenuItem("add");
			add.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,addItem);
			_contextMenu.hideBuiltInItems();
			_contextMenu.customItems.push(add);
			contextMenu = _contextMenu;	
		}	
		
		public override function addItem(e:ContextMenuEvent):void
		{
			socket.addArtist(identifier);
			
		}
	}
}
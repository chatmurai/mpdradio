package com.acumen.display
{
	import com.acumen.net.*;
	
	
	import flash.events.*;
	import flash.display.*;
	import flash.filters.*;
	import flash.ui.*;
	
	public class DirectoryListItem extends DatabaseListItem
	{
		public static const TYPE:String='directory';
		
		public function DirectoryListItem(socket:MpdSocket,parent:DisplayObjectContainer = null,x:Number=0,y:Number=0,s:String='',i:*=null):void
		{
			super(socket,parent,x,y,s.replace(/\n/g,''),i);	
			var _contextMenu:ContextMenu = new ContextMenu();
			var add:ContextMenuItem=new ContextMenuItem("add");
			add.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,addItem);
			_contextMenu.hideBuiltInItems();
			_contextMenu.customItems.push(add);
			contextMenu = _contextMenu;	
		}	
		
		
	}
}
package com.acumen.display
{
	import com.acumen.net.*;
	
	
	import flash.events.*;
	import flash.display.*;
	import flash.filters.*;
	import flash.ui.*;
	
	public class FileListItem extends DatabaseListItem
	{
		public static const TYPE:String='file';
		
		protected var addSelected:ContextMenuItem;
		protected var list:LibraryList;
		
		public function FileListItem(socket:MpdSocket,parent:LibraryList = null,x:Number=0,y:Number=0,s:String='',i:*=null):void
		{
			super(socket,parent,x,y,s,i);	
			this.list=parent;
			var _contextMenu:ContextMenu = new ContextMenu();
			var add:ContextMenuItem=new ContextMenuItem("add");
			var addNext:ContextMenuItem=new ContextMenuItem("add as next");
			addSelected=new ContextMenuItem("add selected");
			addSelected.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,list.addSelected);
			add.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,addItem);
			addNext.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,addItemAsNext);
			_contextMenu.hideBuiltInItems();
			_contextMenu.customItems.push(addSelected,add,addNext);
			contextMenu = _contextMenu;	
		}
		
		public override function set selected(s:Boolean):void
		{
			addSelected.visible=s;
			
			if(s){
				
				_background.alpha=1;				
			}else
			{
				_background.alpha=0;
			}
			super.selected=s;
		}

	}
}
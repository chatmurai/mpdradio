package com.acumen.display
{
	import com.acumen.net.*;
	import com.acumen.utils.*;
	
	
	import flash.events.*;
	import flash.display.*;
	import flash.filters.*;
	import flash.ui.*;
	
	public class SongListItem extends DatabaseListItem
	{
		public static const TYPE:String='Song';
		
		protected var addSelected:ContextMenuItem;
		protected var list:LibraryList;
		
		protected var _info:Object=
		{
		}
		
		public function SongListItem(socket:MpdSocket,parent:LibraryList = null,x:Number=0,y:Number=0,str:String='',i:*=null):void
		{
			var obj:Object=Parser.pairs(str);
			_info=obj;
			_info.Title=_info.Title||'';
			_info.file=_info.file||'';
			var label:String=Parser.substitute(Settings.instance.librarySongDisplay,_info);
			if(label=='')label=_info.file;
			super(socket,parent,x,y,label,i);	
			identifier=_info.file;
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
		
		public function populate(data:Array):void
		{
			var finished:Boolean=false;
			while(data.length>0&&!finished){
				var datumString:String=String(data.shift());
				var datum:Array=datumString.match(/^([^:]*): (.*)$/);
				if(datum==null||datum.length<=2)datum=[null,'',''];
				var key:Object=datum[1];
				var value:String=datum[2];
				switch(key)
				{
					case 'Title':
					case 'file':
					case 'Track':
					case 'Time':
					case 'Album':
					case 'Artist':
						if(_info[key]==null)
							_info[key]=value;
						else
							finished=true;
					break;
					default:
					break;
					case null:
						finished=true;
						break;
					break
				}
			}
			
			if(finished&&key)data.unshift(datumString);
			identifier=_info.file;
			_label.text=_info.Title||_info.file||'';
		}
		
		public function get info():Object
		{
			return _info;
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
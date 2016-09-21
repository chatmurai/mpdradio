package com.acumen.display
{
	import com.acumen.net.*;
	import com.acumen.utils.*;
	import com.acumen.components.*;;
	
	import flash.display.*;
	import flash.events.*;
	import flash.ui.*;
	
	
	public class PlayList extends List
	{
		private var socket:MpdSocket;
		private var playlist:Array;
		
		public function PlayList(socket:MpdSocket,parent:DisplayObjectContainer = null,x:Number=0,y:Number=0,a:Array=null):void
		{
			this.socket=socket;
			super(parent,10, 10);
			addEventListener(ListEvent.ITEM_CLICK,playTrack);
			socket.addEventListener(MpdSocket.PLAYLIST_CHANGED,update);
			socket.addEventListener(MpdSocket.CURRENT_SONG_CHANGED,updateCurrentSong);
			
		}
		
		protected override function init():void
		{
			super.init();
			setSize(300, 100);
		}
		
		public override function set array(a:Array):void
		{
			super.array=a;
			
			//draw();
		}
		
		public function onItemDropped(e:Event):void
		{
			var item:ListItem=ListItem(e.currentTarget);
			if(item)
			{
				
				var index:int=item.index;
				var newIndex:int=Math.round(item.y/15);
				socket.move(index,newIndex);
			}
		}
		
		public override function createItem(x:Number,y:Number,label:String,i:uint):ListItem
		{
			var item:ListItem=new PlayListItem(this,0,i*15,getArrayItem(i).toString(),i);
			var _contextMenu:ContextMenu = new ContextMenu();
			var remove:ContextMenuItem=new ContextMenuItem("remove");
			var removeAll:ContextMenuItem=new ContextMenuItem("remove all");
			var moreByArtist:ContextMenuItem=new ContextMenuItem("more by artist",false,true,true);
			var moreByAlbum:ContextMenuItem=new ContextMenuItem("more by album",false,true,true);
					
			remove.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,removeTrack);
			removeAll.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,removeAllTracks);
			_contextMenu.hideBuiltInItems();
			_contextMenu.customItems.push(remove,removeAll,moreByAlbum,moreByArtist);
			item.contextMenu = _contextMenu;
			item.addEventListener(PlayListItem.DROPPED,onItemDropped);
			
			moreByArtist.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,listMoreByArtist);
			moreByAlbum.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,listMoreByAlbum);

			return item
		}
		
		public function playTrack(e:ListEvent):void
		{
			socket.play(e.index);
		}
		
		public function removeTrack(e:ContextMenuEvent):void
		{
			var item:ListItem=ListItem(e.mouseTarget)
			socket.remove(item.index);
		}
		
		public function removeAllTracks(e:ContextMenuEvent):void
		{
			socket.removeAll();
		}
		
		public function listMoreByArtist(e:ContextMenuEvent):void
		{
			var item:ListItem=ListItem(e.mouseTarget);
			var obj:Object=Parser.pairs(playlist[item.index]);

			dispatchEvent(new ListEvent("more by artist clicked",obj[ArtistListItem.TYPE]));
		}

		public function listMoreByAlbum(e:ContextMenuEvent):void
		{
			var item:ListItem=ListItem(e.mouseTarget);
			var obj:Object=Parser.pairs(playlist[item.index]);	
					
			dispatchEvent(new ListEvent("more by album clicked",obj[AlbumListItem.TYPE]));
		}

		
		protected function update(e:Event):void
		{
			playlist=socket.playlist;			
			array=socket.playlist.map(function(obj:*,index:int,arr:Array):String{return obj.replace(/.*\/(.*)$/,"$1")});	
			updateCurrentSong(e);
		}
		
		protected function updateCurrentSong(e:Event):void
		{
			var newSelected:Array=[];
			var item:ListItem=ListItem(getListItem(socket.currentTrackPlaylistId));
			if(item)newSelected[socket.currentTrackPlaylistId]=item;
			selected=newSelected;
		}
	}
}

package com.acumen.display
{
	import com.acumen.components.*;
	import com.acumen.net.*;
	import com.acumen.utils.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.ui.*;
	
	public class LibraryList extends List
	{
		private var socket:MpdSocket;
		private var playlist:Array;
		private var song:Array;
	
		public static const LIBRARY_TOP_LEVEL:String='Artists';
		public static const FILESYSTEM_TOP_LEVEL:String='Root';
	
		public var currentDirectory:String='';
		
		public var breadCrumbs:Array;
	
		public function LibraryList(socket:MpdSocket,parent:DisplayObjectContainer = null,x:Number=0,y:Number=0,width:Number=320,height:Number=240):void
		{
			this.socket=socket;
			super(parent,x,y);
			addEventListener(ListEvent.ITEM_CLICK,listItemClicked);
			socket.addEventListener("status changed",update);
			setSize(width,height);
			
		}
		
		protected override function init():void
		{
			super.init();
		}
		
		public override function createItem(x:Number,y:Number,label:String,i:uint):ListItem
		{		
			var data:Array;
			if(label.match(/file:/))
			{
				label='Song: '+label;
			}
			
			var pair:Array=label.match(/^([^:]*): (.*)/s);
			
			var item:DatabaseListItem;
			if(pair&&pair.length>=2)
			{
				var key:String=pair[1];
				var value:String=pair[2];
			
				switch(key)
				{
					case SongListItem.TYPE:
						
						item=new SongListItem(socket,this,0,i*15,value,i);
						//SongListItem(item).populate(data);
					break;
					case FileListItem.TYPE:
						item=new FileListItem(socket,this,0,i*15,value,i);
					break;
					case DirectoryListItem.TYPE:
						item=new DirectoryListItem(socket,this,0,i*15,value,i);
					break;
					case ParentDirectoryListItem.TYPE:
						item=new ParentDirectoryListItem(socket,this,0,i*15,value,i);
					break;
					case TitleListItem.TYPE:
						item=new TitleListItem(socket,this,0,i*15,value,i);
					break;
					case AlbumListItem.TYPE:
						item=new AlbumListItem(socket,this,0,i*15,value,i);
					break;
					case ArtistListItem.TYPE:
						item=new ArtistListItem(socket,this,0,i*15,value,i);
					break;				
					default:
						//throw new Error('Database type not found: '+pair[0]);
					break;
				}
			}
		
			return item
		}
		
		public function addSelected(e:Event=null):void
		{
			var selected:Array=selected;
			for each(var item:DatabaseListItem in selected)
			{		
				if(item)socket.add(item.identifier);
			}
			this.selected=[];
		}
		
		public function search(s:String):void
		{
			socket.search(listSongs,s);
		}
		
		public function getArtist():void
		{
			socket.list(listArtists,ArtistListItem.TYPE);
			breadCrumbs=[LIBRARY_TOP_LEVEL];
		}
		
		public function getDirectory():void
		{
			socket.listDirectory('',updateListing);
			currentDirectory='';
			breadCrumbs=[FILESYSTEM_TOP_LEVEL];
		}
		
		public function getSongsByArtist(name:String):void
		{
			socket.find(listSongs,name,ArtistListItem.TYPE);
			breadCrumbs=[LIBRARY_TOP_LEVEL];
		}

		public function getSongsByAlbum(name:String):void
		{
			socket.find(listSongs,name,AlbumListItem.TYPE);
			breadCrumbs=[LIBRARY_TOP_LEVEL];
		}


		public function updateListing(str:String):void
		{
			//var currentList:Array=str.split('\n');
			str=str.replace(/OK$/,'');
			str=str.replace(/file: |directory: /g,'|$&');
			var currentList:Array=str.split('|');
			if(currentDirectory!='')currentList.unshift('parent: '+getParentDirectory(currentDirectory));
			array=currentList;
			dispatchEvent(new Event('list changed'));
			
		}
		
		public function listAlbums(str:String):void
		{
			//str=str.replace(/Album: /g,'|$&');
			
			//var currentList:Array=str.split('|');
			var currentList:Array=str.split('\n');
			array=currentList;
			dispatchEvent(new Event('list changed'));
			
		}

		public function listArtists(str:String):void
		{
			var currentList:Array=str.split('\n');
			array=currentList;
			dispatchEvent(new Event('list changed'));
			
		}
				
		public function listSongs(str:String):void
		{
			str=str.replace(/file: /g,'|$&');
			
			var currentList:Array=str.split('|');
			array=currentList;
			dispatchEvent(new Event('list changed'));
			
		}
		
		public function listItemClicked(e:ListEvent):void
		{
			var item:DatabaseListItem=DatabaseListItem(e.target);
			var name:String=item.identifier;
			switch(item.type)
			{
			case SongListItem.TYPE:
			case FileListItem.TYPE:
				if(e.shiftKey)
				{
					var lastItem:ListItem=selected[selected.length-1];
					if(lastItem)
					{
						var start:int=lastItem.index;
						var end:int=item.index+1;
						selectListItem(list.slice(start,end));
					}
				}else if(e.ctrlKey)
				{
					if(!item.selected)selectListItem(item);
					else deselectListItem(item);
				}else
				{
					var a:Array=new Array();
					a[item.index]=item;
					selected=a;
				}
			break;
			case DirectoryListItem.TYPE:
				currentDirectory=name;
				socket.listDirectory(name,updateListing);
				//if(item!=breadCrumbs[breadCrumbs.length-1])breadCrumbs.push(item);
				var contains:Boolean=false;
				for each(var crumb:* in breadCrumbs)if(crumb==item)contains=true;
				if(!contains)breadCrumbs.push(item);
			break;
			case FileListItem.TYPE:
				if(!item.selected)selectListItem(item);
				else deselectListItem(item);
			break;
			case ParentDirectoryListItem.TYPE:
				currentDirectory=name;	
				socket.listDirectory(name,updateListing);
				breadCrumbs.pop();
				
			break;
			case TitleListItem.TYPE:
				if(!item.selected)selectListItem(item);
				else deselectListItem(item);
			break;
			case ArtistListItem.TYPE:
				currentDirectory=name;
				//socket.listAlbums(name,updateListing);
				socket.list(listAlbums,AlbumListItem.TYPE,ArtistListItem.TYPE,name);
				if(item!=breadCrumbs[breadCrumbs.length-1])breadCrumbs=[LIBRARY_TOP_LEVEL,item];
			break;
			case AlbumListItem.TYPE:
				currentDirectory=name;
				socket.find(listSongs,name,AlbumListItem.TYPE);
				if(item!=breadCrumbs[breadCrumbs.length-1])breadCrumbs.push(item);
				//socket.list(updateListing,FileListItem.TYPE,AlbumListItem.TYPE,name);
				//socket.listFiles(name,updateListing);
			break;	
			default:
				//throw new Error(clicked.toString());
			break;
			}
		}
		
		public function restoreBreadCrumb(i:int):void
		{
			
			var b:*=breadCrumbs[i];
			if(b is DatabaseListItem)
			{
				//Debug.instance.message('mee:'+i+':'+breadCrumbs[i]+':'+breadCrumbs.length);
				if(!b.parent)
				{
					b.visible=false;
					addChild(b);
				}
				b.dispatchEvent(new ListEvent(ListEvent.ITEM_CLICK,b.index,false,false));
				removeChild(b);
			}
			else if(b is String)
			{
				switch(b)
				{
				case LIBRARY_TOP_LEVEL:
					getArtist();
				break;
				case FILESYSTEM_TOP_LEVEL:
					getDirectory();
				break;
				}
			}
		}
		
		public function update(e:Event):void
		{
			
		}
		
		protected function getParentDirectory(dir:String):*
		{
			return (dir.match(/\//))?dir.replace(/\/[^\/]*$/,''):'';
		}
		
	}
}
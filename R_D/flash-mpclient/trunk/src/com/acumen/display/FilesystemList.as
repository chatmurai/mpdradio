package com.acumen.display
{
	import com.acumen.net.*;
	
	import flash.events.*;
	import flash.display.*;
	import flash.ui.*;
	
	public class FilesystemList extends List
	{
		private var socket:MpdSocket;
		private var playlist:Array;
	
		public var currentDirectory:String='';
		public var currentDirectoryContents:Array;

		
		public function FilesystemList(socket:MpdSocket,parent:DisplayObjectContainer = null):void
		{
			this.socket=socket;
			super(parent,10,30);
			addEventListener(ListEvent.ITEM_CLICK,listItemClicked);
			socket.addEventListener("status changed",update);
			
			
		}
		
		protected override function init():void
		{
			super.init();
			setSize(300, 200);
		}
		
		public override function createItem(x:Number,y:Number,label:String,i:uint):ListItem
		{			
			var pair:Array=label.split(': ');
			
			var item:DatabaseListItem;
			if(pair&&pair.length>=2)
			switch(pair[0])
			{
				case FileListItem.TYPE:
					item=new FileListItem(socket,this,0,i*15,pair[1],i);
				break;
				case DirectoryListItem.TYPE:
					item=new DirectoryListItem(socket,this,0,i*15,pair[1],i);
				break;
				case ParentDirectoryListItem.TYPE:
					item=new ParentDirectoryListItem(socket,this,0,i*15,pair[1],i);
				break;
				default:
					//throw new Error('Database type not found: '+pair[0]);
				break;
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
		
		public function getDirectory():void
		{
			socket.listDirectory('',updateListing);
		}

		public function updateListing(str:String):void
		{
			currentDirectoryContents=str.split('\n');
			var currentList:Array=[];
			/*var _currentDirectoryContents:Array=[];
			
			for(var i:uint=0;i<currentDirectoryContents.length;i++)
			{
				var r:Array=currentDirectoryContents[i].split(': ');
				if(r.length>=2&&(r[0]=='file'||r[0]=='directory'))
				{
					currentList.push(r[1].split('/').pop());
					_currentDirectoryContents.push(currentDirectoryContents[i]);

				}
				
				//currentDirectoryContents
			}
			currentDirectoryContents=_currentDirectoryContents;
			*/
			if(currentDirectory!='')currentDirectoryContents.unshift('parent: '+getParentDirectory(currentDirectory));
			array=currentDirectoryContents;
		}
		
		public function listItemClicked(e:ListEvent):void
		{
			var item:DatabaseListItem=DatabaseListItem(e.target);
			var name:String=item.identifier;
			switch(item.type)
			{
			case 'directory':
				currentDirectory=name;
				socket.listDirectory(name,updateListing);
			break;
			case FileListItem.TYPE:
				if(!item.selected)selectListItem(item);
				else deselectListItem(item);
			break;
			case 'parent':
				currentDirectory=name;
				//socket.listDirectory(name,updateListing);
			break;
			default:
				//throw new Error(clicked.toString());
			break;
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
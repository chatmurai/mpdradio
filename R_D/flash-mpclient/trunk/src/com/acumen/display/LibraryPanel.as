package com.acumen.display
{
	import com.acumen.net.*;
	import com.acumen.utils.*;
	import com.acumen.components.*;
	import com.bit101.components.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.text.*;
	
	public class LibraryPanel extends MpdPanel
	{
		public var list:LibraryList;
		public var closeButton:CloseButton;
		public var breadCrumbs:BreadCrumbs;
		public var searchTextField:InputText;
	
		public function LibraryPanel(socket:MpdSocket,parent:DisplayObjectContainer=null,width:Number=320,height:Number=240)
		{
			
			new Label(this,5,0,'Browsing Library');
			
			list=new LibraryList(socket,this,10,65,300,165);
			list.filters=[new BevelFilter(2,225,0xffffff,0.8,0x0,0.4,4,4,1,1,BitmapFilterType.OUTER)];

			new Label(this,10,40,'Search:');
			searchTextField=new InputText(this,50,40);
			searchTextField.setSize(260,15);
			
			
			breadCrumbs=new BreadCrumbs(this,5,20);
			breadCrumbs.addEventListener(TextEvent.LINK,onBreadCrumbHit);
			
			closeButton=new CloseButton(this,305,5);
			visible=false;
			
			list.addEventListener('list changed',updateBreadCrumbs);
			searchTextField.addEventListener(Event.CHANGE,onSearchTextEntered);
			
			list.getArtist();
			
			super(socket,parent,width,height);
		}
		
		public function updateList(list:Array):void
		{
			
		}
		
		public function onSearchTextEntered(e:Event):void
		{
			var searchText:String=InputText(e.currentTarget).text;
			if(searchText.length<3)
			{
				list.getArtist();
			}
			else
			{
				list.search(searchText);
			}
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
		
		public function getSongsByArtist(e:ListEvent):void
		{
			show(e);
			list.getSongsByArtist(e.index);
		}

		public function getSongsByAlbum(e:ListEvent):void
		{
			show(e);
			list.getSongsByAlbum(e.index);
		}

				
		public override function set visible(b:Boolean):void
		{
			//if(b)list.getArtist();
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

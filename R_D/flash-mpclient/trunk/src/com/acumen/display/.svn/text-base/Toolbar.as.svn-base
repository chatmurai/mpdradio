package com.acumen.display
{
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import com.acumen.net.*;
	import com.acumen.utils.*;
	import com.bit101.components.*;
	
	public class Toolbar extends MpdPanel
	{
		public var addButton:AddButton;
		public var libraryButton:PushButton;
		public var settingsButton:PushButton;
	
		public static const ADD_BUTTON_PRESSED:String="add button pressed";
		public static const LIBRARY_BUTTON_PRESSED:String="library button pressed";
		public static const SETTINGS_BUTTON_PRESSED:String='settings button pressed';
	
		public function Toolbar(socket:MpdSocket,parent:DisplayObjectContainer)
		{
			setPosition(0,200);
			
			addButton=new AddButton(this);
			addButton.filters=[new BevelFilter(1,45,0xffffff,0.8,0x0,0.4,1,1,1,1,BitmapFilterType.OUTER)];

			libraryButton=new PushButton(this,110,10,"library",onLibraryButtonClick);
			libraryButton.filters=[new BevelFilter(1,45,0xffffff,0.8,0x0,0.4,1,1,1,1,BitmapFilterType.OUTER)];

			settingsButton=new PushButton(this,215,10,"settings",onSettingsButtonClick);
			settingsButton.filters=[new BevelFilter(1,45,0xffffff,0.8,0x0,0.4,1,1,1,1,BitmapFilterType.OUTER)];

			addButton.addEventListener(MouseEvent.CLICK,onAddButtonClick);
			
			super(socket,parent,320,40);
			
		}
		
		public function onAddButtonClick(e:Event):void
		{
			dispatchEvent(new Event(ADD_BUTTON_PRESSED));
		}
		
		public function onLibraryButtonClick(e:Event):void
		{
			dispatchEvent(new Event(LIBRARY_BUTTON_PRESSED));
		}
		
		public function onSettingsButtonClick(e:Event):void
		{
			dispatchEvent(new Event(SETTINGS_BUTTON_PRESSED));
		}
		
		

	}
}
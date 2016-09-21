package com.acumen.utils
{
	import flash.events.*;
	import flash.net.*;
	public class Settings extends EventDispatcher
	{
		public static const SETTINGS_SAVED:String='settings saved';
		protected static var _instance:Settings; 
	  	protected static var name:String='mpdClient';
		public var _sharedObject:SharedObject;

		public var _playingSongDisplay:String='%Artist%{ - }%Album%{ - }%Title%';
		public var _librarySongDisplay:String='%Track%{ - }%Title%';
		public var _playlistSongDisplay:String='%Track%{ - }%Artist%{ - }%Title%';
	  	public var _backgroundColour:uint=0xc0c0c0;
	  	public var _buttonFaceColour:uint=0xFFFFFF;
	  	public var _progressBarColour:uint=0xFFFFFF;
	  	public var _playlistBackgroundColour:uint=0xF3F3F3;
	  	public var _textColour:uint=0x666666;
		public var _shadowColour:uint=0x0;
	  	
	  	public var consoleLines:uint=1024;
	  	
		public function Settings()
	  	{
			// Verify that the lock is the correct class reference.
	   		/*if ( lock != SingletonLock )
	   		{
	    			throw new Error( "Invalid Singleton access.  Use Settings.instance." );
	    	}
	   		this.sharedObject=sharedObject;
	   		*/
	   	}
		
		public static function get instance():Settings
	  	{
			if(!_instance)
			{
				registerClassAlias('SettingsAlias', Settings);
		   		
				var sharedObject:SharedObject = SharedObject.getLocal(name);
				try
				{
					_instance = (sharedObject.data.settings)?sharedObject.data.settings:new Settings();
				}
				catch(e:TypeError)
				{
					_instance = new Settings();
				}
				_instance.sharedObject=sharedObject;
				sharedObject.setProperty('settings',Settings(_instance));
			}
	   		return _instance;
	   	}
		
		public function set sharedObject(s:SharedObject):void
		{
			_sharedObject=s;
			s.addEventListener(SyncEvent.SYNC,onSync);
		}
		
		public function get sharedObject():SharedObject
		{
			return _sharedObject;
		}
		
		public function save(e:Event=null):void
		{
			sharedObject.setDirty('settings');
			sharedObject.flush();
			dispatchEvent(new Event(SETTINGS_SAVED));
		}
		
		public function onSync(e:Event=null):void
		{
			dispatchEvent(new Event(SETTINGS_SAVED));
		}
		
		public function set librarySongDisplay(s:String):void
		{
			_librarySongDisplay=s;
		}
		
		public function get librarySongDisplay():String
		{
			return _librarySongDisplay;
		}

		public function set playingSongDisplay(s:String):void
		{
			_playingSongDisplay=s;
		}
		
		public function get playingSongDisplay():String
		{
			return _playingSongDisplay;
		}
		
		public function set playlistSongDisplay(s:String):void
		{
			_playlistSongDisplay=s;
		}
		
		public function get playlistSongDisplay():String
		{
			return _playlistSongDisplay;
		}
		
		public function set backgroundColour(s:uint):void
		{
			_backgroundColour=s;
		}
		
		public function get backgroundColour():uint
		{
			return _backgroundColour;
		}
		
		public function set buttonFaceColour(s:uint):void
		{
			_buttonFaceColour=s;
		}
		
		public function get buttonFaceColour():uint
		{
			return _buttonFaceColour;
		}
		
		public function set progressBarColour(s:uint):void
		{
			_progressBarColour=s;
		}
		
		public function get progressBarColour():uint
		{
			return _progressBarColour;
		}
		
		public function set playlistBackgroundColour(s:uint):void
		{
			_playlistBackgroundColour=s;
		}
		
		public function get playlistBackgroundColour():uint
		{
			return _playlistBackgroundColour;
		}
		
		public function set textColour(s:uint):void
		{
			_textColour=s;
		}
		
		public function get textColour():uint
		{
			return _textColour;
		}
		
		public function set shadowColour(s:uint):void
		{
			_shadowColour=s;
		}
		
		public function get shadowColour():uint
		{
			return _shadowColour;
		}	
		
		/*public function set consoleLines(i:uint):void
		{
			_consoleLines=i;
		}
		
		public function get consoleLines():uint
		{
			return _consoleLines=i;
		}*/
	}
	
}

internal class SingletonLock
{
	
} 
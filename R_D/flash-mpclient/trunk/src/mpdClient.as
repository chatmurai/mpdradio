package
{
	import com.acumen.display.*;
	import com.acumen.net.*;
	import com.acumen.utils.*;
	import com.bit101.components.*;
	
	import flash.display.*;
	import flash.errors.*;
	import flash.events.*;
	import flash.external.ExternalInterface;
	import flash.utils.*;
	
	[SWF(width="320", height="240", backgroundColor="#fef9fe", frameRate="25")]
	public class mpdClient extends Sprite
	{
		public var titleBar:TitleBar;
		public var songSelector:SongSelector;
		public var libraryPanel:LibraryPanel;
		public var settingsPanel:SettingsPanel;
		public var controls:Controls;
		public var playlistPanel:PlaylistPanel;
		public var toolbar:Toolbar;
		
		public var socket:MpdSocket;
	
		public function mpdClient()
		{ 
			/*
			 * Set style information, and set a listener for changes to
			 * setting that will fire a style update.
			 */
			updateStyle();
			Settings.instance.addEventListener(Settings.SETTINGS_SAVED,updateStyle);
			var flashvars:Object = LoaderInfo(this.root.loaderInfo).parameters;
			var hostnameMatch:Array=(root.loaderInfo.loaderURL).match(/\/\/([^\/]+)/);
			if(!flashvars.hostname&&hostnameMatch.length>=2)flashvars.hostname=hostnameMatch[1];
    		socket=new MpdSocket(flashvars.hostname,flashvars.port,(flashvars.dual_socket=='true'));
    		
    		/*
    		 * set debug level
    		 */
    		Debug.instance.level=flashvars.debugLevel||0;
			
			/*
			 * Create top level control panels
			 */
			titleBar=new TitleBar(socket,this,flashvars.title);
			controls=new Controls(socket,this);
			playlistPanel=new PlaylistPanel(socket,this);
			toolbar=new Toolbar(socket,this);
			songSelector=new SongSelector(socket,this);
			libraryPanel=new LibraryPanel(socket,this);
			settingsPanel=new SettingsPanel(socket,this);
			new ConsolePanel(socket,this);
			
			playlistPanel.addEventListener("more by artist clicked",libraryPanel.getSongsByArtist);
			playlistPanel.addEventListener("more by album clicked",libraryPanel.getSongsByAlbum);
			
			toolbar.addEventListener(Toolbar.ADD_BUTTON_PRESSED,songSelector.show);
			toolbar.addEventListener(Toolbar.LIBRARY_BUTTON_PRESSED,libraryPanel.show);
			toolbar.addEventListener(Toolbar.SETTINGS_BUTTON_PRESSED,settingsPanel.show);
		}
		
		
		
		public function updateStyle(e:Event=null):void
		{
			Style.BACKGROUND=Settings.instance.playlistBackgroundColour;
			Style.BUTTON_FACE=Settings.instance.buttonFaceColour;
			Style.PROGRESS_BAR=Settings.instance.progressBarColour;
			Style.PANEL=Settings.instance.playlistBackgroundColour;
			Style.LABEL_TEXT=Settings.instance.textColour;
			Style.INPUT_TEXT=Settings.instance.textColour;
			Style.DROPSHADOW=Settings.instance.shadowColour;
			
		}
		
	}
}

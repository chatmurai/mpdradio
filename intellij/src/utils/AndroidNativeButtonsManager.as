package utils
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class AndroidNativeButtonsManager extends EventDispatcher
	{
		
		public static const BACK_KEY_PRESS:String = "backKeyPress"; 
		public static const MENU_KEY_PRESS:String = "menuKeyPress"; 
		public static const SEARCH_KEY_PRESS:String = "searchKeyPress"; 
		
		public function AndroidNativeButtonsManager()
		{
			super();
			
			NativeApplication.nativeApplication.addEventListener( KeyboardEvent.KEY_DOWN, checkKeypress );
		}
		
		public function checkKeypress( e:KeyboardEvent ):void
		{
			
			e.preventDefault();
			
			switch ( e.keyCode )
			{
				case Keyboard.BACK:
					e.preventDefault();
					dispatchEvent( new Event( AndroidNativeButtonsManager.BACK_KEY_PRESS, false, false ) );
					break;
				case Keyboard.MENU:
					dispatchEvent( new Event( AndroidNativeButtonsManager.MENU_KEY_PRESS, false, false ) );
					break;
				case Keyboard.SEARCH:
					dispatchEvent( new Event( AndroidNativeButtonsManager.SEARCH_KEY_PRESS, false, false ) );
					break;
			}
		}
	}
}
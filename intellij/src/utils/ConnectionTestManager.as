package utils
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.net.URLRequest;
	
	import air.net.URLMonitor;

	public class ConnectionTestManager extends EventDispatcher
	{
		public static const CONNECTION_FOUND:String = "connectionFound";
		public static const CONNECTION_NOT_FOUND:String = "connectionNotFound";
		
		private var _um:URLMonitor;
		
		public function ConnectionTestManager()
		{
		}
		
		/**
		 * Test the connection against an URL
		 */
		public function checkConnection( testURL:String ):void
		{
			var ur:URLRequest = new URLRequest( testURL );
			if( _um == null )
			{
				_um = new URLMonitor( ur );
				_um.addEventListener( StatusEvent.STATUS, onCheckConnectionStatusComplete );
			}
			_um.start();
		}
		
		/**
		 * Triggered when test is complete
		 */
		private function onCheckConnectionStatusComplete( e:StatusEvent ):void
		{
			if( e.code == "Service.available" )
			{
				dispatchEvent( new Event( ConnectionTestManager.CONNECTION_FOUND, true, false ));
			}
			else
			{
				dispatchEvent( new Event( ConnectionTestManager.CONNECTION_NOT_FOUND, true, false ));
			}
			
			_um.stop();
			
		}
		
	}
}

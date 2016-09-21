package net.event
{
	import flash.events.Event;

	import model.vo.MPDInfosVO;

	/**
	 * The MpdSocketEvent class represents the events dispatched by the MpdSocket class.
	 *
	 * @see net.MpdSocket
	 * @author Zbam
	 */


	public class MpdSocketEvent extends Event
	{

		//public var bmpd:BitmapData;

		/**
		 * Events strings
		 */
		public static const SOCKET_CONNECTING:String = "socketConnecting";
		public static const SOCKET_CONNECTED:String = "socketConnected";
		public static const SOCKET_CLOSING:String = "socketClosing";
		public static const SOCKET_CLOSED:String = "socketClosed";
		public static const SOCKET_ERROR:String = "socketError";
		public static const SOCKET_DATA_SENT:String = "socketDataSent";
		public static const SOCKET_DATA_RECEIVED:String = "socketDataReceived";

		public var mivo:MPDInfosVO;

		/**
		 * Creates a new MpdSocketEvent object.
		 *
		 * @param type The type of the event.
		 * @param bubbles Indicates whether the event is a bubbling event.
		 * @param cancelable Indicates whether the behavior associated with the event can be prevented.
		 *
		 */
		public function MpdSocketEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false, pMivo:MPDInfosVO = null)
		{
			super( type, bubbles, cancelable );

			mivo = pMivo;

		}

		/**
		 * @private
		 */
		public override function clone():Event
		{
			return new MpdSocketEvent( type, bubbles, cancelable );
		}

		/**
		 * @private
		 */
		public override function toString():String
		{
			return '[MpdSocketEvent type="' + type + '" bubbles=' + bubbles + ' cancelable=' + cancelable + ']';
		}

	}

}
package com.acumen.net
{
	import flash.events.*;

	public class TelnetEvent extends Event
	{
		public static const SENT_DATA:String='telnet data sent';
		public static const RECEIVED_DATA:String='telnet data received';
		
		public var data:String;
	
		public function TelnetEvent(event:String,data:String):void
		{
			this.data=data;
			super(event);
		}
	}
}
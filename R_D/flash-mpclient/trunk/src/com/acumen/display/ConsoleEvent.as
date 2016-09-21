package com.acumen.display
{
	import flash.events.*;
	
	public class ConsoleEvent extends Event
	{
		public static const LINE_ENTERED:String='line entered';
		public var data:String;
	
		public function ConsoleEvent(event:String,data:String):void
		{
			this.data=data;
			super(event);
		}
	}
}
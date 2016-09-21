package com.acumen.components
{
	import flash.events.*;
	
	import com.bit101.components.*;

	public class ListEvent extends Event
	{
		public static const ITEM_CLICK:String='list item click';
		
		public var index:*;
		public var shiftKey:Boolean;
		public var ctrlKey:Boolean;
		
		public function ListEvent(event:String,i:*,shiftKey:Boolean=false,ctrlKey:Boolean=false)
		{
			super(event,true);
			this.shiftKey=shiftKey;
			this.ctrlKey=ctrlKey;
			index=i;
		}
	}
}
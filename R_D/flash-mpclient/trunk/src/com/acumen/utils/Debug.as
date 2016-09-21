package com.acumen.utils
{
	import flash.external.*;
	
	public class Debug
	{
		private static var _instance:Debug;

		public var level:int=0;
		
		public function Debug()
		{
			if(_instance)throw new Error('Debug is singleton use Debug.instance');
			_instance=this;
		}
		
		public static function get instance():Debug
		{
			if(_instance==null)new Debug();
			return _instance;
		}
		
		public function message(str:String,level:int=0):void
		{
			if(level<=this.level)ExternalInterface.call("debugMessage",str);
		}
		
		public function populateTag(id:String,data:*,level:int=0):void
		{
			if(level<=this.level)ExternalInterface.call("populateTag",id,data);
		}
		/*
		 * ExternalInterface.call("showMpdInformation",socket.info);
			ExternalInterface.call("showMpdStatus",socket.status);
			
		 */ 
		 
	}
}
package com.acumen.display
{
	import com.acumen.net.*;
	
	import flash.events.*;
	import flash.display.*;
	import flash.filters.*;
	
	import com.bit101.components.*;
	import com.acumen.components.*;
	
	public class BreadCrumbs extends AcuLabel
	{
		public var _crumbs:Array;
	
		public function BreadCrumbs(parent:DisplayObjectContainer = null, x:Number = 0, y:Number =  0 ):void
		{
			super(parent,x,y,'breadcrumbs');
			mouseChildren=true;
			//_tf.mouseEnabled=true;
			
			
		}
		
		public function set crumbs(c:Array):void
		{
			var text:String='';
			for(var n:String in c)
			{
				var crumb:String=String(c[n]);
				text+='<a href="event:'+n+'"><u>'+crumb+'</u> </a>/ ';
			}
			this.text=text;
		}
		
		
	}
	
}
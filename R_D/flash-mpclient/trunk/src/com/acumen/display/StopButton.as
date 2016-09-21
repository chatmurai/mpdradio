package com.acumen.display
{
	import flash.display.*;
	import flash.text.*;
	
	import com.bit101.components.*;
	
	public class StopButton extends SymbolButton
	{
		//public var label:TextField=new TextField();
		public function StopButton(parent:DisplayObjectContainer)
		{
			super(parent,69,5,SymbolButton.SYMBOL_STOP);
		}
		
		protected override function init():void
		{
			super.init();
			setSize(30,20);	
		}
	}
}
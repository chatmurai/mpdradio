package com.acumen.display
{
	import flash.display.*;
	import flash.text.*;
	
	import com.bit101.components.*;
	

	public class PlayButton extends SymbolButton
	{

		public function PlayButton(parent:DisplayObjectContainer)
		{
			super(parent,37,5,SymbolButton.SYMBOL_PLAY);
			//buttonMode=true;
			//mouseChildren=false;
			//addChild(label);
			//x=100;
			//y=0;
			//mouseEnabled=true;
			
		}
		
		protected override function init():void
		{
			super.init();
			setSize(30,20);	
		}
	}
}
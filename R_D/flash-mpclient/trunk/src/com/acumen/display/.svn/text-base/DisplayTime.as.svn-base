package com.acumen.display
{
	import flash.display.*;
	import flash.events.*;
	
	import com.bit101.components.*;
	
	import com.acumen.net.*;
	import com.acumen.utils.*;
	
	public class DisplayTime extends Sprite
	{

		private var socket:MpdSocket;
		private var label:Label;
		private var progressBar:ProgressBar;
		public function DisplayTime(socket:MpdSocket,parent:DisplayObjectContainer=null)
		{
			if(parent)parent.addChild(this);
			x=130;
			y=0;
			
			this.socket=socket;
			socket.addEventListener("status changed",update);
			
			progressBar=new ProgressBar(this,5,5);
			label=new Label(this,106,2,"");
			
			progressBar.buttonMode=true;
			progressBar.addEventListener(MouseEvent.MOUSE_DOWN,skipTime);
			
			visible=false;
		}
		
		public function skipTime(e:MouseEvent):void
		{
			/*
			 * Calculate fraction along the progress bar that the user clicked.
			 * Drop off a few pixels to width and mouse position, so making easier to 
			 * go to begin or front of track. Make sure limits are 0<=t<=1
			 */
			var fraction:Number=Math.min(1,Math.max(0,(progressBar.mouseX-2)/(progressBar.width-4)));
			/*
			 * Multiply fraction by track length then sent to socket
			 */
			socket.trackTime=Math.round(fraction*progressBar.maximum).toString();
		}
		
		public function set time(s:String):void
		{
			var times:Array=s.split(':');
			if(times.length==2&&(Number(times[1])>0))
			{
				progressBar.maximum=Number(times[1]);
				progressBar.value=Number(times[0]);
				label.text=' '+int(progressBar.value/60)+'m'+(progressBar.value%60)+'s/'+int(progressBar.maximum/60)+'m'+(progressBar.maximum%60)+'s';
				visible=true;
			}
			else
			{
				progressBar.maximum=1;
				progressBar.value=0;
				label.text='';
				visible=false;
			}
		}
		
		public function update(e:Event):void
		{
			time=socket.trackTime;
		}
	}
}
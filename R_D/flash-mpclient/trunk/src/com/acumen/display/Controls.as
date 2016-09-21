package com.acumen.display
{
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;

	import com.acumen.net.*;
	import com.acumen.utils.*;
	
	public class Controls extends MpdPanel
	{
		public var playButton:PlayButton;
		public var stopButton:StopButton;
		public var nextButton:NextButton;
		public var previousButton:PreviousButton;
		public var pauseButton:PauseButton;

		public var volumeSlider:VolumeSlider;
		public var randomCheckbox:RandomCheckbox;
		public var repeatCheckbox:RepeatCheckbox;

		public var trackDisplay:DisplayTrack;
		public var timeDisplay:DisplayTime;
	
		public function Controls(socket:MpdSocket,parent:DisplayObjectContainer=null)
		{
			this.x=0;
			this.y=20;
			var buttonFilter:Array=[new BevelFilter(1,45,0xffffff,0.8,0x0,0.4,1,1,1,1,BitmapFilterType.OUTER)];
			
			playButton=new PlayButton(this);
			playButton.filters=buttonFilter;
			stopButton=new StopButton(this);
			stopButton.filters=buttonFilter;
			nextButton=new NextButton(this);
			nextButton.filters=buttonFilter;
			previousButton=new PreviousButton(this);
			previousButton.filters=buttonFilter;
			pauseButton=new PauseButton(this);
			pauseButton.filters=buttonFilter;
			
			repeatCheckbox=new RepeatCheckbox(socket,this);
			randomCheckbox=new RandomCheckbox(socket,this);
			volumeSlider=new VolumeSlider(socket,this);
			timeDisplay=new DisplayTime(socket,this);
			trackDisplay=new DisplayTrack(socket,this);
			
			
			playButton.addEventListener(MouseEvent.CLICK,play);
			stopButton.addEventListener(MouseEvent.CLICK,stop);
			nextButton.addEventListener(MouseEvent.CLICK,next);
			previousButton.addEventListener(MouseEvent.CLICK,previous);
			pauseButton.addEventListener(MouseEvent.CLICK,pause);
			
			socket.addEventListener(MpdSocket.STATUS_CHANGED,update);
			
			super(socket,parent,320,60);
			
			/*graphics.beginFill(Settings.instance.backgroundColour);
			graphics.drawRect(-5,-5,320,60);
			graphics.endFill();
			this.filters=[new BevelFilter(2,45,0xffffff,0.8,0x0,0.4,4,4,1,1)];*/
		}
		
		public function update(e:Event=null):void
		{
			pauseButton.visible=socket.playing;
			playButton.visible=!socket.playing;
			
		}
		
		public function play(e:Event=null):void
		{
			socket.play();
		}
		
		public function stop(e:Event=null):void
		{
			socket.stop();
		}

		public function next(e:Event=null):void
		{
			socket.next();
		}
		
		public function previous(e:Event=null):void
		{
			socket.previous();
		}
	
		public function pause(e:Event=null):void
		{
			socket.pause();
		}
		
		public override function draw():void
		{
			super.draw();
			playButton.draw();
			stopButton.draw();
			nextButton.draw();
			previousButton.draw();
			pauseButton.draw();
	
			volumeSlider.draw();
			randomCheckbox.draw();
			repeatCheckbox.draw();
			
		}

	}
}
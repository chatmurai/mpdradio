package com.acumen.display
{
	import com.acumen.net.*;
	import com.acumen.utils.*;
	import com.bit101.components.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	
	public class SettingsPanel extends MpdPanel
	{
		public var display1Container:Sprite=new Sprite();
		public var display2Container:Sprite=new Sprite();
			
		
		//public var socket:MpdSocket;
		public var closeButton:CloseButton;
		public var librarySongDisplayInput:InputText;
		public var playingSongDisplayInput:InputText;
		public var playlistSongDisplayInput:InputText;
		public var backgroundColourChooser:ColorChooser;	
		public var buttonFaceColourChooser:ColorChooser;	
		public var playlistBackgroundColourChooser:ColorChooser;	
		public var textColourChooser:ColorChooser;
		public var shadowColourChooser:ColorChooser;
		public var consoleLinesField:InputText;
		public var saveButton:PushButton;
		
		public function SettingsPanel(socket:MpdSocket,parent:DisplayObjectContainer=null)
		{
			
			var buttonFilter:Array=[new BevelFilter(1,45,0xffffff,0.8,0x0,0.4,1,1,1,1,BitmapFilterType.OUTER)];
			
			new Label(this,5,0,'Settings');
			var pages:BreadCrumbs=new BreadCrumbs(this,50,0);
			pages.crumbs=['song display','general display'];
			pages.addEventListener(TextEvent.LINK,onTabHit);

			
			this.addChild(display1Container);
			this.addChild(display2Container);
			this.display2Container.visible=false;
			
			this.filters=[new BevelFilter(2,45,0xffffff,0.8,0x0,0.4,4,4,1,1)];
			
			/*
			 * Create first tab
			 */
			
			new Label(this.display1Container,10,30,'playing song description');
			playingSongDisplayInput=new InputText(this.display1Container,120,30,Settings.instance.playingSongDisplay,updateSettings);
			new Label(this.display1Container,10,55,'playlist song description');
			playlistSongDisplayInput=new InputText(this.display1Container,120,55,Settings.instance.playlistSongDisplay,updateSettings);
			new Label(this.display1Container,10,80,'library song description');
			librarySongDisplayInput=new InputText(this.display1Container,120,80,Settings.instance.librarySongDisplay,updateSettings);
			
			/*
			 * Create second tab
			 */

			
			new Label(this.display2Container,10,30,'text colour');
			textColourChooser=new ColorChooser(this.display2Container,120,30,Settings.instance.textColour,updateSettings);
			
			new Label(this.display2Container,10,55,'background colour');
			backgroundColourChooser=new ColorChooser(this.display2Container,120,55,Settings.instance.backgroundColour,updateSettings);

			new Label(this.display2Container,10,80,'button colour');
			buttonFaceColourChooser=new ColorChooser(this.display2Container,120,80,Settings.instance.buttonFaceColour,updateSettings);

			new Label(this.display2Container,10,105,'playlist colour');
			playlistBackgroundColourChooser=new ColorChooser(this.display2Container,120,105,Settings.instance.playlistBackgroundColour,updateSettings);

			new Label(this.display2Container,10,130,'shadow colour');
			shadowColourChooser=new ColorChooser(this.display2Container,120,130,Settings.instance.shadowColour,updateSettings);

			new Label(this.display2Container,10,155,'console lines');
			consoleLinesField=new InputText(this.display2Container,120,155,Settings.instance.consoleLines.toString(),updateSettings);

			//new Label(this,10,105,'playlist background colour');
			//backgroundColourChooser=new ColorChooser(this,120,105,Settings.instance.playlistBackgroundColour,updateSettings);

			
			saveButton=new PushButton(this,10,210,"save",Settings.instance.save);
			saveButton.filters=buttonFilter;
			playlistSongDisplayInput.setSize(180,20);
			librarySongDisplayInput.setSize(180,20);
			playingSongDisplayInput.setSize(180,20);
			closeButton=new CloseButton(this,305,5);
			
			visible=false;
			
			super(socket,parent,320,240);
			
		}
		
		public function onTabHit(e:TextEvent):void
		{
			this.display1Container.visible=false;
			this.display2Container.visible=false;
			
			switch(e.text)
			{
				case '0':
					this.display1Container.visible=true;
					break;
				case '1':
					this.display2Container.visible=true;
					break;
			}
		}
		
		public function updateSettings(e:Event):void
		{
			Settings.instance.playingSongDisplay=playingSongDisplayInput.text;
			Settings.instance.playlistSongDisplay=playlistSongDisplayInput.text;
			Settings.instance.librarySongDisplay=librarySongDisplayInput.text;
			Settings.instance.backgroundColour=backgroundColourChooser.value;
			Settings.instance.buttonFaceColour=buttonFaceColourChooser.value;
			Settings.instance.progressBarColour=buttonFaceColourChooser.value;
			Settings.instance.playlistBackgroundColour=playlistBackgroundColourChooser.value;
			Settings.instance.textColour=textColourChooser.value;
			Settings.instance.shadowColour=shadowColourChooser.value;
			Settings.instance.consoleLines=int( consoleLinesField.text );
		}
		
		public function update(e:Event=null):void
		{
			playingSongDisplayInput.text=Settings.instance.playingSongDisplay;
			playlistSongDisplayInput.text=Settings.instance.playlistSongDisplay;
			librarySongDisplayInput.text=Settings.instance.librarySongDisplay;
			backgroundColourChooser.value=Settings.instance.backgroundColour;
			textColourChooser.value=Settings.instance.textColour;
			buttonFaceColourChooser.value=Settings.instance.buttonFaceColour;
			playlistBackgroundColourChooser.value=Settings.instance.playlistBackgroundColour;
			shadowColourChooser.value=Settings.instance.shadowColour;
			consoleLinesField.text=Settings.instance.consoleLines.toString();
		}
		
		public function show(e:Event=null):void
		{
			visible=true;
		}
		
		public function hide(e:Event=null):void
		{
			Settings.instance.save();
			visible=false;
		}
		
		public override function draw():void
		{
			super.draw();
			closeButton.draw();
			librarySongDisplayInput.draw();
			playlistSongDisplayInput.draw();
			backgroundColourChooser.draw();	
			buttonFaceColourChooser.draw();	
			playlistBackgroundColourChooser.draw();	
			textColourChooser.draw();
			shadowColourChooser.draw();
		}
	}
}
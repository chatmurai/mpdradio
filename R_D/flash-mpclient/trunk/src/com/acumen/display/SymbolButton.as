/**
 * PushButton.as
 * Keith Peters
 * version 0.91
 * 
 * A basic button component with a label.
 * 
 * Source code licensed under a Creative Commons Attribution-Share Alike 3.0 License.
 * http://creativecommons.org/licenses/by-sa/3.0/
 * Some Rights Reserved.
 */
 
package com.acumen.display
{
	import flash.display.*;
	import flash.events.MouseEvent;
	import flash.text.*;
	import com.bit101.components.*;
	
	public class SymbolButton extends Component
	{
		private var _back:Sprite;
		private var _face:Sprite;
		private var _over:Boolean = false;
		private var _down:Boolean = false;
		private var symbol:String;
		
		public static const SYMBOL_PLAY:String='4';
		public static const SYMBOL_PAUSE:String=';';
		public static const SYMBOL_STOP:String='<';
		public static const SYMBOL_NEXT:String=':';
		public static const SYMBOL_PREVIOUS:String='9';
	
		[Embed(source="/assets/Webdings.ttf",fontName="_webdings",fontFamily="webdings",unicodeRange="U+0034,U+0039,U+003A,U+003B,U+003C")]
		public static var webdingsFont:String;

	
		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this PushButton.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 * @param label The string to use for the initial label of this component.
 		 * @param defaultHandler The event handling function to handle the default event for this component (click in this case).
		 */
		public function SymbolButton(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number =  0,symbolCharacter:String='', defaultHandler:Function = null)
		{
			symbol=symbolCharacter;
			super(parent, xpos, ypos);
			if(defaultHandler != null)
			{
				addEventListener(MouseEvent.CLICK, defaultHandler);
			}
			
		}
		
		/**
		 * Initializes the component.
		 */
		override protected function init():void
		{
			super.init();
			buttonMode = true;
			useHandCursor = true;
			setSize(100, 20);
		}
		
		public override function setSize(w:Number,h:Number):void
		{
			super.setSize(w,h)
		}
		
		/**
		 * Creates and adds the child display objects of this component.
		 */
		override protected function addChildren():void
		{
			_back = new Sprite();
			_back.filters = [getShadow(2, true)];
			addChild(_back);
			
			_face = new Sprite();
			_face.filters = [getShadow(1)];
			_face.x = 1;
			_face.y = 1;
			addChild(_face);
			
			//_label = new Label();
			//addChild(_label);
			
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
		}
		
		
		
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		/**
		 * Draws the visual ui of the component.
		 */
		override public function draw():void
		{
			super.draw();
			_back.graphics.clear();
			_back.graphics.beginFill(Style.BACKGROUND);
			_back.graphics.drawRect(0, 0, _width, _height);
			_back.graphics.endFill();
			
			_face.graphics.clear();
			_face.graphics.beginFill(Style.BUTTON_FACE);
			_face.graphics.drawRect(0, 0, _width - 2, _height - 2);
			_face.graphics.endFill();
			
			var oldLabel:DisplayObject=getChildByName('label')
			if(oldLabel)removeChild(oldLabel);
			
			var label:TextField=new TextField();
			addChild(label);
			label.defaultTextFormat=new TextFormat('_webdings','16',Style.LABEL_TEXT,false,false,false,null,null,TextFormatAlign.CENTER);
			label.embedFonts=true;
			label.text=symbol;
			label.width=width;
			label.autoSize=TextFieldAutoSize.NONE;
			label.x=0;
			label.y=0;
			label.name='label';
			label.mouseEnabled=false;
			label.antiAliasType = AntiAliasType.ADVANCED;
			label.height=height;
			//label.sharpness = 200;
			//label.thickness = -100;
			
		}
		
		
		
		
		///////////////////////////////////
		// event handlers
		///////////////////////////////////
		
		/**
		 * Internal mouseOver handler.
		 * @param event The MouseEvent passed by the system.
		 */
		private function onMouseOver(event:MouseEvent):void
		{
			_over = true;
			addEventListener(MouseEvent.ROLL_OUT, onMouseOut);
		}
		
		/**
		 * Internal mouseOut handler.
		 * @param event The MouseEvent passed by the system.
		 */
		private function onMouseOut(event:MouseEvent):void
		{
			_over = false;
			if(!_down)
			{
				_face.filters = [getShadow(1)];
			}
		}
		
		/**
		 * Internal mouseOut handler.
		 * @param event The MouseEvent passed by the system.
		 */
		private function onMouseDown(event:MouseEvent):void
		{
			_down = true;
			_face.filters = [getShadow(1, true)];
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		/**
		 * Internal mouseUp handler.
		 * @param event The MouseEvent passed by the system.
		 */
		private function onMouseUp(event:MouseEvent):void
		{
			_down = false;
			_face.filters = [getShadow(1)];
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
	}
}
package view.module
{

	import com.electrofrog.EnhancedTextField;
	import com.greensock.TweenMax;
	
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextFieldType;
	import flash.text.TextFormatAlign;
	
	import org.gestouch.events.GestureEvent;
	import org.gestouch.gestures.LongPressGesture;
	
	public class TextButton extends Sprite
	{

		public static const BUTTON_TRIGGERED:String = "buttonTriggered";

		protected var _activated:Boolean = false;
		public function get  activated():Boolean{return _activated};
		
		protected var _width:uint;
		protected var _height:uint;
		protected var _font:String;
		protected var _text:String;
		protected var _color1:uint;
		protected var _color2:uint;
		protected var _background:Sprite;
		protected var _touchZone:Sprite;
		protected var _textField:EnhancedTextField;
		protected var _press:LongPressGesture;
		
		public function TextButton( pWidth:uint, 
									pHeight:uint, 
									pFont:String = "Arial",
									pText:String = "ok", 
									pColor1:uint = 0x333333, 
									pColor2:uint = 0xFF0000 )
		{
			super();
			
			_width = pWidth;
			_height = pHeight;
			_font = pFont;
			_text = pText;
			_color1 = pColor1;
			_color2 = pColor2;
			
			// Backgound
			_background = new Sprite();
			_background.graphics.beginFill( _color1, 1 );
			_background.graphics.drawRect( 0, 0, _width, _height );
			_background.graphics.endFill();
			
			// TEXTFIELD
			var fontSize:uint = Math.round( _height * .3 );
			_textField = new EnhancedTextField( TextFieldType.DYNAMIC, 
												_width, 
												_height / 2,
												"",
												_font,
                                                fontSize,
												_color2,
												_color1,
												0,
												TextFormatAlign.CENTER,
												true,
												true,
												false,
												0);
			
			// TODO trouver un algo correct pour placer le champ texte au milieu
			_textField.text = _text;
			_textField.y = ( _height - _textField.height ) / 2;
			//_textField.y = Math.round( _height / 5 );

			
			// TouchZone
			_touchZone = new Sprite();
			_touchZone.alpha = 0;
			_touchZone.graphics.beginFill( 0XFF0000, 1 );
			_touchZone.graphics.drawRect( 0, 0, _width, _height );
			_touchZone.graphics.endFill();
			
			addChild( _background );
			addChild( _textField );
			addChild( _touchZone );
			
			activate();
			
		}
		
		public function activate():void
		{ 

			if( !_activated )
			{
				
				trace( this + " activate() " + name );
				
				_press = new LongPressGesture( _touchZone );
				_press.numTouchesRequired = 1;
				_press.minPressDuration = 0;
				
				if( !_press.hasEventListener( GestureEvent.GESTURE_BEGAN ) ) _press.addEventListener( GestureEvent.GESTURE_BEGAN, onTouchZoneBegan );
				if( !_press.hasEventListener( GestureEvent.GESTURE_CHANGED ) ) _press.addEventListener( GestureEvent.GESTURE_CHANGED, onTouchZoneChanged );
				if( !_press.hasEventListener( GestureEvent.GESTURE_ENDED ) ) _press.addEventListener( GestureEvent.GESTURE_ENDED, onTouchZoneEnd );
				
				_activated = true;
				
			}
		}
		
		public function deactivate():void
		{
			
			if( _activated )
			{
				trace( this + " deactivate() " + name );
				
				if( _press.hasEventListener( GestureEvent.GESTURE_BEGAN ) ) _press.removeEventListener( GestureEvent.GESTURE_BEGAN, onTouchZoneBegan );
				if( _press.hasEventListener( GestureEvent.GESTURE_CHANGED ) ) _press.removeEventListener( GestureEvent.GESTURE_CHANGED, onTouchZoneChanged );
				if( _press.hasEventListener( GestureEvent.GESTURE_ENDED ) ) _press.removeEventListener( GestureEvent.GESTURE_ENDED, onTouchZoneEnd );
				
				_press = null;
				_activated = false;
				
			}
		}
		
		protected function onTouchZoneBegan( e:GestureEvent ):void
		{
			TweenMax.killTweensOf( _background );
			TweenMax.killTweensOf( _textField );
			TweenMax.to( _background, 0.1, {colorTransform:{tint:_color2, tintAmount:1}} );
			TweenMax.to( _textField, 0.1, {colorTransform:{tint:_color1, tintAmount:1}} );
		}
		
		protected function onTouchZoneChanged( e:GestureEvent ):void
		{
			var t:InteractiveObject = e.target.target as InteractiveObject;
			if( ( t ).hitTestPoint( stage.mouseX, stage.mouseY ) )
			{
				TweenMax.killTweensOf( _background );
				TweenMax.killTweensOf( _textField );
				TweenMax.to( _background, 0.1, {colorTransform:{tint:_color2, tintAmount:1}} );
				TweenMax.to( _textField, 0.1, {colorTransform:{tint:_color1, tintAmount:1}} );
			}
			else
			{
				TweenMax.killTweensOf( _background );
				TweenMax.killTweensOf( _textField );
				TweenMax.to( _background, 0.1, {colorTransform:{tint:_color1, tintAmount:1}} );
				TweenMax.to( _textField, 0.1, {colorTransform:{tint:_color2, tintAmount:1}} );
			}
		}
		
		protected function onTouchZoneEnd( e:GestureEvent ):void
		{
			TweenMax.killTweensOf( _background );
			TweenMax.killTweensOf( _textField );
			TweenMax.to( _background, 0.1, {colorTransform:{tint:_color1, tintAmount:1}} );
			TweenMax.to( _textField, 0.1, {colorTransform:{tint:_color2, tintAmount:1}} );
			
			var t:InteractiveObject = e.target.target as InteractiveObject;
			if( ( t ).hitTestPoint( stage.mouseX, stage.mouseY ) ) dispatchEvent( new Event( TextButton.BUTTON_TRIGGERED, true, false ) );
		}
		
		public function set text( pText:String ):void
		{
			_textField.text = pText;
		}
		
		public function get text():String
		{
			return _textField.text;
		}
		
		public override function set width(value:Number):void
		{
			_width = value;
			_background.width = _width;
			_textField.width = _width;
            _touchZone.width = _width;
		}
		
		public override function set height(value:Number):void
		{
			_height = value;
			_background.height = _height;
			_textField.height = _height;
            _touchZone.height = _height;
		}
		
	}
	
}



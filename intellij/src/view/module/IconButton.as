package view.module
{
	
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.InteractiveObject;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.gestouch.events.GestureEvent;
	import org.gestouch.gestures.LongPressGesture;
	
	public class IconButton extends Sprite
	{
		
		protected var _activated:Boolean = false;
		public function get  activated():Boolean{return _activated};
		
		protected var _width:uint;
		protected var _height:uint;
		protected var _icon:Bitmap;
		protected var _iconScale:Number;
		protected var _backgroundUpColor:uint;
		protected var _backgroundDownColor:uint;
		protected var _iconUpColor:uint;
		protected var _iconDownColor:uint;
		protected var _backgroundDeactivatedColor:uint;
		protected var _iconDeactivatedColor:uint;
		protected var _triggerEventName:String;
		
		
		protected var _background:Sprite;
		protected var _touchZone:Sprite;
		protected var _press:LongPressGesture;
		protected var _blinkTimeline:TimelineMax;
		
		protected var _blinking:Boolean;
		protected var _blinkDelay:uint;
		public function get blinking():Boolean{return _blinking;}
		
		public function IconButton( pWidth:uint, 
									pHeight:uint, 
									pIconClass:Class,
									pIconScale:Number = 1,
									pBackgroundUpColor:uint = 0x333333, 
									pBackgroundDownColor:uint = 0xFF0000,
									pIconUpColor:uint = 0x000000,
									pIconDownColor:uint = 0x333333,
									pBackgroundDeactivatedColor:uint = 0x333333,
									pIconDeactivatedColor:uint = 0x555555,
									pTriggerEventName:String = "BUTTON_TRIGGER"
									)
		{
			super();
			
			_width = pWidth;
			_height = pHeight;
			_iconScale = pIconScale;
			_backgroundUpColor = pBackgroundUpColor;
			_backgroundDownColor = pBackgroundDownColor;
			_iconUpColor = pIconUpColor;
			_iconDownColor = pIconDownColor;
			_backgroundDeactivatedColor = pBackgroundDeactivatedColor;
			_iconDeactivatedColor = pIconDeactivatedColor;
			_triggerEventName = pTriggerEventName;
			
			// Backgound
			_background = new Sprite();
			_background.graphics.beginFill( 0xFFFFFF, 1 );
			_background.graphics.drawRect( 0, 0, _width, _height );
			_background.graphics.endFill();
			
			TweenMax.to( _background, 0, {colorTransform:{tint:_backgroundUpColor, tintAmount:1}} );
			
			addChild( _background );
			
			// ICON
			icon = new pIconClass();
			TweenMax.to( _icon, 0, {colorTransform:{tint:_iconUpColor, tintAmount:1}} );
			
			// TouchZone
			_touchZone = new Sprite();
			_touchZone.alpha = 0;
			_touchZone.graphics.beginFill( 0XFF0000, 1 );
			_touchZone.graphics.drawRect( 0, 0, _width, _height );
			_touchZone.graphics.endFill();
			
			addChild( _touchZone );
			
			resize();
			activate();
			
		}
		
		public function set icon( pIconBD:BitmapData ):void
		{
			if( _icon != null )
			{
				removeChild( _icon );
				_icon = null;
			}
			
			_icon = new Bitmap( pIconBD, PixelSnapping.ALWAYS, true );
			addChild( _icon );
			if( _background != null && _touchZone != null ) resize(); // if _background or _touchZone is null, this means that it's the instance hasn't been constructed yet
		}
		
		public override function set width(value:Number):void
		{
			_width = value;
			resize();
		}
		
		public override function set height(value:Number):void
		{
			_height = value;
			resize();
		}
		
		protected function resize():void
		{
			var buttonRatio:Number = _width / _height;
			var iconRatio:Number = _icon.width / _icon.height;
			
			// BACKGROUND
			if( _background != null )
			{
				_background.width = _width;
				_background.height = _height;
			}
			
			// ICON
			if( _icon != null )
			{
				if( iconRatio <= buttonRatio ) // icon is taller than button
				{
					_icon.height = _height * _iconScale;
					_icon.width = _height * iconRatio * _iconScale;
					_icon.x = ( _width - _icon.width ) / 2;
					_icon.y = ( _height - _icon.height ) / 2;
				}
				else // icon is wider than button
				{
					_icon.width = _width * _iconScale;
					_icon.height = _width * iconRatio * _iconScale;
					_icon.x = ( _width - _icon.width ) / 2;
					_icon.y = ( _height - _icon.height ) / 2;
				}
			}
			
			// TOUCHZONE
			if( _touchZone != null )
			{
				_touchZone.width = _width;
				_touchZone.height = _height;
			}
			
		}
		
		public function activate():void
		{ 
			
			if( !_activated )
			{
				
				trace( this + " activate() " + name );
				
				_press = new LongPressGesture( _touchZone );
				_press.numTouchesRequired = 1;
				_press.minPressDuration = 0;
				
				if( !_press.hasEventListener( GestureEvent.GESTURE_BEGAN ) ) 	_press.addEventListener( GestureEvent.GESTURE_BEGAN, onTouchZoneBegan );
				if( !_press.hasEventListener( GestureEvent.GESTURE_CHANGED ) ) 	_press.addEventListener( GestureEvent.GESTURE_CHANGED, onTouchZoneChanged );
				if( !_press.hasEventListener( GestureEvent.GESTURE_ENDED ) ) 	_press.addEventListener( GestureEvent.GESTURE_ENDED, onTouchZoneEnd );
				
				TweenMax.to( _icon, 0.4, {colorTransform:{tint:_iconUpColor, tintAmount:1}} );
				TweenMax.to( _background, 0.4, {colorTransform:{tint:_backgroundUpColor, tintAmount:1}} );
				
				_activated = true;
				
			}
		}
		
		public function deactivate( pDimButton:Boolean = false ):void
		{
			
			if( _activated )
			{
				trace( this + " deactivate() " + name );
				
				if( _press.hasEventListener( GestureEvent.GESTURE_BEGAN ) ) 	_press.removeEventListener( GestureEvent.GESTURE_BEGAN, onTouchZoneBegan );
				if( _press.hasEventListener( GestureEvent.GESTURE_CHANGED ) ) 	_press.removeEventListener( GestureEvent.GESTURE_CHANGED, onTouchZoneChanged );
				if( _press.hasEventListener( GestureEvent.GESTURE_ENDED ) ) 	_press.removeEventListener( GestureEvent.GESTURE_ENDED, onTouchZoneEnd );
				
				_press = null;
				
				if( pDimButton )
				{
					TweenMax.to( _icon, 0.4, {colorTransform:{tint:_iconDeactivatedColor, tintAmount:1}} );
					TweenMax.to( _background, 0.4, {colorTransform:{tint:_backgroundDeactivatedColor, tintAmount:1}} );
				}
				
				_activated = false;
				
			}
		}
		
		public function blink( pLoops:int = -1, pDelay = 0 ):void
		{
			
			_blinkDelay = pDelay;
			
			if( _blinkTimeline == null )
			{
				_blinkTimeline = new TimelineMax({repeat:pLoops, onComplete:onBlinkComplete, delay:pDelay});
				_blinkTimeline.append( new TweenMax( _icon, 0.6, {colorTransform:{tint:_backgroundDownColor, tintAmount:1}} ) );
				_blinkTimeline.append( new TweenMax( _icon, 0.2, {colorTransform:{tint:_iconUpColor, tintAmount:1}} ) );
			}
			else
			{
				_blinkTimeline.restart( _blinkDelay );
			}
			
			_blinking = true;
			
		}
		
		protected function onBlinkComplete():void
		{
			TweenMax.to( _icon, 0.4, {colorTransform:{tint:_backgroundDownColor, tintAmount:1}} );
			_blinking = false;
		}
		
		public function unblink( preserveBlinkColor:Boolean = false ):void
		{
			if(_blinkTimeline != null) _blinkTimeline.stop();
			if( preserveBlinkColor )
			{
				TweenMax.to( _icon, 0.4, {colorTransform:{tint:_backgroundDownColor, tintAmount:1}} );
			}
			else
			{
				TweenMax.to( _icon, 0.4, {colorTransform:{tint:_iconUpColor, tintAmount:1}} );
			}
			
			_blinking = false;
			
		}
		
		protected function onTouchZoneBegan( e:GestureEvent ):void
		{
			TweenMax.killTweensOf( _background );
			TweenMax.killTweensOf( _icon );
			TweenMax.to( _background, 0.1, {colorTransform:{tint:_backgroundDownColor, tintAmount:1}} );
			TweenMax.to( _icon, 0.1, {colorTransform:{tint:_iconDownColor, tintAmount:1}} );
		}
		
		protected function onTouchZoneChanged( e:GestureEvent ):void
		{
			var t:InteractiveObject = e.target.target as InteractiveObject;
			if( ( t ).hitTestPoint( stage.mouseX, stage.mouseY ) )
			{
				TweenMax.killTweensOf( _background );
				TweenMax.killTweensOf( _icon );
				TweenMax.to( _background, 0.1, {colorTransform:{tint:_backgroundDownColor, tintAmount:1}} );
				TweenMax.to( _icon, 0.1, {colorTransform:{tint:_iconDownColor, tintAmount:1}} );
			}
			else
			{
				TweenMax.killTweensOf( _background );
				TweenMax.killTweensOf( _icon );
				TweenMax.to( _background, 0.1, {colorTransform:{tint:_backgroundUpColor, tintAmount:1}} );
				TweenMax.to( _icon, 0.1, {colorTransform:{tint:_iconUpColor, tintAmount:1}} );
			}
		}
		
		protected function onTouchZoneEnd( e:GestureEvent ):void
		{
			TweenMax.killTweensOf( _background );
			TweenMax.killTweensOf( _icon );
			TweenMax.to( _background, 0.1, {colorTransform:{tint:_backgroundUpColor, tintAmount:1}} );
			TweenMax.to( _icon, 0.1, {colorTransform:{tint:_iconUpColor, tintAmount:1}} );
			
			var t:InteractiveObject = e.target.target as InteractiveObject;
			if( ( t ).hitTestPoint( stage.mouseX, stage.mouseY ) ) 
			{
				dispatchEvent( new Event( _triggerEventName, true, false ) );
				unblink();
			}
		}
		
	}
	
}




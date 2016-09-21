package view.module
{
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import model.StaticValues;
	
	import utils.DeviceInfoManager;
	
	[Event( name="removed", type="flash.events.Event" )]
	
	public class SplashScreenBox extends Sprite
	{
		
		[Embed(source="/Default.png")]
		protected var DefaultClassicIMG:Class;
		
		[Embed(source="/Default@2x.png")]
		protected var DefaultRetina4iIMG:Class;
		
		[Embed(source="/Default-568h@2x.png")]
		protected var DefaultRetina5iIMG:Class;
		
		[Embed(source="/Default-Android.png")]
		protected var DefaultAndroidIMG:Class;
		
		protected var _width:uint;
		protected var _height:uint;
		protected var _autoRemove:Boolean;
		protected var _displayTime:uint;
		protected var _background:Shape;
		protected var _imgBitmap:Bitmap;
		protected var _t1:Timer;
		
		/**
		 * Displays an image on the screen while app is initializing
		 */
		public function SplashScreenBox( pWidth:uint, pHeight:uint, pAutoRemove:Boolean = false, SecondsBeforeAutoRemove:uint = 3 )
		{
			
			_width = pWidth;
			_height = pHeight;
			_autoRemove = pAutoRemove;
			_displayTime = SecondsBeforeAutoRemove;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			
			_background = new Shape();
			_background.graphics.clear();
			_background.graphics.beginFill( 0x333333, 1 );
			_background.graphics.drawRect( 0, 0, _width, _height );
			_background.graphics.endFill();
			
			addChild( _background );
			
			if( DeviceInfoManager.getInstance().osType == DeviceInfoManager.IOS )
			{
				
				if( DeviceInfoManager.getInstance().deviceModel == DeviceInfoManager.IPHONE_2G ||
                        DeviceInfoManager.getInstance().deviceModel == DeviceInfoManager.IPHONE_3G ||
                        DeviceInfoManager.getInstance().deviceModel == DeviceInfoManager.IPHONE_3GS )
				{
					_imgBitmap = new DefaultClassicIMG();
				}
				else if( DeviceInfoManager.getInstance().deviceModel == DeviceInfoManager.IPHONE_4 ||
                        DeviceInfoManager.getInstance().deviceModel == DeviceInfoManager.IPHONE_4S )
				{
					_imgBitmap = new DefaultRetina4iIMG();
				}
				else if(DeviceInfoManager.getInstance().deviceModel == DeviceInfoManager.IPHONE_5 ||
                        DeviceInfoManager.getInstance().deviceModel == DeviceInfoManager.IPHONE_5C ||
                        DeviceInfoManager.getInstance().deviceModel == DeviceInfoManager.IPHONE_5S ||
                        DeviceInfoManager.getInstance().deviceModel == DeviceInfoManager.IPHONE_6 ||
                        DeviceInfoManager.getInstance().deviceModel == DeviceInfoManager.IPHONE_6PLUS)
				{
					_imgBitmap = new DefaultRetina5iIMG();
				}
			}
			else // --> Android or ADL
			{
				_imgBitmap = new DefaultAndroidIMG();
			}
			
			_imgBitmap.smoothing = true;
			
			var screenRatio:Number = _width / _height;
			var imgRatio:Number = _imgBitmap.width / _imgBitmap.height;
			
			/*if( imgRatio <= screenRatio ) // image is taller than screen
			{
				_imgBitmap.height = _height;
				_imgBitmap.width = _height * imgRatio;
				_imgBitmap.x = ( _width - _imgBitmap.width ) / 2;
				
			}
			else // image is wider than screen
			{
				_imgBitmap.width = _width;
				_imgBitmap.height = _width / imgRatio;
				_imgBitmap.y = ( _height - _imgBitmap.height ) / 2;
			}*/

            if( imgRatio <= screenRatio ) // image is taller than screen
            {
                _imgBitmap.width = _width;
                _imgBitmap.height = _width / imgRatio;
                _imgBitmap.y = ( _height - _imgBitmap.height ) / 2;

            }
            else // image is wider than screen
            {
                _imgBitmap.height = _height;
                _imgBitmap.width = _height * imgRatio;
                _imgBitmap.x = ( _width - _imgBitmap.width ) / 2;
            }
			
			addChild( _imgBitmap );
			
		}
		
		protected function onAddedToStage( e:Event ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			if( _autoRemove )
			{
				_t1 = new Timer( _displayTime * 1000, 1 );
				_t1.addEventListener( TimerEvent.TIMER_COMPLETE, remove );
				_t1.start();
			}
		}
		
		/**
		 * removes the image
		 */
		public function remove( e:TimerEvent = null ):void
		{
			if( _t1 != null ) _t1.reset(), _t1 = null;
			if( _imgBitmap != null && contains( _imgBitmap ) ) removeChild( _imgBitmap ), _imgBitmap = null;
			if( parent != null ) parent.removeChild( this );
		}
	}
}
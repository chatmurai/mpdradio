package utils
{
    import flash.display.Stage;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.system.Capabilities;
    import flash.utils.setTimeout;

    public class DeviceInfoManager extends EventDispatcher
    {
        // Core private elements
        private static var _instance:DeviceInfoManager;
        private static var _stage:Stage;

        // accessible vars
        private var _stagePixelsWidth:uint;
        private var _stagePixelsHeight:uint;
        private var _screenPixelsWidth:uint;
        private var _screenPixelsHeight:uint;
        private var _screenResolutionX:uint;
        private var _screenResolutionY:uint;
        private var _screenDPI:Number;
        private var _osType:String;
        private var _iOSVersion:int;
        private var _iOSMajorVersion:int;
        private var _deviceModel:String;
        private var _ios7TopBarHeight:uint;

        // OS types constants
        public static const IOS:String 			= "IOS";
        public static const ANDROID:String 		= "AND";
        public static const ADL:String 			= "ADL";
        public static const STAGE_READY:String 	= "stageReady";

        // iPhone types constants
        public static const IPHONE_2G:String 	= "iPhone2G";
        public static const IPHONE_3G:String 	= "iPhone3G";
        public static const IPHONE_3GS:String 	= "iPhone3GS";
        public static const IPHONE_4:String 	= "iPhone4";
        public static const IPHONE_4S:String 	= "iPhone4S";
        public static const IPHONE_5:String 	= "iPhone5";
        public static const IPHONE_5C:String 	= "iPhone5C";
        public static const IPHONE_5S:String 	= "iPhone5S";
        public static const IPHONE_6:String 	= "iPhone6";
        public static const IPHONE_6PLUS:String = "iPhone6Plus";
        public static const IPHONE_6S:String    = "iPhone6S";
        public static const IPHONE_6SPLUS:String = "iPhone6SPlus";

        // iPad types constants
        public static const IPAD_1:String 		= "iPad1";
        public static const IPAD_2:String 		= "iPad2";
        public static const IPAD_3:String 		= "iPad3";
        public static const IPAD_4:String 		= "iPad4";
        public static const IPAD_AIR:String 	= "iPadAir";
        public static const IPAD_AIR2:String 	= "iPadAir2";
        public static const IPAD_PRO:String 	= "iPadPro";

        // iPad Mini types constants
        public static const IPAD_MINI_1:String 	= "iPadMini1";
        public static const IPAD_MINI_2:String 	= "iPadMini2";
        public static const IPAD_MINI_3:String 	= "iPadMini3";

        // others Apple devices constants
        public static const UNKNOWN_APPLE_DEVICE:String = "unknownAppleDevice";

        // All Android devices constant
        public static const ANDROID_DEVICE:String = "androidDevice";

        // All other devices constant
        public static const OTHER_DEVICE:String = "otherDevice";

        /**
         * @param caller : Function - Dummy parameter for Singleton instanciation purpose
         */
        public function DeviceInfoManager( caller:Function = null )
        {
            if ( caller != preventCreation )
            {
                throw new Error( "Creation of Singleton without calling sharedInstance is not valid" );
            }
        }

        private static function preventCreation():void
        {
        }

        public static function getInstance( pStage:Stage = null ):DeviceInfoManager
        {
            if ( _instance == null )
            {
                if( pStage != null )
                {
                    _instance = new DeviceInfoManager( preventCreation );
                    _instance.init( pStage );
                }
                else
                {
                    throw new Error( "On first instanciation, parameter stage can't be null." );
                }
            }

            return _instance;
        }

        /**
         * Triggererd only once, on the first instanciation
         */
        private function init( pStage:Stage ):void
        {

            if( pStage == null )
            {
                throw new Error( "pStage parameter must be specified." );
                return;
            }

            _stage = pStage;

            var os:String = Capabilities.version.substr( 0, 3 );

            //DEFINE::MONSTER_DEBUGGER { MonsterDebugger.trace( this, "initialize() / Capabilities.os : " + Capabilities.os + " - Capabilities.version : " + Capabilities.version, "vincent", "l1", 0x000000 ); }

            // ###################################################################################### HACK FOR ADL & iOS STAGE BAD DIMENSIONS
            if ( Capabilities.os.indexOf("Mac") != -1 || Capabilities.os.indexOf("Windows") != -1 )
            {
                // ADL emulator
                setTimeout( function():void{onInitComplete(DeviceInfoManager.ADL)}, 500 );
            }
            else
            {
                if( Capabilities.version.indexOf("IOS") != -1 )
                {
                    // iOS
                    setTimeout( function():void{onInitComplete(DeviceInfoManager.IOS)}, 1500 );
                }
                else if( Capabilities.version.indexOf("AND") != -1 )
                {
                    // Android
                    setTimeout( function():void{onInitComplete(DeviceInfoManager.ANDROID)}, 500 );
                }
                else
                {
                    // If device detection is not possible, we set the device to Android
                    setTimeout( function():void{onInitComplete(DeviceInfoManager.ANDROID)}, 500 );
                }
            }

        }

        /**
         * Triggered when init is complete
         */
        private function onInitComplete( pOs:String = null ):void
        {
            trace( this + " onInitComplete()" );

            // Width & height
            _instance._stagePixelsWidth =  _stage.stageWidth;
            _instance._stagePixelsHeight = _stage.stageHeight;

            _instance._screenPixelsWidth = _stage.fullScreenWidth;
            _instance._screenPixelsHeight = _stage.fullScreenHeight;

            _instance._screenResolutionX = Capabilities.screenResolutionX;
            _instance._screenResolutionY = Capabilities.screenResolutionY;

            // Screen DPI
            var serverString:String = unescape(Capabilities.serverString);
            var reportedDpi:Number = Number(serverString.split("&DP=", 2)[1]);
            _instance._screenDPI = reportedDpi;

            // OS
            _instance._osType = pOs;

            // iOS 7+ top bar
            _instance._ios7TopBarHeight = _instance.osType == DeviceInfoManager.IOS && _instance.iOSMajorVersion >= 7 ? 40 : 0;

            // ##############################################################################################
            // ####################################################################### APPLE MODELS DETECTION
            // ##############################################################################################
            if(pOs == DeviceInfoManager.IOS)
            {
                var os:String = Capabilities.os.toLowerCase();
                var model:String = Capabilities.os.split(" ")[3];

                _instance._iOSVersion = parseFloat( Capabilities.os.split(" ")[2] );
                _instance._iOSMajorVersion = uint( String( Capabilities.os.split(" ")[2]).substr( 0, 1 ) );

                // ####################################################################### iPhone
                // iPhone 2G
                if( model == "iPhone1,1" )
                {
                    _instance._deviceModel = DeviceInfoManager.IPHONE_2G;
                }
                // iPhone 3G
                else if( model == "iPhone1,2" )
                {
                    _instance._deviceModel = DeviceInfoManager.IPHONE_3G;
                }
                // iPhone 3GS
                else if( model == "iPhone2,1" )
                {
                    _instance._deviceModel = DeviceInfoManager.IPHONE_3GS;
                }
                // iPhone 4
                else if( model == "iPhone3,1" || model == "iPhone3,2" || model == "iPhone3,3" )
                {
                    _instance._deviceModel = DeviceInfoManager.IPHONE_4;
                }
                // iPhone 4S
                else if( model == "iPhone4,1" )
                {
                    _instance._deviceModel = DeviceInfoManager.IPHONE_4S;
                }
                // iPhone 5
                else if( model == "iPhone5,1" || model == "iPhone5,2" )
                {
                    _instance._deviceModel = DeviceInfoManager.IPHONE_5;
                }
                // iPhone 5C
                else if( model == "iPhone5,3" || model == "iPhone5,4" )
                {
                    _instance._deviceModel = DeviceInfoManager.IPHONE_5C;
                }
                // iPhone 5S
                else if( model == "iPhone6,1" || model == "iPhone6,2" )
                {
                    _instance._deviceModel = DeviceInfoManager.IPHONE_5S;
                }
                // iPhone 6
                else if( model == "iPhone7,2" )
                {
                    _instance._deviceModel = DeviceInfoManager.IPHONE_6;
                }
                // iPhone 6Plus
                else if( model == "iPhone7,1" )
                {
                    _instance._deviceModel = DeviceInfoManager.IPHONE_6PLUS;
                }
                // iPhone 6s
                else if( model == "iPhone8,1" )
                {
                    _instance._deviceModel = DeviceInfoManager.IPHONE_6S;
                }
                // iPhone 6sPlus
                else if( model == "iPhone8,2" )
                {
                    _instance._deviceModel = DeviceInfoManager.IPHONE_6SPLUS;
                }
                // ####################################################################### iPad
                // iPad 1
                else if( model == "iPad1,1" )
                {
                    _instance._deviceModel = DeviceInfoManager.IPAD_1;
                }
                // iPad2
                else if( model == "iPad2,1" || model == "iPad2,2" || model == "iPad2,3" || model == "iPad2,4" )
                {
                    _instance._deviceModel = DeviceInfoManager.IPAD_2;
                }
                // iPad3
                else if( model == "iPad3,1" || model == "iPad3,2" || model == "iPad3,3" )
                {
                    _instance._deviceModel = DeviceInfoManager.IPAD_3;
                }
                // iPad4
                else if( model == "iPad3,4" || model == "iPad3,5" || model == "iPad3,6" )
                {
                    _instance._deviceModel = DeviceInfoManager.IPAD_4;
                }
                // iPadAir
                else if( model == "iPad4,1" || model == "iPad4,2" || model == "iPad4,3" )
                {
                    _instance._deviceModel = DeviceInfoManager.IPAD_AIR;
                }
                // iPadAir 2
                else if( model == "iPad5,3" || model == "iPad5,4" )
                {
                    _instance._deviceModel = DeviceInfoManager.IPAD_AIR2;
                }
                // iPad Pro
                else if( model == "iPad6,7" || model == "iPad6,8" )
                {
                    _instance._deviceModel = DeviceInfoManager.IPAD_PRO;
                }

                // ####################################################################### iPad mini
                // iPad Mini 1
                else if( model == "iPad2,5" || model == "iPad2,6" || model == "iPad2,7" )
                {
                    _instance._deviceModel = DeviceInfoManager.IPAD_MINI_1;
                }
                // iPad Mini 2
                else if( model == "iPad4,4" || model == "iPad4,5" || model == "iPad4,6" )
                {
                    _instance._deviceModel = DeviceInfoManager.IPAD_MINI_2;
                }
                // iPad Mini 3
                else if( model == "iPad4,7" || model == "iPad4,8" || model == "iPad4,9" )
                {
                    _instance._deviceModel = DeviceInfoManager.IPAD_MINI_3;
                }

                // Model detection fails
                else
                {
                    _instance._deviceModel = DeviceInfoManager.UNKNOWN_APPLE_DEVICE;
                }

                // ##############################################################################################
                // ###################################################################################### ANDROID
                // ##############################################################################################
            }
            else if(pOs == DeviceInfoManager.ANDROID)
            {
                _instance._deviceModel = DeviceInfoManager.ANDROID_DEVICE;
                _instance._iOSVersion = -1;
                _instance._iOSMajorVersion = -1;
            }
            // ##############################################################################################
            // ################################################################## ADL OR DETECTION IMPOSSIBLE
            // ##############################################################################################
            else
            {
                _instance._deviceModel = DeviceInfoManager.OTHER_DEVICE;
                _instance._iOSVersion = -1;
                _instance._iOSMajorVersion = -1;
            }

            dispatchEvent( new Event( DeviceInfoManager.STAGE_READY, true, false ));

        }

        // ########################################################## GETTERS
        public function get stagePixelsWidth():uint
        {
            return _stagePixelsWidth;
        }

        public function get stagePixelsHeight():uint
        {
            return _stagePixelsHeight;
        }

        public function get screenPixelsWidth():uint
        {
            return _screenPixelsWidth;
        }

        public function get screenPixelsHeight():uint
        {
            return _screenPixelsHeight;
        }

        public function get screenResolutionX():uint
        {
            return _screenResolutionX;
        }

        public function get screenResolutionY():uint
        {
            return _screenResolutionY;
        }

        public function get screenDPI():Number
        {
            return _screenDPI;
        }

        public function get osType():String
        {
            return _osType;
        }

        public function get iOSVersion():int
        {
            return _iOSVersion;
        }

        public function get iOSMajorVersion():int
        {
            return _iOSMajorVersion;
        }

        public function get deviceModel():String
        {
            return _deviceModel;
        }

        public function get ios7TopBarHeight():uint
        {
            return _ios7TopBarHeight;
        }

    }
}
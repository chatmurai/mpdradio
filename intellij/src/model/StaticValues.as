package model
{
    import flash.desktop.NativeApplication;
    import flash.filesystem.File;

    public class StaticValues
	{

		////////////////////////////////////////////////////////////////////////////////////////////////// REMOTE PATHS
		//public static const MPD_HOST_NAME:String = "192.168.0.15";
		public static const MPD_HOST_NAME:String = "radialva.local";
        public static const MPD_HOST_PORT:uint = 6600;
	    public static const ESP8266_URI:String = "ws://192.168.4.1:81";

	    ///////////////////////////////////////////////////////////////////////////////////////////////// GOOGLE ANALYTICS
	    public static const GOOGLE_ANALYTICS_UA:String = "UA-45019580-12";

	    ///////////////////////////////////////////////////////////////////////////////////////////////// PALETTE
	    public static const CLR_LIGHT_MOSS_GREEN:uint = 0xB8D8BA;
	    public static const CLR_BONE:uint = 0xD9DBBC;
	    public static const CLR_VERY_PALE_ORANGE:uint = 0xFCDDBC;
	    public static const CLR_MAUVELOUS:uint = 0xEF959D;
	    public static const CLR_WENGE:uint = 0x69585F;
	    public static const CLR_DIRTY_WHITE:uint = 0xFAFAF4;

	    ///////////////////////////////////////////////////////////////////////////////////////////////// CRYPTO
	    public static const ENCRYPTION_KEY:String = "ChAZ&G#+L$W9bE3u";
	    public static const ENCRYPTION_IV:String = "6@ctFA$mrX&U=Te!";

	    public static const DATA_DELIMITER:String = "~~~~";

		public function StaticValues()
		{
		}
	}
}
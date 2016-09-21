package utils
{
	import flash.desktop.NativeApplication;

	public class AppInfoManager
	{
		public function AppInfoManager()
		{
		}
		
		
		/**
		 * Return the version of the application in the XML descriptor file
		 */
		public static function get appVersion():String 
		{
			var appXml:XML = NativeApplication.nativeApplication.applicationDescriptor;
			var ns:Namespace = appXml.namespace();
			var appVersion:String = appXml.ns::versionNumber[0];
			return appVersion;
		}
		
		/**
		 * Return the id of the application in the XML descriptor file
		 */
		public static function get appID():String 
		{
			var appXml:XML = NativeApplication.nativeApplication.applicationDescriptor;
			var ns:Namespace = appXml.namespace();
			var appID:String = appXml.ns::id[0];
			return appID;
		}
		
		/**
		 * Return the name of the application in the XML descriptor file
		 */
		public static function get appName():String 
		{
			var appXml:XML = NativeApplication.nativeApplication.applicationDescriptor;
			var ns:Namespace = appXml.namespace();
			var appName:String = appXml.ns::name[0];
			return appName;
		}
		
	}
}
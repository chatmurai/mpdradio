package utils
{
	
	public class AnalyticsManager
	{

		private static var _instance:AnalyticsManager;

		public function AnalyticsManager( caller:Function = null )
		{
			if ( caller != preventCreation ) 
			{
				throw new Error( "Creation of Singleton without calling sharedInstance is not valid" );
			}
		}
		
		private static function preventCreation():void 
		{
		}
		
		public static function getInstance():AnalyticsManager 
		{
			if ( _instance == null ) 
			{
				_instance = new AnalyticsManager( preventCreation );
				_instance.init();
			}
			
			return _instance;
		}
		
		/**
		 * Triggererd only once, on the first instanciation
		 */
		private function init():void
		{
			
			
			
		}
		
	}
}


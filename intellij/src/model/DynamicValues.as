package model
{
	import com.milkmangames.nativeextensions.GAnalytics;

	public class DynamicValues
	{
		protected static var _instance:DynamicValues = null;


		protected var _ga:GAnalytics;

		public function DynamicValues(caller:Function = null)
		{
			if (caller != preventCreation)
			{
				throw new Error("Creation of Singleton without calling sharedInstance is not valid");
			}
		}

		private static function preventCreation():void
		{
		}

		public static function getInstance():DynamicValues
		{
			if (_instance == null)
			{
				_instance = new DynamicValues(preventCreation);
			}

			return _instance;
		}

		// ######################################################## GOOGLE ANALYTICS
		public function set ga(pGa:GAnalytics):void
		{
			_ga = pGa;
		}

		public function get ga():GAnalytics
		{
			return _ga;
		}
	}
}
package
{
	import com.milkmangames.nativeextensions.GAnalytics;

	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.UncaughtErrorEvent;
	import flash.utils.setTimeout;

	import model.DynamicValues;
	import model.StaticValues;

	import utils.AppInfoManager;

	import utils.DeviceInfoManager;

	import view.MainView;
	import view.module.SplashScreenBox;

	[SWF(frameRate="30", backgroundColor="#333333")]

	public class Main extends Sprite
	{

		private var _DIM:DeviceInfoManager;
		private var _splashScreenBox:SplashScreenBox;
		private var _manView:MainView;

		public function Main()
		{
			if( stage ) onStageResize();
			addEventListener( Event.RESIZE, onStageResize );
		}

		/**
		 * Triggered when stage resizes
		 */
		protected function onStageResize( e:Event = null ):void
		{
			trace( this + ' onStageResize()' );
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.NORMAL;
			NativeApplication.nativeApplication.executeInBackground = true;

			// HANDLE UNCAUGHT ERROR EVENTS
			loaderInfo.uncaughtErrorEvents.addEventListener( UncaughtErrorEvent.UNCAUGHT_ERROR, uncaughtErrorHandler );

			// DEVICE INFO MANAGER
			_DIM = DeviceInfoManager.getInstance(stage);
			_DIM.addEventListener( DeviceInfoManager.STAGE_READY, onStageReady );

		}

		/**
		 * Triggered when Stage is ready and has the good width / height values
		 */
		protected function onStageReady( e:Event ):void
		{
			removeEventListener( Event.RESIZE, onStageResize );
			_DIM.removeEventListener( DeviceInfoManager.STAGE_READY, onStageReady );

			trace( "Stage dimensions : " + _DIM.stagePixelsWidth, _DIM.stagePixelsHeight );


			CONFIG::PRODUCTION
			{

				if(GAnalytics.isSupported())
				{
					trace("********** GAnalytics init **********");
					DynamicValues.getInstance().ga = GAnalytics.create(StaticValues.GOOGLE_ANALYTICS_UA);
					DynamicValues.getInstance().ga.defaultTracker.trackScreenView("SplashScreen");
					DynamicValues.getInstance().ga.defaultTracker.trackEvent("System", "OsType", _DIM.osType);
					DynamicValues.getInstance().ga.defaultTracker.trackEvent("System", "AppVersion", AppInfoManager.appVersion );
				}
				else
				{
					trace("Google Anaytics only works on iOS or Android.");
				}

			}

			// we put those to listeners into a setTimeout to prevent onAppActivate to be triggered on first launch (this seems to happen only in ADL though...)
			setTimeout( function():void
					{
						stage.addEventListener( Event.ACTIVATE, onAppActivate );
						stage.addEventListener( Event.DEACTIVATE, onAppDeactivate );
						//NativeApplication.nativeApplication.addEventListener( flash.events.Event.EXITING, onAppExit );
					},
					1000
			);

			// LOADING IMAGE (Only for Android since iOS already has one)
			if( _DIM.osType == DeviceInfoManager.ANDROID || _DIM.osType == DeviceInfoManager.ADL )
			{
				_splashScreenBox = new SplashScreenBox( _DIM.stagePixelsWidth, _DIM.stagePixelsHeight, true, 2 );
				_splashScreenBox.addEventListener( Event.REMOVED_FROM_STAGE, onSplashScreenRemoved );

				addChild( _splashScreenBox );
			}
			else
			{
				onSplashScreenRemoved();
			}
		}

		/**
		 * Triggered when SplashScreenBox is removed or if iOS detected
		 * @param e Event
		 */
		protected function onSplashScreenRemoved( e:Event = null ):void
		{
			if(_manView === null)
			{
				_manView = new MainView();
				addChild(_manView);
			}
		}

		/**
		 * Triggered when app is activated
		 */
		protected function onAppActivate( e:Event ):void
		{
			trace( this + " onAppActivate()" );
			stage.frameRate = 30;
		}

		/**
		 * Triggered when app is deactivated
		 */
		protected function onAppDeactivate( e:Event ):void
		{
			trace( this + " onAppDeactivate()" );
			stage.frameRate = 1;
		}

		/**
		 * Triggered when app exits
		 */
		protected function onAppExit( e:Event ):void
		{
			e.preventDefault();
			NativeApplication.nativeApplication.exit();
		}

		/**
		 * Handles uncaught ErrorEvents
		 */
		protected function uncaughtErrorHandler( e:UncaughtErrorEvent ):void
		{
			// prevent the default behaviour
			e.preventDefault();
			e.stopPropagation();

			// get the error object as an error
			if( e.error is Error )
			{
				var error:Error = e.error as Error;
				// DEFINE::MONSTER_DEBUGGER { MonsterDebugger.trace( this, "/!\ UNCAUGHT ERROR : " + error.name + " - " + error.message + " - " + error.getStackTrace(), "vincent", "l1", 0xFF9900 ); }
			}
			else
			{
				// DEFINE::MONSTER_DEBUGGER { MonsterDebugger.trace( this, "/!\ UNCAUGHT ERROR CATCH FAILED : " + e, "vincent", "l1", 0xFF0000 ); }
			}

		}
	}
}

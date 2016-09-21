package view
{
	import com.electrofrog.events.PageNavigatorEvent;
	import com.electrofrog.layout.PageNavigator;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import model.DynamicValues;

	import model.StaticValues;

	import net.MpdSocket;
	import net.event.MpdSocketEvent;

	import utils.DeviceInfoManager;

	public class MainView extends Sprite
	{

		private var _topBarView:TopBarView;
		private var _homeView:HomeView;
		private var _settingsView:SettingsView;
		private var _pageNavigator:PageNavigator;
		private var _mpdSocket:MpdSocket;

		public function MainView()
		{


			super();

			//_mpdSocket = new MpdSocket(StaticValues.MPD_HOST_NAME, StaticValues.MPD_HOST_PORT);
			//_mpdSocket.addEventListener(MpdSocketEvent.SOCKET_DATA_RECEIVED, onMpdDataReceive);

			// TopBarView
			_topBarView = new TopBarView(0, 0, DeviceInfoManager.getInstance().stagePixelsWidth, int(DeviceInfoManager.getInstance().stagePixelsHeight * .1), 0, StaticValues.CLR_WENGE, 0 );
			_topBarView.addEventListener(TopBarView.SETTINGS_BUTTON_CLICK, function(e:Event):void{_settingsView.show();});

			// HomeView
			_homeView = new HomeView( 0, 0, DeviceInfoManager.getInstance().stagePixelsWidth, int(DeviceInfoManager.getInstance().stagePixelsHeight * .9), 0, StaticValues.CLR_LIGHT_MOSS_GREEN, 0 );

			// SettingsView
			_settingsView = new SettingsView( 0, 0, DeviceInfoManager.getInstance().stagePixelsWidth, DeviceInfoManager.getInstance().stagePixelsHeight, 0, StaticValues.CLR_MAUVELOUS, 0 );
			_settingsView.hide(true);

			// PageNavigator
			_pageNavigator = new PageNavigator( 0, _topBarView.height, DeviceInfoManager.getInstance().stagePixelsWidth, int(DeviceInfoManager.getInstance().stagePixelsHeight * .9), -1, -1, 0.6 );
			_pageNavigator.addPage(_homeView);
			_pageNavigator.addEventListener( PageNavigatorEvent.CURRENT_PAGE_CHANGED, onPageChange );

			addChild( _pageNavigator );
			addChild( _topBarView );
			addChild( _settingsView );

			addEventListener(flash.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}

		// ############################################################################# PAGENAVIGATOR MANAGEMENT
		protected function onPageChange(e:PageNavigatorEvent):void
		{
			trace( this + " onPageChange() pageId : " + e.currentPageID );
			switch(e.currentPageID)
			{
				case 0: // HomeView
				{
					CONFIG::PRODUCTION
					{
						if(DynamicValues.getInstance().ga !== null) DynamicValues.getInstance().ga.defaultTracker.trackScreenView("HomeScreen");
					}
					break;
				}

				case 1: // settingView
				{
					CONFIG::PRODUCTION
					{
						if (DynamicValues.getInstance().ga !== null) DynamicValues.getInstance().ga.defaultTracker.trackScreenView("StudioScreen");
					}
					break;
				}
			}
		}

		private function onAddedToStage(e:Event):void
		{
			// TEST
			stage.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent):void{

			});

			stage.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, function(e:MouseEvent):void{

			});
		}

		private function onMpdDataReceive(e:MpdSocketEvent):void
		{
			trace(this + "onMpdDataReceive() : " + e.mivo.volume, e.mivo.Name);
		}

	}
}
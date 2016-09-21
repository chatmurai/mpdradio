/**
 * Created by vincentmaitray on 14/09/16.
 */
package view
{
	import com.electrofrog.layout.AbstractPage;
	import com.electrofrog.utils.UIUtils;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	public class TopBarView extends AbstractPage
	{

		public static const SETTINGS_BUTTON_CLICK:String = "settingsButtonClick";

		private var _settingsButton:Sprite;

		public function TopBarView(pX:int, pY:int, pWidth:uint, pHeight:uint, pPageNumber:int=-1, pBackgroundColor:uint=0x333333FF, pGap:uint=0)
		{
			super(pX, pY, pWidth, pHeight, pPageNumber, pBackgroundColor, pGap);

			// SettingsButton
			_settingsButton = new GearIcon();
			UIUtils.resizeHomoteticallyInRectangle(_settingsButton, new Rectangle(0, 0, height, height), .6, true);
			_settingsButton.x = width - _settingsButton.width - (width * .04);
			_settingsButton.addEventListener( MouseEvent.CLICK, function(e:MouseEvent):void{dispatchEvent( new Event( TopBarView.SETTINGS_BUTTON_CLICK, true, false ));} );
			addChild(_settingsButton);
		}
	}
}
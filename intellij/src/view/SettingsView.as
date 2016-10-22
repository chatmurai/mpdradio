/**
 * Created by vincentmaitray on 14/09/16.
 */
package view
{
	import com.electrofrog.layout.AbstractPage;
	import com.greensock.TweenMax;
	import com.greensock.easing.Quad;

	import flash.events.MouseEvent;

	import model.StaticValues;

	import net.Esp8266SocketManager;

	import utils.DeviceInfoManager;

	public class SettingsView extends AbstractPage
	{

		private var _closeButton:CloseIcon;
		private var _esp8266SockMngr:Esp8266SocketManager;

		public function SettingsView(pX:int, pY:int, pWidth:uint, pHeight:uint, pPageNumber:int=-1, pBackgroundColor:uint=0x333333FF, pGap:uint=0)
		{
			super(pX, pY, pWidth, pHeight, pPageNumber, pBackgroundColor, pGap);

			// SettingsButton
			_closeButton = new CloseIcon();
			_closeButton.width = int(_closeButton.height = width * .06);
			_closeButton.x = int(width - _closeButton.width - (width * .03));
			_closeButton.y = int(width * .03);
			_closeButton.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void{hide()});
			addChild(_closeButton);

			// Esp8266SocketManager
			_esp8266SockMngr = new Esp8266SocketManager();
			_esp8266SockMngr.connect(StaticValues.ESP8266_URI);

			//var ssid:String = "le_caboulot_digital";
			var ssid:String = "moins_fort_le_violon";
			var psk:String = "ezeleezdegue";

			//var ssid:String = rot47("le_caboulot_digital")
			//var psk:String = rot47("ezeleezdegue");

			//var ssid = encryptToAES128("le_caboulot_digital", StaticValues.ENCRYPTION_KEY, StaticValues.ENCRYPTION_IV);
			//var psk = encryptToAES128("ezeleezdegue", StaticValues.ENCRYPTION_KEY, StaticValues.ENCRYPTION_IV);

			var data:String = '{"ssid":' + '"' + ssid + '",' + '"psk":' + '"' + psk + '"}';

			var encryptedData = encryptToRot47(data);

			var b1:BlueButton = new BlueButton();
			b1.x = 20;
			b1.y = 20;
			b1.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void{
				_esp8266SockMngr.sendData("g_wi-sc");
			});
			addChild(b1);

			var b2:BlueButton = new BlueButton();
			b2.x = 120;
			b2.y = 20;
			b2.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void{
				//var ur:URLRequest = new URLRequest("http://192.168.4.1/s_wi-cr?d=" + encryptedData);
				_esp8266SockMngr.sendData("s_wi-cr~~~~" + encryptedData + "~~~~");
			});
			addChild(b2);

			var b3:BlueButton = new BlueButton();
			b3.x = 20;
			b3.y = 120;
			b3.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void{
				_esp8266SockMngr.sendData("ping");
			});
			addChild(b3);

		}

		public function show(pImmediate:Boolean = false):void
		{
			if(pImmediate)
				y = 0;
			else
				TweenMax.to(this, .4, {y:0, ease:Quad.easeOut});
		}

		public function hide(pImmediate:Boolean = false):void
		{
			if(pImmediate)
				y = DeviceInfoManager.getInstance().stagePixelsHeight;
			else
				TweenMax.to(this, .4, {y:DeviceInfoManager.getInstance().stagePixelsHeight, ease:Quad.easeOut});
		}

		function rotn(text:String, map:String):String
		{
			// Generic ROT-n algorithm for keycodes in MAP.
			var R:String = "";
			var j:int;
			var c:String;
			var len:int = map.length;
			for(var i:int = 0; i < text.length; i++)
			{
				c = text.charAt(i);
				j = map.indexOf(c);
				if (j >= 0) {
					c = map.charAt((j + len / 2) % len);
				}
				R += c;
			}
			return R;
		}

		function encryptToRot47(text):String {
			// Hides all ASCII-characters from 33 ("!") to 126 ("~").  Hence can be used
			// to obfuscate virtually any text, including URLs and emails.
			var R:String;
			R = rotn(text, "!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~");
			return R;
		}

		//notice that decrKey and decrIV length must be 16 chars long! ex: 1234567890123456
		/*
		private function encryptToAES128(input:String, decrKey:String, decrIV:String):String
		{
			var inputBA:ByteArray = Hex.toArray(Hex.fromString(input));
			var key:ByteArray = Hex.toArray(Hex.fromString(decrKey));
			var pad:IPad = new NullPad();
			var aes:ICipher = Crypto.getCipher("simpleAES", key, pad);
			var ivmode:IVMode = aes as IVMode;
			ivmode.IV = Hex.toArray(Hex.fromString(decrIV));
			aes.encrypt(inputBA);

			return Base64.encodeByteArray(inputBA);  //if not use Base64 encode, data would be just byteArray
		}
		*/

	}
}
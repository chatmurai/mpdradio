/**
 * Created by vincentmaitray on 14/09/16.
 */
package view
{
	import com.electrofrog.layout.AbstractPage;
	import com.electrofrog.utils.encrypting.Base64;
	import com.greensock.TweenMax;
	import com.greensock.easing.Quad;
	import com.hurlant.crypto.Crypto;
	import com.hurlant.crypto.symmetric.ICipher;
	import com.hurlant.crypto.symmetric.IPad;
	import com.hurlant.crypto.symmetric.IVMode;
	import com.hurlant.crypto.symmetric.NullPad;
	import com.hurlant.util.Hex;

	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;

	import model.StaticValues;

	import utils.DeviceInfoManager;

	public class SettingsView extends AbstractPage
	{

		private var _closeButton:CloseIcon;

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

			var ssid:String = "le_caboulot_digital";
			var psk:String = "ezeleezdegue";

			//var ssid:String = rot47("le_caboulot_digital")
			//var psk:String = rot47("ezeleezdegue");

			//var ssid = encryptToAES128("le_caboulot_digital", StaticValues.ENCRYPTION_KEY, StaticValues.ENCRYPTION_IV);
			//var psk = encryptToAES128("ezeleezdegue", StaticValues.ENCRYPTION_KEY, StaticValues.ENCRYPTION_IV);

			var data:String = StaticValues.DATA_DELIMITER +
					'{"ssid":' + '"' + ssid + '",' +
					'"psk":' + '"' + psk + '"}' +
					StaticValues.DATA_DELIMITER;

			//var encryptedData = encryptToAES128(data, StaticValues.ENCRYPTION_KEY, StaticValues.ENCRYPTION_IV);
			var encryptedData = encryptToRot47(data);

			var ur:URLRequest = new URLRequest("http://192.168.4.1/" + encryptedData);
			ur.method = URLRequestMethod.GET;

			var ul:URLLoader = new URLLoader();
			ul.load(ur);

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

	}
}
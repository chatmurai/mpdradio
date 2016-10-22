package view.module
{

	import com.electrofrog.layout.AbstractPage;
	
	import flash.text.TextFieldType;
	import flash.text.TextFormatAlign;
	
	public class TextLabel extends AbstractPage
	{
		private var _backgroundColor:uint;
		private var _text:String;
		private var _textColor:uint;
		private var _font:String;
		private var _textField:EnhancedTextField;
		
		public function TextLabel(pX:int, pY:int, pWidth:uint, pHeight:uint, pBackgroundColor:uint=0x333333, pText:String = "---", pTextColor:uint = 0x000000, pFont:String = "Arial" )
		{
			super(pX, pY, pWidth, pHeight, -1, pBackgroundColor, 0);
			
			_backgroundColor = pBackgroundColor;
			_text = pText;
			_textColor = pTextColor;
			_font = pFont;
			
			// TEXTFIELD
			var fontSize:uint = Math.round( initHeight * .33 );
			_textField = new EnhancedTextField( TextFieldType.DYNAMIC, 
				initWidth, 
				initHeight / 2,
				"",
                pFont,
                fontSize,
				_textColor,
				_backgroundColor,
				0,
				TextFormatAlign.CENTER,
				true,
				true,
				false,
				0);
			
			_textField.text = _text;
			_textField.y = ( initHeight - _textField.height ) / 2;
			
			addChild( _background );
			addChild( _textField );
			
		}
		
		public function set text( pText:String ):void
		{
			_textField.text = pText;
		}
		
		public function get text():String
		{
			return _textField.text;
		}
		
		public override function set width(value:Number):void
		{
			width = value;
			_background.width = width;
			_textField.width = width;
		}
		
		public override function set height(value:Number):void
		{
			height = value;
			_background.height = height;
			_textField.height = height;
		}
	}
}
package model
{
    import flash.text.Font;

    public class FontCatalog
	{
		
		//################################################################################################## ARIAL
        [Embed(source="/assets/fonts/Arial/Arial.ttf",
                fontName = "Arial",
                mimeType = "application/x-font",
                fontWeight="normal",
                fontStyle="normal",
                advancedAntiAliasing="true",
                embedAsCFF="false")]
        public static const Arial:Class;
		public static const ARIAL:String = "Arial";

        [Embed(source="/assets/fonts/Arial/ArialBold.ttf",
                fontName = "ArialBold",
                mimeType = "application/x-font",
                fontWeight="normal",
                fontStyle="normal",
                advancedAntiAliasing="true",
                embedAsCFF="false")]
        public static const ArialBold:Class;
		public static const ARIAL_BOLD:String = "ArialBold";

        [Embed(source="/assets/fonts/Arial/ArialBlack.ttf",
                fontName = "ArialBlack",
                mimeType = "application/x-font",
                fontWeight="normal",
                fontStyle="normal",
                advancedAntiAliasing="true",
                embedAsCFF="false")]
        public static const ArialBlack:Class;
		public static const ARIAL_BLACK:String = "ArialBlack";

        [Embed(source="/assets/fonts/Arial/ArialItalic.ttf",
                fontName = "ArialItalic",
                mimeType = "application/x-font",
                fontWeight="normal",
                fontStyle="normal",
                advancedAntiAliasing="true",
                embedAsCFF="false")]
        public static const ArialItalic:Class;
		public static const ARIAL_ITALIC:String = "ArialItalic";
		
		
		
		public function FontCatalog()
		{

		}
	}
}
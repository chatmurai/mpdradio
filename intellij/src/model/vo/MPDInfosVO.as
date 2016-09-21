package model.vo
{

	public class MPDInfosVO
	{
		// STATUS
		public var volume:String;
		public var repeat:String;
		public var random:String;
		public var single:String;
		public var consume:String;
		public var playlist:String;
		public var playlistlength:String;
		public var mixrampdb:String;
		public var state:String;
		public var song:String;
		public var songid:String;
		public var time:String;
		public var elapsed:String;
		public var bitrate:String;
		public var audio:String;
		public var nextsong:String;
		public var nextsongid:String;

		// CURRENT SONG
		public var file:String;
		public var Name:String;
		public var Pos:String;
		public var Id:String;

		public function MPDInfosVO():void
		{

		}

		/**
		 * Return a string made from the 1st level of all object members
		 */
		public function rawString():String
		{
			return String(volume + repeat + random + single + consume + playlist + playlistlength + mixrampdb + state + song + songid + time + elapsed + bitrate + audio + nextsong + nextsongid + file + Name + Pos + Id);
		}
	}
}
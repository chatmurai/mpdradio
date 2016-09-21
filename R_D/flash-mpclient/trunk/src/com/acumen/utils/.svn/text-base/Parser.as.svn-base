package com.acumen.utils
{
	public class Parser
	{
		public static function csv(input:String,type:Class=null,pairDeliminator:String=',',lineDeliminator:String='\n',maxCols:int=0x7fffffff,maxRows:int=0x7fffffff):*
		{
			if(!type)type=Object;
			var d:Array=input.split(lineDeliminator,maxRows);
			var output:*=new type();
			var indexType:Class=(type is Array)?int:String;
			for each(var s:String in d)
			{
				var pair:Array=s.split(pairDeliminator,maxCols);
				//if(pair&&pair.length==2)output[indexType(pair[0])]=pair[1];
				if(pair.length>=2)output.push(pair);
			}
			return output;
			
		}
		
		public static function pairs(input:String,type:Class=null,pairDeliminator:*='^([^:]*): (.*)',lineDeliminator:*='\n',key:int=1,value:int=2):*
		{
			if(!type)type=Object;
			var d:Array=input.split(lineDeliminator);
			var output:*=new type();
			var indexType:Class=(type is Array)?int:String;
			for each(var s:String in d)
			{
				var pair:Array=s.match(pairDeliminator);
				if(pair&&pair.length==3)output[indexType(pair[key])]=pair[value];
				
			}
			return output;
		}
		
		public static function substitute(str:String,data:Object):String
		{
			var matches:Array=str.match(/%[a-zA-Z]+%/g);
			for each(var match:String in matches)
			{
				var sub:String=match.match(/[a-zA-Z]+/).pop();
				
				if(sub&&data[sub])str=str.replace(new RegExp(match+'(?:\{([^}]*)\})?'),data[sub]+'$1');
				else str=str.replace(new RegExp(match+'(\{[^}]*\})?'),'');
			}
			return str;
		}
				
	}
}
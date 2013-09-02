package decompiler.utils
{
	import flash.utils.ByteArray;

	public final class OpcodeCompiler
	{
		public static function compile(codeStr:String):ByteArray
		{
			var byte:ByteArray = new ByteArray;
			codeStr.replace(/\r\n/g, "");
			codeStr.replace(/ */g, " ");
			var codes:Array = codeStr.split(";");
			var length:int = codes.length;
			for (var i:int = 0; i < length; ++i) 
			{
				var statement:String = codes[i];
				var arr:Array = statement.split(" ");
//				byte.writeByte();
			}
			
			return byte;
		}
	}
}
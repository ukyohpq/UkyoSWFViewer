package decompiler.tags.doabc
{
	public class ABCMultiname
	{
		public var kind:int;
		public var data:Object = {};
		public function ABCMultiname()
		{
		}
		
		public function toString():String
		{
			var s:String = "{kind:" + kind + " data:[";
			for (var key:String in data) 
			{
				s += " " + key + ":" + data[key];
			}
			s += "]}";
			return s;
		}
	}
}
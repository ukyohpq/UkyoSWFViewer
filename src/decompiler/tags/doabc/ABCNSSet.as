package decompiler.tags.doabc
{
	public final class ABCNSSet
	{
		public var count:int = 0;
		public var ns:Vector.<uint> = new <uint>[];
		public function ABCNSSet()
		{
		}
		
		public function toString():String
		{
			return "count:" + count + " ns:" + ns;
		}
	}
}
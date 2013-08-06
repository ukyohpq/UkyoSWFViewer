package decompiler.tags
{
	public final class TagConfig
	{
		/**
		 * 16位tag头的低位部分的长度，根据长短tag标识来确定。目前是6位
		 * @return 
		 * 
		 */
		public static function get SHORT_TAG_LOW_LENGTH():int
		{
			var i:int = 0;
			var lowPart:int = SHORT_TAG_LOW_PART;
			while(lowPart)
			{
				lowPart >>= 1;
				++i;
			}
			return i;
		}
		
		/**
		 * 16位tag头的低位部分如果是0x3F则是长tag，否则是短tag
		 */
		public static const SHORT_TAG_LOW_PART:int = 0x3F;
	}
}
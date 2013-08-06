package decompiler.tags
{
	import flash.utils.ByteArray;
	
	public final class UnkownTag extends SWFTag
	{
		public function UnkownTag(id:int = 0, body:ByteArray=null)
		{
			super(id, body);
		}
	}
}
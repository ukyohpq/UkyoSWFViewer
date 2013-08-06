package decompiler.tags
{
	import flash.utils.ByteArray;
	
	public class GenCommandTag extends SWFTag
	{
		public function GenCommandTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
	}
}
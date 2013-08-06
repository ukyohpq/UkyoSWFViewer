package decompiler.tags
{
	import flash.utils.ByteArray;
	
	public class FontRefTag extends SWFTag
	{
		public function FontRefTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
	}
}
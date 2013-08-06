package decompiler.tags
{
	import flash.utils.ByteArray;
	
	public class JPEGTablesTag extends SWFTag
	{
		public function JPEGTablesTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
	}
}
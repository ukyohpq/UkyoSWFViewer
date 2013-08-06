package decompiler.tags
{
	import flash.utils.ByteArray;
	
	public class ProductInfoTag extends SWFTag
	{
		public function ProductInfoTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
	}
}
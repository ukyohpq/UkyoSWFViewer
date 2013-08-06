package decompiler.tags
{
	import flash.utils.ByteArray;
	
	public class PlaceFunctionTag extends SWFTag
	{
		public function PlaceFunctionTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
	}
}
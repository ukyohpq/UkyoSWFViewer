package decompiler.tags.controlTags
{
	import decompiler.tags.SWFTag;
	
	import flash.utils.ByteArray;
	
	public class AbstractControlTag extends SWFTag
	{
		public function AbstractControlTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
	}
}
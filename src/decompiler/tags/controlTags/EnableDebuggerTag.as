package decompiler.tags.controlTags
{
	import flash.utils.ByteArray;
	
	public class EnableDebuggerTag extends AbstractControlTag
	{
		public function EnableDebuggerTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
	}
}
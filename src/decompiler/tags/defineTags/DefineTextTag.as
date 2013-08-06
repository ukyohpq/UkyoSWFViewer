package decompiler.tags.defineTags
{
	import flash.utils.ByteArray;
	
	public class DefineTextTag extends AbstractDefineTag
	{
		public function DefineTextTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
	}
}
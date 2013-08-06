package decompiler.tags.defineTags
{
	import decompiler.tags.SWFTag;
	
	import flash.utils.ByteArray;
	
	public class AbstractDefineTag extends SWFTag
	{
		protected var $charactorID:int;
		public function AbstractDefineTag(id:int, data:ByteArray, preFix:String="")
		{
			super(id, data, preFix);
		}
	}
}
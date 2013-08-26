package decompiler.tags.defineTags
{
	import decompiler.tags.SWFTag;
	
	import flash.utils.ByteArray;
	
	public class AbstractDefineTag extends SWFTag
	{
		protected var $charactorID:int;

		public function get charactorID():int
		{
			return $charactorID;
		}

		public function set charactorID(value:int):void
		{
			$isModified = true;
			$charactorID = value;
		}

		public function AbstractDefineTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
	}
}
package decompiler.tags.controlTags
{
	import flash.utils.ByteArray;
	
	public class ScriptLimitsTag extends AbstractControlTag
	{
		private var _maxRecursionDepth:int;
		private var _scriptTimeoutSeconds:int;
		public function ScriptLimitsTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
		
		override protected function encodeData():void
		{
			super.encodeData();
		}
		
		override protected function realDecode():void
		{
			_maxRecursionDepth = $data.readShort();
			_scriptTimeoutSeconds = $data.readShort();
			trace(preFix + "MaxRecursionDepth:" + _maxRecursionDepth + " ScriptTimeoutSeconds:" + _scriptTimeoutSeconds);
		}
		
		
	}
}
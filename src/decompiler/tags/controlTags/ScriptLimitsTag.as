package decompiler.tags.controlTags
{
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	
	public class ScriptLimitsTag extends AbstractControlTag
	{
		private var _maxRecursionDepth:int;

		public function get maxRecursionDepth():int
		{
			return _maxRecursionDepth;
		}

		public function set maxRecursionDepth(value:int):void
		{
			$isModified = true;
			_maxRecursionDepth = value;
		}

		private var _scriptTimeoutSeconds:int;

		public function get scriptTimeoutSeconds():int
		{
			return _scriptTimeoutSeconds;
		}

		public function set scriptTimeoutSeconds(value:int):void
		{
			$isModified = true;
			_scriptTimeoutSeconds = value;
		}

		public function ScriptLimitsTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
		
		override protected function encodeData():void
		{
			$data.writeShort(_maxRecursionDepth);
			$data.writeShort(_scriptTimeoutSeconds);
		}
		
		override protected function realDecode():void
		{
			_maxRecursionDepth = $data.readShort();
			_scriptTimeoutSeconds = $data.readShort();
//			trace("MaxRecursionDepth:" + _maxRecursionDepth + " ScriptTimeoutSeconds:" + _scriptTimeoutSeconds);
		}
		
		override protected function contentToXML(xml:SWFXML):void
		{
			xml.appendChild("<MaxRecursionDepth>" + _maxRecursionDepth + "</MaxRecursionDepth>");
			xml.appendChild("<ScriptTimeoutSeconds>" + _scriptTimeoutSeconds + "</ScriptTimeoutSeconds>");
		}
		
		
	}
}
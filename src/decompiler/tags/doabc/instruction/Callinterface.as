package decompiler.tags.doabc.instruction
{
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Undocumented
	 * @author ukyohpq
	 * 
	 */
	public class Callinterface extends AbstractInstruction
	{
		private var index:uint;
		public function Callinterface()
		{
			super();
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			index = SWFUtil.readU30(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, index);
			super.encodeBody(byte);
		}
		
		override public function getForm():int
		{
			return 77;
		}
		
		override public function getName():String
		{
			return "callinterface";
		}
		
//		override public function toString():String
//		{
//			return "[ callinterface name:" + $abcFile.getMultinameByIndex(index) + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "name:" + $abcFile.getMultinameByIndex(index);
		}
		
		override public function getParams():Vector.<int>
		{
			return new <int>[index];
		}
		
		override public function getParamNames():Vector.<String>
		{
			return new <String>["index"];
		}
		
		override protected function paramsToXML(xml:SWFXML):void
		{
			xml.appendChild("<name>" + index + "</name>");
		}
		
		
	}
}
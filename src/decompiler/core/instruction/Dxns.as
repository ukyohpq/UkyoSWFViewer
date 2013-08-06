package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.tags.doabc.ABCFile;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		dxns
		index
	 * index is a u30 that must be an index into the string constant pool. 
	 * The string at index is used as the uri for the default XML namespace for this method.
	 * @author ukyohpq
	 * 
	 */
	public class Dxns extends AbstractInstruction
	{
		private var index:uint;
		public function Dxns()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 6;
		}
		
		override public function getName():String
		{
			return "dxns";
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			index = SWFUtil.readU30(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, index);
		}
		
//		override public function toString():String
//		{
//			return "[ dxns name:" + ABCFile.getInstance().getStringByIndex(index) + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "name:" + ABCFile.getInstance().getStringByIndex(index);
		}
		
		
	}
}
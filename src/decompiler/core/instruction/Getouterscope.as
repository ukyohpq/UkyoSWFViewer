package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.tags.doabc.ABCFile;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Undocumented
	 * @author ukyohpq
	 * 
	 */
	public class Getouterscope extends AbstractInstruction
	{
		private var index:uint;
		public function Getouterscope()
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
		}
		
		override public function getForms():int
		{
			return 103;
		}
		
		override public function getName():String
		{
			return "getouterscope";
		}
		
//		override public function toString():String
//		{
//			return "[ getouterscope name:" + ABCFile.getInstance().getMultinameByIndex(index) + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "name:" + ABCFile.getInstance().getMultinameByIndex(index);
		}
		
		
	}
}
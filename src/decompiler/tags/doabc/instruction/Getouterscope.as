package decompiler.tags.doabc.instruction
{
	import decompiler.tags.doabc.ABCFile;
	import decompiler.utils.SWFUtil;
	
	import flash.utils.ByteArray;

	/**
	 * Undocumented
	 * III(0x67, L_getouterscope)
	 * INSTR(getouterscope) {
  2654                 u1 = U30ARG;  // scope_index
  2655 				*(++sp) = scope->getScope((uint32_t)u1);
  2656                 NEXT;
  2657             }
	 * @author ukyohpq
	 * 
	 */
	public class Getouterscope extends UndocumentedInstruction
	{
		private var _index:uint;

		public function get index():uint
		{
			return _index;
		}

		public function set index(value:uint):void
		{
			_index = value;
		}

		public function Getouterscope()
		{
			super();
		}
		
		override protected function pcodeDecodeFromBytes(byte:ByteArray):void
		{
			_index = SWFUtil.readU30(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, _index);
		}
		
		override public function getForm():int
		{
			return 103;
		}
		
		override public function getName():String
		{
			return "getouterscope";
		}
		
//		override public function toString():String
//		{
//			return "[ getouterscope name:" + $abcFile.getMultinameByIndex(index) + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "name:" + $abcFile.getMultinameByIndex(_index);
		}
		
		
	}
}
package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.tags.doabc.ABCFile;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		debugfile
		index
	 * index is a u30 that must be an index into the string constant pool 
	 * If the debugger is running, then this instruction sets 
	 * the current file name in the debugger to the string at 
	 * position index of the string constant pool. 
	 * This lets the debugger know which instructions are 
	 * associated with each source file. 
	 * The debugger will treat all instructions as 
	 * occurring in the same file until a new debugfile opcode is encountered. 
	 * This instruction must occur before any debugline opcodes.
	 * @author ukyohpq
	 * 
	 */
	public class Debugfile extends AbstractInstruction
	{
		private var index:uint;
		public function Debugfile()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 241;
		}
		
		override public function getName():String
		{
			return "debugfile";
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
//			return "[ debugfile name:" + ABCFile.getInstance().getStringByIndex(index) + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "name:" + ABCFile.getInstance().getStringByIndex(index);
		}
		
		
	}
}
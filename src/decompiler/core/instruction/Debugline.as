package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		debugline
		linenum
	 * linenum is a u30 that indicates the current line 
	 * number the debugger should be using for the code currently executing. 
	 * Adobe ActionScript Virtual Machine 2 (AVM2) 
	 * Overview 54 If the debugger is running, 
	 * then this instruction sets the current line number in the debugger. 
	 * This lets the debugger know which instructions 
	 * are associated with each line in a source file. 
	 * The debugger will treat all instructions as occurring 
	 * on the same line until a new debugline opcode is encountered.
	 * @author ukyohpq
	 * 
	 */
	public class Debugline extends AbstractInstruction
	{
		private var linenum:uint;
		public function Debugline()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 240;
		}
		
		override public function getName():String
		{
			return "debugline";
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			linenum = SWFUtil.readU30(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, linenum);
		}
		
//		override public function toString():String
//		{
//			return "[ debugline linenum:" + linenum + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "linenum:" + linenum;
		}
		
		
	}
}
package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.tags.doabc.ABCFile;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		debug
		debug_type
		index
		reg
		extra
	 * 
	 * debug_type is an unsigned byte. 
	 * If the value of debug_type is DI_LOCAL (1), 
	 * then this is debugging information for a local register. 
	 * 
	 * index is a u30 that must be an index into the string constant pool. 
	 * The string at index is the name to use for this register. 
	 * 
	 * reg is an unsigned byte and is the index of the register 
	 * that this is debugging information for. 
	 * 
	 * extra is a u30 that is currently unused. 
	 * 
	 * Adobe ActionScript Virtual Machine 2 (AVM2) Overview 53 
	 * When debug_type has a value of 1, 
	 * this tells the debugger the name to display 
	 * for the register specified by reg. 
	 * If the debugger is not running, then this instruction does nothing.
	 * @author ukyohpq
	 * 
	 */
	public class Debug extends AbstractInstruction
	{
		private var debug_type:uint;
		private var index:uint;
		private var reg:uint;
		private var extra:uint;
		public function Debug()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 239;
		}
		
		override public function getName():String
		{
			return "debug";
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			debug_type = byte.readUnsignedByte();
			index = SWFUtil.readU30(byte);
			reg = byte.readUnsignedByte();
			extra = SWFUtil.readU30(byte);
			super.decodeFromBytes(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			byte.writeByte(debug_type);
			SWFUtil.writeU30(byte, index);
			byte.writeByte(reg);
			SWFUtil.writeU30(byte, extra);
		}
		
//		override public function toString():String
//		{
//			return "[ debug debug_type:" +
//				debug_type + 
//				" name:" + ABCFile.getInstance().getStringByIndex(index) +
//				" reg:" + reg +
//				" extra:" + extra + 
//				" ]";
//		}
		
		override protected function stringBody():String
		{
			return "debug_type:" +
			debug_type + 
			" name:" + ABCFile.getInstance().getStringByIndex(index) +
			" reg:" + reg +
			" extra:" + extra;
		}
		
		
	}
}
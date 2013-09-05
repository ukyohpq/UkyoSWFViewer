package decompiler.tags.doabc.instruction.jump
{
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Format
		ifgt
		offset
	 * 	offset is an s24 that is the number of bytes to jump if value1 is greater than or equal to value2.
		Compute value2 < value1 using the abstract relational comparison algorithm in ECMA-262
		section 11.8.5. If the result of the comparison is true, jump the number of bytes indicated
		by offset. Otherwise continue executing code from this point.
	 * @author ukyohpq
	 * 
	 */
	public class Ifgt extends JumpSet
	{
		public function Ifgt()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 23;
		}
		
		override public function getName():String
		{
			return "ifgt";
		}
		
//		override public function toString():String
//		{
//			return "[ ifgt offset:" + offset + " ]";
//		}
		
		override public function deltaNumStack():int
		{
			return -2;
		}
	}
}
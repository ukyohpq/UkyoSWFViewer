package decompiler.tags.doabc.instruction
{
	/**
	 * Undocumented
	 * VerifyError: Error #1011: 方法 global$init() 包含非法 opcode 154 (偏移量为 36)。
	 * 没找到，avm2已经不认了
	 * @author ukyohpq
	 * 
	 */
	public class Concat extends UnrecognizedInstruction
	{
		public function Concat()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 154;
		}
		
		override public function getName():String
		{
			return "concat";
		}
		
		
	}
}
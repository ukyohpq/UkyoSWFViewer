package decompiler.tags.doabc.instruction
{
	/**
	 * Undocumented
	 * VerifyError: Error #1011: 方法 global$init() 包含非法 opcode 75 (偏移量为 19)。
	 * 发现已经被注释，avm2已经不认了
	 * @author ukyohpq
	 * 
	 */
	public class Callsuperid extends UnrecognizedInstruction
	{
		public function Callsuperid()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 75;
		}
		
		override public function getName():String
		{
			return "callsuperid";
		}
		
		
	}
}
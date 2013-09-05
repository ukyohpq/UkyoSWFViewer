package decompiler.tags.doabc.instruction
{
	/**
	 * Undocumented
	 * VerifyError: Error #1011: 方法 global$init() 包含非法 opcode 107 (偏移量为 14)。
	 * 没找到，avm2已经不认了
	 * @author ukyohpq
	 * 
	 */
	public class Deletepropertylate extends UnrecognizedInstruction
	{
		public function Deletepropertylate()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 107;
		}
		
		override public function getName():String
		{
			return "deletepropertylate";
		}
		
		
	}
}
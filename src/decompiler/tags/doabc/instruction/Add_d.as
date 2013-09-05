package decompiler.tags.doabc.instruction
{
	/**
	 * Undocumented
	 * VerifyError: Error #1011: 方法 global$init() 包含非法 opcode 155 (偏移量为 38)。
	 * 没找到，而且貌似avm也不认了
	 * @author ukyohpq
	 * 
	 */
	public class Add_d extends UnrecognizedInstruction
	{
		public function Add_d()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 155;
		}
		
		override public function getName():String
		{
			return "add_d";
		}
		
		
	}
}
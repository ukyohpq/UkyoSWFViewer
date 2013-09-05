package decompiler.tags.doabc.instruction
{
	/**
	 * Undocumented
	 * VerifyError: Error #1011: 方法 SDFASDFSDF() 包含非法 opcode 245 (偏移量为 27)。
	 * 没找到,avm2已经不认了
	 * @author ukyohpq
	 * 
	 */
	public class Verifypass extends UnrecognizedInstruction
	{
		public function Verifypass()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 245;
		}
		
		override public function getName():String
		{
			return "verifypass";
		}
		
		
	}
}
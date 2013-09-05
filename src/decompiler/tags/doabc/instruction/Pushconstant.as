package decompiler.tags.doabc.instruction
{
	/**
	 * Undocumented  push constant(常数)
	 * VerifyError: Error #1011: 方法 SDFASDFSDF() 包含非法 opcode 34 (偏移量为 28)。
	 * 没找到，avm2已经不认了
	 * @author ukyohpq
	 * 
	 */
	public class Pushconstant extends UnrecognizedInstruction
	{
		public function Pushconstant()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 34;
		}
		
		override public function getName():String
		{
			return "pushconstant";
		}
		
		
	}
}
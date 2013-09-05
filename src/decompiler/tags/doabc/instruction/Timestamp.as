package decompiler.tags.doabc.instruction
{
	/**
	 * Undocumented
	 *  XXX(0xF3)  OP_timestamp 
	INSTR(timestamp) {
		1025                 NEXT;
		1026 			}
	 * @author ukyohpq
	 * 
	 */
	public class Timestamp extends UndocumentedInstruction
	{
		public function Timestamp()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 243;
		}
		
		override public function getName():String
		{
			return "timestamp";
		}
		
		
	}
}
package decompiler.tags.doabc.instruction
{
	/**
	 * Undocumented
	 * INSTR(coerce_o) {
 				if (sp[0] == undefinedAtom)
					sp[0] = nullObjectAtom;
 				NEXT;
 			}
这个尚未看到实例，不知道该怎么处理
	 * @author ukyohpq
	 * 
	 */
	public class Coerce_o extends UndocumentedInstruction
	{
		public function Coerce_o()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 137;
		}
		
		override public function getName():String
		{
			return "coerce_o";
		}
		
		
	}
}
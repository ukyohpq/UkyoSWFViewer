package decompiler.tags.doabc.instruction
{
	/**
	 * Undocumented
	 *  III(0x81, L_convert_b)   // coerce_b -> convert_b, they are the same
	 * INSTR(coerce_b) {

  1238 				goto convert_b_impl;

  1239 			}

	 * 貌似等于convert_b
	 * @author ukyohpq
	 * 
	 */
//	public class Coerce_b extends AbstractInstruction
	public class Coerce_b extends Convert_b
	{
		public function Coerce_b()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 129;
		}
		
		override public function getName():String
		{
			return "coerce_b";
		}
		
		
	}
}
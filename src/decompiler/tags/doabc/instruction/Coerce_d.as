package decompiler.tags.doabc.instruction
{
	/**
	 * Undocumented
	 * 貌似等于convert_d
	 * III(0x84, L_convert_d)   // coerce_d -> convert_d, they are the same
	 * INSTR(coerce_d) {

  1220 				goto convert_d_impl;

  1221 			}

	 * @author ukyohpq
	 * 
	 */
//	public class Coerce_d extends AbstractInstruction
	public class Coerce_d extends Convert_d
	{
		public function Coerce_d()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 132;
		}
		
		override public function getName():String
		{
			return "coerce_d";
		}
		
		
	}
}
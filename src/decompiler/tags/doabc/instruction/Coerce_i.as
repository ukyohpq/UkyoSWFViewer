package decompiler.tags.doabc.instruction
{
	/**
	 * Undocumented
	 * 貌似等于Convert_i
	 * III(0x83, L_convert_i)   // coerce_i -> convert_i, they are the same
	 * INSTR(coerce_i) {

  2748 				goto convert_i_impl;

  2749 			}

	 * @author ukyohpq
	 * 
	 */
//	public class Coerce_i extends AbstractInstruction
	public class Coerce_i extends Convert_i
	{
		public function Coerce_i()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 131;
		}
		
		override public function getName():String
		{
			return "coerce_i";
		}
		
		
	}
}
package decompiler.tags.doabc.instruction
{
	/**
	 * Undocumented
	 * 貌似和convert_u一样
	 *  III(0x88, L_convert_u)   // coerce_u -> convert_u, they are the same
	 * INSTR(coerce_u) {
 				goto convert_u_impl;
 			}

	 * @author ukyohpq
	 * 
	 */
//	public class Coerce_u extends AbstractInstruction
	public class Coerce_u extends Convert_u
	{
		public function Coerce_u()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 136;
		}
		
		override public function getName():String
		{
			return "coerce_u";
		}
		
		
	}
}
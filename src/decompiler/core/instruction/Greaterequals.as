package decompiler.core.instruction
{
	/**
	 * 此文档有误，Forms应该是176,文档误为175
	 * Format
		greaterthan
	 * 	Pop value1 and value2 off of the stack. Compute value1 < value2 using the Abstract
		Relational Comparison Algorithm, as described in ECMA-262 section 11.8.5. If the result of
		the comparison is false, push true onto the stack. Otherwise push false onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Greaterequals extends AbstractInstruction
	{
		public function Greaterequals()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 176;
		}
		
		override public function getName():String
		{
			return "greaterequals";
		}
		
		
	}
}
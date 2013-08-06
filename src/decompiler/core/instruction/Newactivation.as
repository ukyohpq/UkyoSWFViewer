package decompiler.core.instruction
{
	/**
	 * Format
		newactivation
	 * 	Creates a new activation object, newactivation, and pushes it onto the stack. Can only be
		used in methods that have the NEED_ACTIVATION flag set in their MethodInfo entry.
	 * @author ukyohpq
	 * 
	 */
	public class Newactivation extends AbstractInstruction
	{
		public function Newactivation()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 87;
		}
		
		override public function getName():String
		{
			return "newactivation";
		}
		
	}
}
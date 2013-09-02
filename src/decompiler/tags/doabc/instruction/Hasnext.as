package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		hasnext
	 * 	cur_index and obj are popped off of the stack. cur_index must be of type int. Get the index of
		the next property after the property at cur_index. If there are no more properties, then the
		result is 0. The result is pushed onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Hasnext extends AbstractInstruction
	{
		public function Hasnext()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 31;
		}
		
		override public function getName():String
		{
			return "hasnext";
		}
		
		override public function deltaNumStack():int
		{
			return -1;
		}
	}
}
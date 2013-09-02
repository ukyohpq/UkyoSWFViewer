package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		throw
	 * The top value of the stack is popped off the stack and then thrown. The thrown value can be
		of any type.When a throw is executed, the current method’s exception handler table is searched for an
		exception handler. An exception handler matches if its range of offsets includes the offset of
		this instruction, and if its type matches the type of the thrown object, or is a base class of the
		type thrown. The first handler that matches is the one used.
		If a handler is found then the stack is cleared, the exception object is pushed onto the stack,
		and then execution resumes at the instruction offset specified by the handler.
		If a handler is not found, then the method exits, and the exception is rethrown in the
		invoking method, at which point it is searched for an exception handler as described here.
	 * @author ukyohpq
	 * 
	 */
	public class Throw extends AbstractInstruction
	{
		public function Throw()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 3;
		}
		
		override public function getName():String
		{
			return "throw";
		}
		
		override public function deltaNumStack():int
		{
			return -1;
		}
	}
}
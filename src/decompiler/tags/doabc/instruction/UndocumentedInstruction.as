package decompiler.tags.doabc.instruction
{
	public class UndocumentedInstruction extends AbstractInstruction
	{
		public function UndocumentedInstruction()
		{
			super();
			trace("UndocumentedInstruction form:" + getForm() + " name:" + getName());
		}
	}
}
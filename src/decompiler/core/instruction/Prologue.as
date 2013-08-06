package decompiler.core.instruction
{
	public class Prologue extends AbstractInstruction
	{
		public function Prologue()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 249;
		}
		
		override public function getName():String
		{
			return "prologue";
		}
		
		
	}
}
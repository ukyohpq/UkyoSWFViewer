package decompiler.core.instruction
{
	public class Multiply extends AbstractInstruction
	{
		public function Multiply()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 162;
		}
		
		override public function getName():String
		{
			return "multiply";
		}
		
		
	}
}
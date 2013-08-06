package decompiler.core.instruction
{
	public class Sendenter extends AbstractInstruction
	{
		public function Sendenter()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 250;
		}
		
		override public function getName():String
		{
			return "sendenter";
		}
		
		
	}
}
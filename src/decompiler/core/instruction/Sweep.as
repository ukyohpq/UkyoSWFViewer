package decompiler.core.instruction
{
	public class Sweep extends AbstractInstruction
	{
		public function Sweep()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 252;
		}
		
		override public function getName():String
		{
			return "sweep";
		}
		
		
	}
}
package decompiler.core.instruction
{
	public class Setlocal_1 extends AbstractInstruction
	{
		public function Setlocal_1()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 213;
		}
		
		override public function getName():String
		{
			return "setlocal_1";
		}
		
		
	}
}
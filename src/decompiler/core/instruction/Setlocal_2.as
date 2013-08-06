package decompiler.core.instruction
{
	public class Setlocal_2 extends AbstractInstruction
	{
		public function Setlocal_2()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 214;
		}
		
		override public function getName():String
		{
			return "setlocal_2";
		}
		
		
	}
}
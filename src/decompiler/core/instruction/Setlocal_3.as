package decompiler.core.instruction
{
	public class Setlocal_3 extends AbstractInstruction
	{
		public function Setlocal_3()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 215;
		}
		
		override public function getName():String
		{
			return "setlocal_3";
		}
		
		
	}
}
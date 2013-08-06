package decompiler.core.instruction
{
	public class Getlocal_3 extends AbstractInstruction
	{
		public function Getlocal_3()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 211;
		}
		
		override public function getName():String
		{
			return "getlocal_3";
		}
	}
}
package decompiler.core.instruction
{
	public class Getlocal_1 extends AbstractInstruction
	{
		public function Getlocal_1()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 209;
		}
		
		override public function getName():String
		{
			return "getlocal_1";
		}
	}
}
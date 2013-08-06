package decompiler.core.instruction
{
	public class Getlocal_2 extends AbstractInstruction
	{
		public function Getlocal_2()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 210;
		}
		
		override public function getName():String
		{
			return "getlocal_2";
		}
	}
}
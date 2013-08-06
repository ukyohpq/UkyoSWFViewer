package decompiler.core.instruction
{
	public class Getglobalscope extends AbstractInstruction
	{
		public function Getglobalscope()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 100;
		}
		
		override public function getName():String
		{
			return "getglobalscope";
		}
		
		
	}
}
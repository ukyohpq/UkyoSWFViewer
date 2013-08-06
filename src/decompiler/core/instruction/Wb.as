package decompiler.core.instruction
{
	public class Wb extends AbstractInstruction
	{
		public function Wb()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 248;
		}
		
		override public function getName():String
		{
			return "wb";
		}
		
		
	}
}
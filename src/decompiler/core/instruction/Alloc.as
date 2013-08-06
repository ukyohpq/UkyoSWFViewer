package decompiler.core.instruction
{
	public class Alloc extends AbstractInstruction
	{
		public function Alloc()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 246;
		}
		
		override public function getName():String
		{
			return "alloc";
		}
		
		
	}
}
package decompiler.core.instruction
{
	public class Doubletoatom extends AbstractInstruction
	{
		public function Doubletoatom()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 251;
		}
		
		override public function getName():String
		{
			return "doubletoatom";
		}
		
		
	}
}
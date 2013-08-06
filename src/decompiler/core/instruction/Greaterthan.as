package decompiler.core.instruction
{
	public class Greaterthan extends AbstractInstruction
	{
		public function Greaterthan()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 175;
		}
		
		override public function getName():String
		{
			return "greaterthan";
		}
	}
}
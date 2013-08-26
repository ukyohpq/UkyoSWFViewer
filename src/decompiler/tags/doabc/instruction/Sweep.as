package decompiler.tags.doabc.instruction
{
	public class Sweep extends AbstractInstruction
	{
		public function Sweep()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 252;
		}
		
		override public function getName():String
		{
			return "sweep";
		}
		
		
	}
}
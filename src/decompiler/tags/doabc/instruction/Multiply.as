package decompiler.tags.doabc.instruction
{
	public class Multiply extends AbstractInstruction
	{
		public function Multiply()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 162;
		}
		
		override public function getName():String
		{
			return "multiply";
		}
		
		
	}
}
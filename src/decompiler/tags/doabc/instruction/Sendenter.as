package decompiler.tags.doabc.instruction
{
	public class Sendenter extends AbstractInstruction
	{
		public function Sendenter()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 250;
		}
		
		override public function getName():String
		{
			return "sendenter";
		}
		
		
	}
}
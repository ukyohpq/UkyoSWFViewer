package decompiler.tags.doabc.instruction
{
	public class Verifyop extends AbstractInstruction
	{
		public function Verifyop()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 254;
		}
		
		override public function getName():String
		{
			return "verifyop";
		}
		
		
	}
}
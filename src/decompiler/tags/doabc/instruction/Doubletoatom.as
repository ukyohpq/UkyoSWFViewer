package decompiler.tags.doabc.instruction
{
	public class Doubletoatom extends AbstractInstruction
	{
		public function Doubletoatom()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 251;
		}
		
		override public function getName():String
		{
			return "doubletoatom";
		}
		
		
	}
}
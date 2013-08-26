package decompiler.tags.doabc.instruction
{
	public class Greaterthan extends AbstractInstruction
	{
		public function Greaterthan()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 175;
		}
		
		override public function getName():String
		{
			return "greaterthan";
		}
	}
}